Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D103DC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3D72468A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pMdB7nhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3D72468A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Kcj-00046B-TG
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Kbu-0003cY-OI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Kbt-0001Ml-Kg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:57:58 -0500
Received: from mail-eopbgr00135.outbound.protection.outlook.com
 ([40.107.0.135]:38273 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Kbq-0001LG-1z; Thu, 27 Feb 2020 09:57:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mldkpk2MDDZJeIHxE2CSsIn0Q1C/z/Tchg7zEQg7AY9rOLVN9nnLleTZdc/A5E0ytkXo89jNpBINxA+Ms5SwrK1Fbx1zYilDVAwnlfQTeBT1bEDykPsZ3FEkNdb83WSy49YgNFD6oPK9Yc4tgn054CqfJvkn0cvpPtzg/DRwVsklv38PaaS8YVL0sM60aAJOlsMex0JSiwX9y4caXiv+F9A3H+s13VwNy0SyDEQP/eJ+JiVj5uX/sCeQa84i7LahijT7+exTVksvXIOR8d8t9EQbJeQbrKvWEUwYh+U1HbtPst5wiyqy3s5ZrwmMu8anXOmdsXRQy6RepxsW/PoUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cyHMO0mRkpj05F6vDXi4NyBqAohtp/WkkqMELBZxAQ=;
 b=BHH4LMWPAciT6VsW9jSS3XsJtbjtqbslJ+Cu0PYfXvW/ARprkiH3woh5X9BLcPb6bxhCC+pkl1rI7Nnf/gDitux1KVSICVw2P8J15TEs/t7L4+tNJo+mmHRitwMr+F+e+cTIltJwxtacS3yhtu6KdNapXoQglaY+zQ1q8lJyVDOtEKrRD9Ta9F6bs3b2UvhJBc9lCnByw2JUmng6MdFhrRiW3Wrcvmj79fV0Swk5tflRyNRedks/UC8LACKad/LQKy6HocHYtvpGtnRivwgDeDIA/hHXxc4ShNZGzu7IfMrUrv3tozGeRXxOvd3LnKy9AikJM13Xee//WmLyCf8XrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cyHMO0mRkpj05F6vDXi4NyBqAohtp/WkkqMELBZxAQ=;
 b=pMdB7nhOYwdBVfd9PaGMHsfZfqUm7RmTAkfhLwdQnbzJEBhfpft5TjaOfJ4qfQAtW45g+HktpRZ/QKEgjRUHakDTbvMeYo6PEooiBp0uEGmRzT41Bd8fyBajJpdsEMWWZetLBMywPplWkLKwkDBX2U8MQtWc6aOxjU+fq7OTQa0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.59.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Thu, 27 Feb 2020 14:57:50 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 14:57:50 +0000
Subject: Re: [PATCH] qcow2: Explicit mention of padding bytes
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200227144508.1078501-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227175747746
Message-ID: <213b35f2-315c-6d0b-7915-d4e9e62624cf@virtuozzo.com>
Date: Thu, 27 Feb 2020 17:57:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200227144508.1078501-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0372.eurprd05.prod.outlook.com
 (2603:10a6:7:94::31) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0372.eurprd05.prod.outlook.com (2603:10a6:7:94::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 14:57:49 +0000
X-Tagtoolbar-Keys: D20200227175747746
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28727970-d68a-4c72-8a65-08d7bb956a5d
X-MS-TrafficTypeDiagnostic: VI1PR08MB3677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3677522EB10C6BAF3FE75254C1EB0@VI1PR08MB3677.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(346002)(376002)(396003)(189003)(199004)(31696002)(66556008)(86362001)(2906002)(36756003)(16576012)(5660300002)(8936002)(26005)(66476007)(316002)(66946007)(478600001)(4326008)(31686004)(52116002)(956004)(8676002)(2616005)(81156014)(6486002)(186003)(16526019)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3677;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqQt/RmF0C6DaXkWU9XPNeImn6EkImf32B9xlOhrMMHMIzHX/SIGG8rP5SeYRkwpJuKK7c0tdbYvJn+oxX+C0gCFd3Gs65yG8YRBaavc1So5joi80ALOYOZfVoMFDSoAMKvIrJbqWDtB3otOGifUru1Y+mPyXD8JtBGJujokVv5amyBmSfSFaZ/l0yQISVlUKjZ1PdaA90NK9lePqRgXdOih+VL00fL7nlGQF8L+Fr0I84God5lu7iajbjTHz08ogUONA8fy+6um0icw0IfTITn51HRxMMj97bWwND/HlQ9ekiyU4cW5oEbwgNbcRHuCfM5IEDMvh/8ajJh2DcOhhMeepND0dyRRV5OWZLn2jfJnolLJiZ/EZ3C7XTk9lLX70cdsKtsg30HPX4Xo4aFdkMadEU6hJDTJ6BAHvIumsRg8lziitRgxTKkHxWtunVgTZqHYDpjEMmZ0lSmBmFdaXVegdfKU9xeVNWntHyO5LolJXBNouYOzExO+V338AgC5DKv3OOvuKRehnvCmkftO0A==
X-MS-Exchange-AntiSpam-MessageData: 9h5bkbqcRdnjrabxHExgf3U1olWjInferhAMMtt39Icf1a43w74LsyGWgniCdHCPy9iJdoddHcQ4qKfxffKDMdKtET6+sNQFPe9QJQ1xC7txQYbPAHVA28hiDvB6mlxBq7QoBSWC+pj/aOT+b9StDw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28727970-d68a-4c72-8a65-08d7bb956a5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 14:57:50.6560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLfJhVflQFH9WShw5qoSlx/lfuMXScMzn/SPr1Wqk1G7gnmaELvyob/Cn7d7vMEgDf1XDTj/F/1Y2g1n7aiop+Fq2zpLoJ4Kg7v1usYCr08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3677
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.135
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
Cc: kwolf@redhat.com, dplotnikov@virtuozzo.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 17:45, Eric Blake wrote:
> Although we already covered the need for padding bytes with our
> changes in commit 3ae3fcfa, commit 66fcbca5 just added one byte and
> relied on the earlier text for implicitly covering 7 padding bytes.
> For consistency with other parts of the header, it does not hurt to be
> explicit that this version of the header is using padding bytes, and
> if we later add other extension fields, we can rework the allocation
> of those padding bytes to match those additions.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   docs/interop/qcow2.txt | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 5597e244746e..193ac7c5c1af 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -209,6 +209,8 @@ version 2.
>                       Available compression type values:
>                           0: zlib <https://www.zlib.net/>
> 
> +          105 - m:  Zero padding to round up the header size to the next
> +                    multiple of 8.
> 

Hmm. Strictly speaking, you defined it as one of additional fields. And by
this definition, we may start to check in qemu that these bytes are zero,
instead of ignoring them and keeping as is..

But may be it's just a nitpicking..


-- 
Best regards,
Vladimir

