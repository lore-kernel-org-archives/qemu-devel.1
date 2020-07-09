Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CDCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5182E206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="CuIuFEej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5182E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSZA-0000b5-Kc
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1jtSYI-0008Dz-Oj
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:09:10 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:62663 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1jtSYG-0006Co-9Z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:09:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7p/KyqmZ8iL2b9a0TSDaPqCqydAteFpvMw118rplcUYAVWrYDpIG3qcWfgOD8JdFI5QE+GC9kUswIRtmJZzpAcf63h/9lgTh2tfF9ieG7QMv44hy5p6FcD5u647Q+nhibhkknzNQ9oKMdIw8ms8chNtQu2iF3Wq8pR6PeslVcpxRhy+u48wgH2Oyhm0Uqbb4yNs19JFwbA7sTaYOwjxpWHt904MCqfIAvOoA1FJhgwneFMe+TtQSYfCIUfFc2cXnzBegueVxcGSgxefwb+KIuDqargoOtHdnV0Ov5OReMt1Hxx9T1l7KK2h/QvPf1KQcYjrCHUjSb3bKFHbFVC4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9TzhTUYILa/I2kFf9BMmGBn1s3A8cF9f6tkJTPZEcA=;
 b=KRBNnfI9NJWbKBLJqJYt/U7fgFxdLp9v9Fs3bfgePqmUvhfA+OZh4YWk4+pIk27bo7vjeh3TaG/rlLe7hcEvSH+LWWrn/ejhpIaRDNZQMnP5sDLtSvITxU1Zeck8EjN1kgfFR7hN2h6g0DF2LnmvRpw/WVW6K5jlmNeyEDQ2rIMYCmD2WvQ7kYsq6/W+Kj8kUke3968raOx3OujQUo3nOvBRTQjJql9vj7/Fsz1SLUN8n0KH1ItUoMiqn6djG+dG0y0F4g09zcuei9/gfO9zwKnbTVI1qdMJCHwUXriPDi/A2ASrX8sOCpevz6sdr8g+QFtWrQHhEzuKu5icPkEU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9TzhTUYILa/I2kFf9BMmGBn1s3A8cF9f6tkJTPZEcA=;
 b=CuIuFEejZ1K3uDqqVlEUknT2XIG36Q8YeggAVRfkL13Ra5vEisaOwIgxGSc0W6CTW+J05+dss1CLeB8oGj2g9PEFga9M0TI/IIUOD6f/L68CQuW4t0UfJaRvUmcXJTPOeMmMVdXost8v/V1+YliRjkF0T0y+CtfYGhYBr74j9AE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM5PR0801MB1843.eurprd08.prod.outlook.com (2603:10a6:203:3a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 08:54:04 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 08:54:03 +0000
Subject: Re: [PATCH 2/2] util/qemu-sockets: make keep-alive enabled by default
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
 <20200708191540.28455-3-vsementsov@virtuozzo.com>
 <20200709082954.GD3753300@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <a59b626e-c54a-1619-9b67-d699971c5816@openvz.org>
Date: Thu, 9 Jul 2020 11:54:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200709082954.GD3753300@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0202CA0029.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::15) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0202CA0029.eurprd02.prod.outlook.com (2603:10a6:3:e4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 08:54:02 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03bab910-25a4-4242-bccb-08d823e5a15a
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB18436FEC33E13B9D6543A08DB6640@AM5PR0801MB1843.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZVX/W9dEYXSjuX0nwA5f5NKpRjjBhknYXctNN/LypXgD5w5HT/qjOBt3LB3vcu2bWpPBKd+yjnqJY6nSSzcpn8y6FiZp7MrQgSp8Q3upUrFwrY+ybBCC3VBL3QaBOPQp8Y+UKR4T9RsGVZYqnWhjKxDbaphI0MDRGkBZEnX1REb1SyP/N7pR7XWrRytxvaotmyYbXeIvRzJSsKjzQm3rfHXMmbuRRmVRNjMBC0aCPpSHvlOOeNz21mUzn1FBDNRUrNjxm3UnRDuBrw0PQ88YyxuRqy8S/POm+dyPsdCumHIUlZ1xGwtstJ6SZeGinGH49IwDYQ6lq5Xut4+xq6Vj3sJWOmtytejANi+PH3piKvgr9oQID/OQdzbrFJFf0gD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(396003)(376002)(346002)(366004)(110136005)(36756003)(31696002)(478600001)(31686004)(66946007)(26005)(186003)(16526019)(53546011)(2616005)(316002)(4326008)(42882007)(956004)(16576012)(2906002)(52116002)(83170400001)(83380400001)(8676002)(8936002)(5660300002)(66556008)(66476007)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aCRfw6uPGXZC69VRJw+Npc2DSQ+sVu+9CQgzA6m3Jdwmq6A//KGWrRacU6s62IDtk2iKqciGZ+Kx51PE5x5m1ES3TE+bZlgZ/HPTyZdgrzwg19kOZ0HPu99VhQnJpO8kqRtUiHBBwgVOgWwozfNs4CVDJI9H1gmpU7HLq/XbCRuhK5RO+XTcu18EkI3m1exor5k7YoalESaaMYbcHCb8rdq+jTxr0R4A58bSA6iICWIZgZABPQpwFgLRzWR3QEKCV35ghsvMZZpCSXsOHGtkv1VkWZb9XNvdUnBKwEo5yyyEjtO05GBSHt9KP44RzN+SgwTrPI4jbn9y+aEy+GuhZKpPiJw6FRL5RgG4zY0zQz6FNzX6YVQtrGlC0H9ZIdK01nRGSX3CtlGsNl/oSI2gOoH17litqh6xZM8oq6MER1p7OEgdY22qZFl8YVQCamCKp7YKWkN6ZNKMAs8VH1XA86rE00OCRhLkrVgXsZjEAADrKAa+qd9qtzLES3yF5V+U
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bab910-25a4-4242-bccb-08d823e5a15a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 08:54:03.7404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pffLfN3M8BPea5TmZd23olGKpVeFGD+uX9GD/YMyDo4HLjMGGVgkJlxpSHirrDCr/57vnjAKaGboF2f1hWlB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1843
Received-SPF: pass client-ip=40.107.7.97; envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 05:09:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 11:29 AM, Daniel P. Berrangé wrote:
> On Wed, Jul 08, 2020 at 10:15:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Keep-alive won't hurt, let's try to enable it even if not requested by
>> user.
> Keep-alive intentionally breaks TCP connections earlier than normal
> in face of transient networking problems.
>
> The question is more about which type of pain is more desirable. A
> stall in the network connection (for a potentially very long time),
> or an intentionally broken socket.
>
> I'm not at all convinced it is a good idea to intentionally break
> /all/ QEMU sockets in the face of transient problems, even if the
> problems last for 2 hours or more. 
>
> I could see keep-alives being ok on some QEMU socket. For example
> VNC/SPICE clients, as there is no downside to proactively culling
> them as they can trivially reconnect. Migration too is quite
> reasonable to use keep alives, as you generally want migration to
> run to completion in a short amount of time, and aborting migration
> needs to be safe no matter what.
>
> Breaking chardevs or block devices or network devices that use
> QEMU sockets though will be disruptive. The only solution once
> those backends have a dead socket is going to be to kill QEMU
> and cold-boot the VM again.

nope, and this is exactly what we are trying to achive.

Let us assume that QEMU NBD is connected to the
outside world, f.e. to some HA service running in
other virtual machine. Once that far away VM is
becoming dead, it is re-started on some other host
with the same IP.

QEMU NBD has an ability to reconnect to this same
endpoint and this process is transient for the guest.

This is the workflow we are trying to improve.

Anyway, sitting over dead socket is somewhat
which is not productive. This is like NFS hard and
soft mounts. In hypervisor world using hard mounts
(defaults before the patch) leads to various non
detectable deadlocks, that is why we are proposing
soft with such defaults.

It should also be noted that this is more consistent
as we could face the problem if we perform write
to the dead socket OR we could hang forever, thus
the problem with the current state is still possible.
With new settings we would consistently observe
the problem.

Den

