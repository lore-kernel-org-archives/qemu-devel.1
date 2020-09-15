Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3D2C2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7290A21974
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UwJrrlWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7290A21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI77q-0004SC-Cr
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 05:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI76z-0003uL-1j; Tue, 15 Sep 2020 05:18:53 -0400
Received: from mail-eopbgr130127.outbound.protection.outlook.com
 ([40.107.13.127]:63447 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI76q-0002A9-D5; Tue, 15 Sep 2020 05:18:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD3XlNb9Wcoo8m5xKeucEAhy9nQkZz1SOXJ6Jd7yBuWGGNsKgBozVn/IUgP901lk/QH/BeTBxJrCFFy9EdgWHzurNK0LUbvKjplnwWyXsPI0cGjZtkBRC4+OxekxaTx4fCQjkoQ7mfeLdJSk3uHtrfEpG2hT1SJ3xcUZQfON/tpgZcVncdUk9SrLXm6m3PnS/0T70gL44HkRyxcrwnb4jBSsimH4gcVfr6DHg74+4w2iUxWeT2iyv3wJkW0YEKgzdMgdjhkIBv/grhCDlsrl4A+30HrG5v2X5g9cSXYdhj0kqtAyv9c6NIlFjUt7hkvLW7c00oTAsrwEV2RlMsCz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isnl9rd1zyqdv/Ry/EKV/wpMhRYLcLnGTw6ZgUCvc/Q=;
 b=KMQAJpiNxG27jE1nyv0zWcDTHo5IhqJdH6nWXUTZ57IFhCzVqKlDJUWwmpHoSnguyqYuYG2niQn7HYpvm6k1kY2Yl0VFyvjFkGDWiZzYB56SKBXVDOKseI98MkohYUeMOEaazGaIn3OWmb6z2UPSfhkRBTBKsrTzHymB5acVS+lXczrRlikZ1MzDnvCfGDOKDopx2AkaRtKGaBtIRbLjdUlk7n8VPtanX33ZMU+YWzLAFiCH13W3V2wi513/qwO4QaKvPiqmdn5q+KJvBAanOMV3J2Ghu7sj67eaWVpC2RSWM8No6cvPoIfiTSMJyK24cw4bbTxcvPSTaXQtVSFqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isnl9rd1zyqdv/Ry/EKV/wpMhRYLcLnGTw6ZgUCvc/Q=;
 b=UwJrrlWOTGcnorvppcpTUxs7KO4eEIi65lJ+TLvVgZkyqn3Xh1FflbY03VXbPhNJP3fKoyxd61oj84ZiVDkNanG3QvkctgSbXYUfwPBJPE0zCuyoUYmdOXs9kdEw6Ydy41rsAQEaBh96FiimeudIzzfB1GX8npTr2zZoj6il5Zk=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3864.eurprd08.prod.outlook.com (2603:10a6:20b:8e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 09:18:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 09:18:37 +0000
Subject: Re: [PATCH 02/15] ppc: Add a return value to ppc_set_compat() and
 ppc_set_compat_all()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-3-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <16946c40-751c-dfa8-a72a-f8575f6eb9a8@virtuozzo.com>
Date: Tue, 15 Sep 2020 12:18:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-3-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.8 via Frontend Transport; Tue, 15 Sep 2020 09:18:37 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0053d14-7c6c-4671-662f-08d859585415
X-MS-TrafficTypeDiagnostic: AM6PR08MB3864:
X-Microsoft-Antispam-PRVS: <AM6PR08MB38649F16909187F3A84A0CFFC1200@AM6PR08MB3864.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zou/CxeLAfr59RtLNFgzIEwnLiGhAhh3BfNQzpMvCt/u3Dzd+Tf2WaWjrcocoK2CqaFiGzQuYEYVssgErcY3/xr9lBu0Fp3wO9tXcfOYlruTVtLt9G0MfiTNuFDHTIgVLG5CQ6zyzFaQNmPY9N4lH5IffSbqvTO6PYaICu/c45ahk1M2HZrkydGbekud/Et0wLqu695pAJIpt3Oz6VMhfgMPdjnmPkZEAmOuDPgs9D3CGS7b0D+9v+WRBxrOFXGwLiAGjdpaVbqmNk7STeu7aruERy7ClUm7eJw/o6NYY4OYcv3vU5DYgjx9raLjhmlvxdXWv62LmG1Z+DRn2043SybxStJ2sCI+KJWzXImcAAeHJidoADclJGgutCDK/fA1x2o/uEeYTutFeQul1rujR7vuH9Y4iPkZiVO+vcXxHXjD7yl3b1uBule0PDjuSEOg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(346002)(376002)(366004)(136003)(16526019)(186003)(4326008)(26005)(83380400001)(31686004)(316002)(8936002)(36756003)(956004)(2616005)(31696002)(16576012)(8676002)(86362001)(6486002)(52116002)(478600001)(4744005)(2906002)(54906003)(5660300002)(66946007)(66476007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: P3p+hgxP0x3UUumHx3UEtxWNvb2WUX0a0hchMOEXnLe3ruJAGHvNZxEnoImXoBRZkNJsd3KU/fJELD6M22NwH5yvXOvjlAhpmkulKFX6UljMs4Dh5eAZOmvbuW6Sn108hW68Ct1FVscV9AWTSB7YZlKT7mp8utsJr/sjwP90dD0AfbZKUo2LzXp3V1dcUcpCfYKcmwq4cDnqGyWwSTEam7xEuYqUdOzcVfTvVpeiYy192GyiFTAWqlva/4Vh8neH+mWkhgPUHeeLlJ7B9flE/KjlTf9Cm+nxhTLxwnNkdtbmOSsYKvIolXc3yeyfBZo0r4Vi8IsfUt06eaB5Jn5W+zXqcwW7EzM39cyZ2JC2ModNEY29sqTQiQkpQMG0N3mJj+9/vGC56+y6IAmOk+66cATK2Dj3vFNtIqJe1/KEP2DV936t9ogWB3gnlpcTJ5ywEQreQEpdd8K7HG8LpT8H6OIJewKBqSSWLjY7LeVWaZLvzjnkEejgYjEcU+KS8KZaonSLz3ZyoOb1sRriUWnfol8TIKrTgdJXPsxHvZbebPBfXYej1/Q0HdxtoP7RPsIS3/fTy4qXo+E/FQN+iWkoFDTF61KfuDmWjhjhdw6M1+lVciuWCvpyEdlPBWU5/DljXhBR2KPi/aIkAAGOGigHUg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0053d14-7c6c-4671-662f-08d859585415
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 09:18:37.6673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1T6XhBjsFUbkmNTZXvMwLKP35CDYguNKnsaHdSKYH8COhGuB9bYIim7L8LJsI63voDCe+dyDg7EBYfxGgTA+MAa2HHAmc+dp+2SVvfuVv+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3864
Received-SPF: pass client-ip=40.107.13.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 05:18:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.09.2020 15:34, Greg Kurz wrote:
> As recommended in "qapi/error.h", indicate success / failure with a
> return value. Since ppc_set_compat() is called from a VMState handler,

What handler do you mean? You don't update any handlers here..

> let's make it an int so that it propagates any negative errno returned
> by kvmppc_set_compat(). Do the same for ppc_set_compat_all() for
> consistency, even if it isn't called in a context where a negative errno
> is required on failure.
> 
> This will allow to simplify error handling in the callers.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

patch is OK:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

