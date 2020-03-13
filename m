Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275E7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7171206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DdDUZDze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7171206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfM2-0004Px-3g
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCfLG-0003x8-Mb
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCfLF-0007nc-Jr
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:06:50 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:44078 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCfLA-0007Pd-P4; Fri, 13 Mar 2020 04:06:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpWI0NGgL2sVSg4q6qgzvIQzDye3lYHsgb3hLOEHYuMDKZKqnRcZ4t3srb2ZGI8SghylfjbLUKIqzbTAqWHDGDG3rFnuLcVkeJL5IOsHs8cnzl1P0Rf9rOnOYEKbZbq/pU2Q3qQ1zVuNxIebMk+89eN19tkJlZf+vO0UgUt57pRBqAwiTp7jPtsSHfgcSUrNWp7eVTWpM8rRk+JvkFvzapftSA5E9j6is5WsMo+3CSTmLy+q8CDi3bfIwxoRSixM3KUFPdlQSYdmbwRuI8IMKSPGbTQoIgNZac+IlM8IM5Cpul7mAHBdTs8trFMDz/VSIzhlGi9dwlj2xETKEWPpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpdBPje1809JXoumfIbaXWSbuRUDYLxGUjGk6oHyYzw=;
 b=F4in5M+OfAaRL758qX7nvK6me9poTysKtg3CWYHbE4R3E1qVJ8SEHev3EbmluPbt6s+rQUN9tYIC4Rh92NGEUwPibr8NLrMv038J+qiaNbWgqJaeR+IG5+fyNSU9G7ZKeDEl05tMeIw5UAEAOPp5xh0GxmB1JRTq5DB7VfanrZM5jg8wOcSevTwq9uqmc/LJj5ZURxBGl7A4sl8yGUUictsEEIqRSuXhRP38rljtwxoIEMbn+XmzMsdQr6ft3OtE5+rkIDHaSJEpNUleeFavY7KOyKxA+uu0gVJAlwHe3ml2EzKxxeW+It9mPnBgWsKDITqAmtDuYSUAJXDWB3KhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpdBPje1809JXoumfIbaXWSbuRUDYLxGUjGk6oHyYzw=;
 b=DdDUZDzeNOfGsP80Qo892mskXX5iTd9tyaonoX1IsXmoBFGDWtpx4kcyZC6vKcpQBbIhexMno8qt6mk892kP/3LozDABHKBBzGhMcmFeGmDh3jgzs88UDZfNeSl+GYTenp5Mq2Kpdi+utZJjI62957VlZRLXsVP1FR+hkB8O1q4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3030.eurprd08.prod.outlook.com (52.135.164.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 08:06:39 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.016; Fri, 13 Mar 2020
 08:06:39 +0000
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <87eetwlmlm.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200313110637203
Message-ID: <efaed3e4-3f4d-f538-5087-96391fc20d2f@virtuozzo.com>
Date: Fri, 13 Mar 2020 11:06:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87eetwlmlm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::25)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Fri, 13 Mar 2020 08:06:38 +0000
X-Tagtoolbar-Keys: D20200313110637203
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d272baa-f68d-4a29-0669-08d7c7257595
X-MS-TrafficTypeDiagnostic: AM6PR08MB3030:
X-Microsoft-Antispam-PRVS: <AM6PR08MB303072E253092B450FF60138C1FA0@AM6PR08MB3030.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(39850400004)(396003)(346002)(199004)(478600001)(31696002)(36756003)(2906002)(6486002)(26005)(4326008)(6916009)(16526019)(316002)(54906003)(5660300002)(86362001)(7416002)(66476007)(2616005)(8936002)(66946007)(956004)(31686004)(186003)(81156014)(52116002)(81166006)(66556008)(16576012)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3030;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KC/mOt84U3wkq2GbllbeaI9T/rAhcDa4gLYbWxUggeNcstmg5vjl1BJsEgL9f2jdZG56gc3jO++3F6/E74iqQp4tugr0Rltqa7I1YYnJaFY6E0etul1WL/488Rqi5+kVzeIT2VInkWGzileLlhIyfkpufLldr3w6kqysNP+sUw+xXrrF/4cPXWWvmc0pVKPaczrzYv8xhvuiS4LqrWIeMSs7MXcG1FYv//3zYazvrCCyZ/EBf0mGnJbx9IZV+TmYCCbTUotDFxK4TPTFZKn/o2s4+WPZZJa2s6cFH9knv9YWTzNTqKd6cBYB9rKzRRtwblgqAVr1JEOPcSAOVvsBF851YVpTv4uHMVBbYl7NcoCMb+H71ahXZ6umYNnFWjvEjGXo0B1ocvHTGv0t2Kz8WvocOBkednTYDbc3H2x575dJEZ9Y+suQF9i8B5Rmlr0
X-MS-Exchange-AntiSpam-MessageData: cNVbM0eIfetI26lW5m7/8uIiYlccWyAOMBL6bV3R9J8lBeazJbazOmnEHAuUXRyCJo1j4Tc6Iqx7Nx3PhHUgcxSzME0XHcerZppxJpRLpdqQdx4Y/21UKgXsLWWsuK4ka0xjoJvyySlxgpgkrrZjHw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d272baa-f68d-4a29-0669-08d7c7257595
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 08:06:39.8201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ry1UL7yT98IiWwPLgxt0sr6YOpKfop5ThZza4qFBC0J2MlHRU3BdYaTFsVx5RGPQZQ4oSUZ4Gde/klanQVQMVfLEyV5QBcN0KgopGmWMmjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3030
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.118
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

13.03.2020 10:50, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
> [...]
>> +// Warn several Error * definitions.
>> +@check1 disable optional_qualifier exists@
>> +identifier fn = rule1.fn, local_err, local_err2;
>> +@@
>> +
>> + fn(..., Error ** ____, ...)
>> + {
>> +     ...
>> +     Error *local_err = NULL;
>> +     ... when any
>> +     Error *local_err2 = NULL;
>> +     ... when any
>> + }
>> +
>> +@ script:python @
>> +fn << check1.fn;
>> +@@
>> +
>> +print('Warning: function {} has several definitions of '
>> +      'Error * local variable'.format(fn))
> 
> Printing the positions like you do in the next rule is useful when
> examining these warnings.

I decided that searching for Error * definition is simple, and better for
user to search all definitions by hand (may be more than too).

But understanding control flows is more complex thing and better to help
user with line positions.

But if you want, we can add them of course. Note, that for some reasons some
times coccinelle instead of original filename prints something like /tmp/...original-name...
so it don't look nice and may be a bit misleading.

> 
>> +
>> +// Warn several propagations in control flow.
>> +@check2 disable optional_qualifier exists@
>> +identifier fn = rule1.fn;
>> +symbol errp;
>> +position p1, p2;
>> +@@
>> +
>> + fn(..., Error ** ____, ...)
>> + {
>> +     ...
>> +(
>> +     error_propagate_prepend(errp, ...);@p1
>> +|
>> +     error_propagate(errp, ...);@p1
>> +)
>> +     ...
>> +(
>> +     error_propagate_prepend(errp, ...);@p2
>> +|
>> +     error_propagate(errp, ...);@p2
>> +)
>> +     ... when any
>> + }
>> +
>> +@ script:python @
>> +fn << check2.fn;
>> +p1 << check2.p1;
>> +p2 << check2.p2;
>> +@@
>> +
>> +print('Warning: function {} propagates to errp several times in '
>> +      'one control flow: at {}:{} and then at {}:{}'.format(
>> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
> [...]
> 


-- 
Best regards,
Vladimir

