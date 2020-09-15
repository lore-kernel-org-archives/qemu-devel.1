Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB9DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8BF21D43
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZeYht1S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8BF21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8qk-00059o-Du
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8Zm-0000uZ-Ft; Tue, 15 Sep 2020 06:52:43 -0400
Received: from mail-vi1eur05on2093.outbound.protection.outlook.com
 ([40.107.21.93]:7776 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI8Zk-0005L4-Je; Tue, 15 Sep 2020 06:52:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klsqjWhgPXpqWwGvXO5HBv8H0+EukC4bIY/h1nKmxLTfn0c2RYhPgZZOnCRzrDRo0nmrcC6Tl0mfjEj5U9DQGsXAEsJKujOfn0PydkDf+/e6sXz0ZVZtRI78i+/cHBQ/1OVDK9MtlrfRnLH0yuWcP4aKVyV57Q4S+U4jlKjvEgEROJZSI+sQYoLDFz7bF0JVi2zEAiTaQBfvSjgMmPCRO+hfuuvApQ8HYPVeVtVJwi/Ccb1RiBrtVZnzWvRwSt5Pb45NYTtf35gc/ZGyQObKpFZKuL0Bs3b9Lrrh7gyIcynGYjs9YVDKV9Q4agbYGR5xJfAUuUqOM4UR2Sob2di0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMCam6a7dFTs7ZpwUsGumT1lRi53UPBT6C9Odb17ZjM=;
 b=m5fYCyR5bG1NxyMsCKsb3f9ayETiQIBF9ggli1rDlOKN0tWvbkQr2dUIOOtiXMoFYHxz81fqVHVIo1yZnXkkBWuTYHGzg3jRVIuEiGKQGEw/5NSLzLy8NLkzksj+WiNMcrhj0HjyTmE1VR77LVYzhRV0jl1bF3fpdB6awMQAI3CaIiHoQSvLtUsrZEKKxuCv+XT2Bm53VjHG+uF/nbp0j1XA/2XI16IVRzd2KiaKRrSA31MkTl7TXV4bqR3QzmDpFkJi6ZEApiNrtVwFyp4Rdk9yQ6RZXPpy5Bu0cBcvpbs5ws18RuZiu4cZLx1TuzWh7HjwfUQPZwxbKz07XpxMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMCam6a7dFTs7ZpwUsGumT1lRi53UPBT6C9Odb17ZjM=;
 b=ZeYht1S07YRsdS6WyCisvtp+PhZbLIjYZZL9ODi9axA1gaZbdR3ZPdBklJdYPEOPLf7ua98rAptquc+ZOxAEJylFyUO3tOOYWQ0KTnW1OD/lkrmw+OLIBXQ7o6/bwBH68dlcJpYBizDvdP5G4GX34e+dYkscNosRMEhB5i4Hm+A=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5207.eurprd08.prod.outlook.com (2603:10a6:20b:ea::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 10:52:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 10:52:36 +0000
Subject: Re: [PATCH 13/15] spapr: Add a return value to spapr_check_pagesize()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-14-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <77cdb6de-8fb8-c479-f41a-8ddf5eabce50@virtuozzo.com>
Date: Tue, 15 Sep 2020 13:52:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-14-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR01CA0155.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Tue, 15 Sep 2020 10:52:36 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bffd1dda-d53f-4b75-cfa5-08d85965752c
X-MS-TrafficTypeDiagnostic: AM6PR08MB5207:
X-Microsoft-Antispam-PRVS: <AM6PR08MB520745C701E62C753F42AF3FC1200@AM6PR08MB5207.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjlQ78CGpumFRisevWJ3DNtuwGaqU0MR3RfNToFtanX1JhriecpV0P2eHvrP7k+XvMXX8ijYmm2XEZnBk9/OgTMATVPTduHp5eeoeDz2KTZ9WmlnDU4Ash/tmLezOfP+r23ncwkePgdXWBuYOKHuS4njnBB58Aoa8dGQv7vJVDr28myG+C4mofr8XUjN5iqISfVhkWyo9B4DG3SbT/B5ZpXk/LPEjO/zk/W+ib+crVy6bGNdF2oF0uZjlngLDKfe6Vd4Ru48DbtMGpqEgy5eTvRs6WYOcITT5C8RzWSFL0xa4JHiSAi90275PifT6jf2zXgopM6Hg8vAcJ3VUiEtYDQ9IgvrSuX6hgPIhAQ1XH+yHSduq63SM3g8dTBn6Ibr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39840400004)(396003)(16576012)(8936002)(2906002)(478600001)(52116002)(86362001)(8676002)(4744005)(4326008)(36756003)(31686004)(31696002)(956004)(66556008)(66476007)(316002)(54906003)(2616005)(66946007)(6486002)(83380400001)(16526019)(186003)(5660300002)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hy403Q9p/ynXyj35OcwiQE3il9l2yeWi34QScT1k++juggMdtspsrzGXKr0CwEHMzWiuk4oyeT1yLCkKp1BXypprZGn38sMXC+ENqUx2TQdBU1zf4uRJ2aVf0iN+ZesWkR1H674Y1gP8LXEU3KWMmk7l1kJKiErc7dNNbhhfFa9TaPL/q6GnDfWe9uWbDHnToDwZijyRKCrE5ILvo6KhFYnBC0BnveLPDFnhJXMVbfMWjrNaVgeOMqDpeigLNWGYL2ddw7M9agDJg6DILVo09vvts4rlTAcVelx7p3nq0/uQKGItdt0+OAa7QzsJNsrRIetDroprNaegt1yOU6SpE/PjKawUawxPf5cMc0I3q0xChyY66ZRBKJXTFJBNMwkj/VtYstluca2LrjVpOj4tYf9eqBWohq1A9/r5iVA6JyIxLnwI3mi7u7FgAYUpbH/Kdg3p9bHauCAGF5P88LUBBpIjemZWICfrbwvM0jO+YEGAccL0FeIsVsI/HAbROfX6TzIF7KXl1ug4p7Sql8FGvocsLcWV00QUs5bsf7SQfwEuhPScrmCaKjl4mE8bZbes4SjDTpGKAlVEenYSSNP46kK27C+iMz1EhZRGnDkR/4ruf73ZTqytdll/e1ebBfuCbIizpWB0t6HX0lE4pT6j8A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffd1dda-d53f-4b75-cfa5-08d85965752c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 10:52:36.8262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmPHflj03WhXDdKyebF5gg0T6Ufsn0n8ONcfiN+lVP1zA2k6oC5q6AZzXUA3A5pJ1Ln8wdCCiibCpkLUafgeXTlv4LxctxNZYMpfwroPJ+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5207
Received-SPF: pass client-ip=40.107.21.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 06:52:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

14.09.2020 15:35, Greg Kurz wrote:
> As recommended in "qapi/error.h", return true on success and false on
> failure. This allows to reduce error propagation overhead in the callers.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

