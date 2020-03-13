Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B86C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B7E2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mGMqdZ4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B7E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCe0X-0006Jp-95
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 02:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCdzd-0004r3-BZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCdzb-00052S-PJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:40:25 -0400
Received: from mail-eopbgr30134.outbound.protection.outlook.com
 ([40.107.3.134]:6630 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCdzZ-0004pO-6w; Fri, 13 Mar 2020 02:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+xrlYWLu4LGFU3XH6CumLzQ7MXHAZTYBQtbhnwFdwgC4ivqmeGPVyynobwSNXWI7mG3qn2RtO1eL/NXRN8ELYbTpYh0VlnXyKNt6TLTi87xFfnwuR7LuLxJ/dSluI8aZn7nMYDZ9KC8gjpkZ07W615Uc85QS0yqkTPOk8OF4m+UNxz75OuVYlQv9vUUpybIoIrXcMIktb/2PYVNuIsAaoauScdgPG7kD8YvN3N8jxmf7OQeuUx113Mjn6h2AKxGibQ4BMMxVPFdEHly4Pp3T78T9h8Z+x6K9u6qRn3s3F7R/rUEq1ZbqkU13d2RcWRigJOf821DJoXbQ/wgxXvtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB435gRqOYpAHDM0OyWF4GwUPGf1vOMVfyWXIvLcsV8=;
 b=bD7KIbbzkUed7k9fV4goOkbgT1vdo1UeTdFDs533HA+OzY0+lUmFTuoGVrFFXdKQzqaEb1Gk7uMDPl5CCe7cn/OPoFHmdm0tYdNzq+btj3xzllT+y/4wGxNs2+HDJ6gMYr1RpbGzxVkL6vt4zN7c2wbXqvrtFyKPAUDV8/AbEOOIP1ge6qwBIkMF0e57hQWQkora2ekRyJYPJ6gV6DPk1wABm4gzjNL5zPjHYV60IvhbKUC0aYj5m8B5unrRCI0/SnJo7AWnNppS04jY99VPxX7oNvm+1M+SSj0xuSoNOu7aXwI6eU3tYCFUNQeGRntT7HrMaiNo5qNYxk7JrvoHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB435gRqOYpAHDM0OyWF4GwUPGf1vOMVfyWXIvLcsV8=;
 b=mGMqdZ4HxYqk0UF6ph9XDFYeySefO0QaYmgowW4eufgHFI3vFRrO/MPOn+Daji1MrM1eghJ2O1Qr/VFnQB6JYzeRrfQEKDXGQeY9R+ntSUukmPaAOPW0MgmGgCVAGNnhAP5bsEisVAZ4oSaaSsRtenZU/JQ1FOHYwh4myjER8nk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3797.eurprd08.prod.outlook.com (20.178.89.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 06:40:19 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.016; Fri, 13 Mar 2020
 06:40:19 +0000
Subject: Re: [PATCH v9 00/10] error: auto propagated local_err part I
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <87y2s5ps69.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200313094016799
Message-ID: <522ccf48-3148-9b1c-cd1b-7d9bdac26e26@virtuozzo.com>
Date: Fri, 13 Mar 2020 09:40:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87y2s5ps69.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::16)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Fri, 13 Mar 2020 06:40:18 +0000
X-Tagtoolbar-Keys: D20200313094016799
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2719b82-4795-4e4e-24ec-08d7c71965c4
X-MS-TrafficTypeDiagnostic: AM6PR08MB3797:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3797E2D1DC3D0258CA5C4CFDC1FA0@AM6PR08MB3797.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(39850400004)(396003)(199004)(52116002)(4326008)(16576012)(66476007)(66556008)(66946007)(36756003)(2906002)(54906003)(86362001)(31696002)(316002)(966005)(7416002)(26005)(6486002)(5660300002)(8936002)(16526019)(31686004)(186003)(81166006)(6916009)(8676002)(81156014)(2616005)(478600001)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3797;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZCvaMJBt6VPzdm5sBtp9zzXmDePeenL/h3dbmEazFpKwWHLqQXDeYbZ9/QEdaNND1SZIOwlhpa94fCMY3DJLPiRxxAEk0jky44GTVut/Vh5zPxfgg7KYosr89U/n9N3eKvSFuCzWWRDZ4Q4Vv0itpaaTdItc5mcS6FcZOoY9N4vWX+1Fnj8GbFrHAoNuHDKGhF8HdIdwAkr7RqHi8sstj6pBxyI2SJY3+3N5vNDyFgN+2v4aH7iDhv39CrGCo0TbXDILyD7U5CLM141J8vjJXEx4u5jeZK9OBIn3xi4FBt3+mCC2w++/LlUUl8/ONte7gBPoh0SLB3w3hE7C/VuUEh+i6tDcdFSXekpPJ24hx+2YOIP+foJpfaSq5vx1/Yt4QncoBotgQkaTZHv28xU1snTb03xn+xp4uujp13GRr6w+XjjSNrriT7O70zKZlT2dUSFqM6RuUBS0xqskZzzW1qluf3TBBRwvp3e++2lEPjcw6zLW63BCptXswsE2jOCrdqlDb5uGwXkYhcSEDHNVw==
X-MS-Exchange-AntiSpam-MessageData: LwieS98pY0QSVFAYc/La41d9CQgARd/8rfcfsQeZhdZo2jrq8hd2d21p3PIxfPzRtdcygWGtNiG5oC8tOTOmtNovVhGuy2icjats1fyRzlGF3HTcAeCSi0ZI+5LZYZDn9ZvlYj3b4va2ELhJoXE3Qg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2719b82-4795-4e4e-24ec-08d7c71965c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 06:40:19.3286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEbd0GrlJ4ktA8EhCuVUv093nkX/4bI5gpkUSCM9taAJsS+BVqntlbHjiePbVo0zPZzJFIGE4TI53LN2oUXuuIt1q9+yHTFalPfBEWjBN44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3797
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.134
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.03.2020 17:24, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> v9
>> 01: A lot of rewordings [thanks to Eric]
>>      Still, keep all r-b marks, assuming that they are mostly about macro definition
>> 02: significant changes are:
>>      1. Do not match double propagation pattern in ERRP_AUTO_PROPAGATE-adding rule
>>      2. Introduce errp->____->errp scheme to match only functions matched by rule1
>>         in rules inherited from rule1
>>      3. Add rules to warn about unusual patterns
>>
>>      Also, add line to MAINTAINERS to keep error related coccinelle scripts under
>>      Error section.
>> 07: add Christian's r-b
>> 09: add Eric's r-b
>> 10: a bit of context in xen_block_iothread_create  and qmp_object_add()
>>      signature are changed. Patch change is obvious, so I keep Paul's r-b
>>
>> v9 is available at
>>   https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-partI-v9
> 
> Did you forget to push the tag?

Seems I've pushed it to wrong remote. Done now.

> 
>> v8 is available at
>>   https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-partI-v8
> [...]
> 


-- 
Best regards,
Vladimir

