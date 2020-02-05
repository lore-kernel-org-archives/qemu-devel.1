Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34386C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F9D2072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P9xI7qG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F9D2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIps-00075W-LP
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIoW-0005iK-S3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIoV-0004LU-Se
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:25:48 -0500
Received: from mail-eopbgr130094.outbound.protection.outlook.com
 ([40.107.13.94]:44609 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIoP-0003y8-JJ; Wed, 05 Feb 2020 06:25:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkKawVIOq5ftIXtclLHD+wWhPcXLegIYPX+uPvVxe/OHKAyFfit/PWdSUjARUjzw1pnI1MJkjKIJ7zPBTtHjfQnmNiRxgzWfOI0P7BnMJPEWwut/Lrmk96WNToIijUcaxDl8YCXMOGsS3ynBikL6i7IUzS+ueYCOschUs1mr9xoegNlvXGTSxSoh6ibcw6it7O1nnCfrM2nh5ak+wE81vBflJ0FijTNRpF5rRU5wP5QB0H03PN261wduOEVZLRjJWp8fZateWX6bzJIklr7Bad+7GR+Ktsd+x8V+EVq5Iq8WROFOD1EVzYOFnnI2rTKqabDyomYDyqY+wIxUHKt9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlPDWfJmZKmoRp+Zdcde9P5EeRQ0yveiv//e2VSHpAQ=;
 b=NaQrltYDmlNh2EbC1IpswamC+WTBaUrCKoC9sCIm8dzFgtD6QlbhtSWskHi+43/UN6Asj+UnWTEhlwkjBh1YAlZkYjEHbqfoz43HE6L9P2WrwXmUJGRlPhNdVGrNo0XIOU7DLcVw2EeUgKqPY/S4Lo1sBq+Ae9WoVSk23T0SOVsKC1z9eJrcBWFWUMMs+lT4HoHih5S/vLS9z/C4U1zcyj5+5uyTwUdVO4vcpGrs1n6KqtRqBib2kdJspgHnyV1JrihnooYvfixv1dZcMtTQHsWdLL7U5bNrDvmimV4PX1Uu03x/MXteF09gBzhcI3gYjthYHpp2g8sxHD6QBogMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlPDWfJmZKmoRp+Zdcde9P5EeRQ0yveiv//e2VSHpAQ=;
 b=P9xI7qG5ITBdcNv/KzAkCqV22vG+eKLvuPsfXr+KQlzsEKTsRv6820mDzhz47D6+dgP3Kp6SYHhNcXCxIy8jxHtlI2WI7hnZ/afVFWEjVheaLsgXIt85hSh0WIFxEi8MR4mpJZdkGwbFV49CgxMZrfHAi0DuYpnR0gzkCT8NnWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3904.eurprd08.prod.outlook.com (20.178.80.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Wed, 5 Feb 2020 11:25:38 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 11:25:38 +0000
Subject: Re: [PATCH v4 1/1] qemu-img: Add --target-is-zero to convert
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200205110248.2009589-1-david.edmondson@oracle.com>
 <20200205110248.2009589-2-david.edmondson@oracle.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205142536140
Message-ID: <52ad573b-01a7-eaa9-de2d-8f76e77c3a66@virtuozzo.com>
Date: Wed, 5 Feb 2020 14:25:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200205110248.2009589-2-david.edmondson@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0175.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::23) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0175.eurprd05.prod.outlook.com (2603:10a6:3:f8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 11:25:37 +0000
X-Tagtoolbar-Keys: D20200205142536140
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caee6dcc-001a-4b0c-de5c-08d7aa2e204c
X-MS-TrafficTypeDiagnostic: VI1PR08MB3904:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3904B6F63D7FD5A5010EE204C1020@VI1PR08MB3904.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39850400004)(376002)(346002)(396003)(199004)(189003)(478600001)(16576012)(316002)(86362001)(31686004)(8936002)(81156014)(8676002)(81166006)(4326008)(31696002)(16526019)(186003)(2616005)(956004)(2906002)(52116002)(26005)(66476007)(66556008)(4744005)(66946007)(6486002)(5660300002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3904;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJfhqPt3vWeIHfl7UdbgrWyI8U/bfLru8LGmeEwEXv3Rz0Y90ZoR1Thc1At4z5hU4BWt70/xYyKIuck7lDYEDtoe0hmtIzJLJgmHZa0sqh+Zr6hKSgIxtDQ/Ky3VIclruVb+4ZCQe4CssuKCKpgM+3suUE20IiGqbBP6UzxCbZH/wCHnypa2JT05TQW9HMRskU84m4SnEQDgCiDgOZpGCqqu4Cp66i4aGvS6RkvEQ7707Nj4bxjjK4wORrMx0U1/6Lq/tMuvEANG61cbAMhqkNod8n2lnvfhFy0c6qM2mFQ6DTEmRS94MCOa3e6ZI+96kHlgKIRQrbpPqB9cEoBOuqvOYwymQ0WNr7Jct/2uGoSp4nAWIvegZP0OPhEu0LdCzwmrQ9dLq0eow29o7DJlaIowkQGU7R0lFDw2u3ym498jR8pgdfCk1oGizjmF212j
X-MS-Exchange-AntiSpam-MessageData: yQOD2AvmMPgLyWMFC5hNPnKPfoemtLee3nsqY+RmSbIzoIQbjCPgI/NXCkbSKOe43KvVeeu8W46udLE8ohgV3xsf26OBnp/+DycfeVory8msef5LuunmYvPrbKdwvJArwLqUUfRdlRWPXoTQugpu9g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caee6dcc-001a-4b0c-de5c-08d7aa2e204c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 11:25:38.4839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSjYEHeB/iQRlxZe1w3bvJ7fZcbRDqbeaRJ/VskDscS+sDHNTV6LDBFEL6Y9Qtxvv7QOhUyw+r2SxrD0fP9yYQcwQly+dxu0cX0yezVSYGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3904
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.94
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.02.2020 14:02, David Edmondson wrote:
> In many cases the target of a convert operation is a newly provisioned
> target that the user knows is blank (reads as zero). In this situation
> there is no requirement for qemu-img to wastefully zero out the entire
> device.
> 
> Add a new option, --target-is-zero, allowing the user to indicate that
> an existing target device will return zeros for all reads.
> 
> Signed-off-by: David Edmondson<david.edmondson@oracle.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

