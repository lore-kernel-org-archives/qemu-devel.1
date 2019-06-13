Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F11AC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 08:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AF52147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 08:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AF52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37811 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbLSd-0003T6-G6
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 04:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40127)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hang.yuan@intel.com>) id 1hbLQ7-0000aI-B2
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 04:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hang.yuan@intel.com>) id 1hbLB6-0006im-DC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 04:33:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:14462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hang.yuan@intel.com>) id 1hbLB6-0006gK-4n
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 04:33:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Jun 2019 01:33:44 -0700
X-ExtLoop1: 1
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga004.jf.intel.com with ESMTP; 13 Jun 2019 01:33:43 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Jun 2019 01:33:43 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Jun 2019 01:33:43 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.185]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.76]) with mapi id 14.03.0439.000;
 Thu, 13 Jun 2019 16:33:39 +0800
From: "Yuan, Hang" <hang.yuan@intel.com>
To: "Xu, Colin" <colin.xu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "stefanha@gmail.com" <stefanha@gmail.com>
Thread-Topic: [Qemu-devel][PATCH] MAINTAINERS: Add entry for Guest X86 HAXM
 CPUs
Thread-Index: AQHVIcGKQo1eLx134kStu0mKNQJP0qaZQB7A
Date: Thu, 13 Jun 2019 08:33:39 +0000
Message-ID: <C294FBAE55175941838A8D362DCD8AA225F08B6A@SHSMSX104.ccr.corp.intel.com>
References: <20190613082457.18246-1-colin.xu@intel.com>
In-Reply-To: <20190613082457.18246-1-colin.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzU2MTkwNGEtMTc3YS00NDc3LWE5OGUtODRiZGY0YjM3MmZmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNXpvVWtaTmcxMUp5QmxYOXBrZ1RrS00xR1VEbWx4RHZ3UFdVa25nVFZBOUJJNHB2NkI0QjB2bHhXZ2JHeHBkTSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add entry for Guest X86 HAXM
 CPUs
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
Cc: haxm-team <haxm-team@intel.com>, "Wang, Wenchao" <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for adding HAXM info.

Reviewed-by: Hang Yuan <hang.yuan@intel.com>

> -----Original Message-----
> From: Xu, Colin
> Sent: Thursday, June 13, 2019 4:25 PM
> To: qemu-devel@nongnu.org; stefanha@gmail.com
> Cc: Wang, Wenchao <wenchao.wang@intel.com>; Xu, Colin
> <colin.xu@intel.com>; Yuan, Hang <hang.yuan@intel.com>; haxm-team
> <haxm-team@intel.com>
> Subject: [Qemu-devel][PATCH] MAINTAINERS: Add entry for Guest X86 HAXM
> CPUs
>=20
> HAXM covers below files:
> include/sysemu/hax.h
> target/i386/hax-*
>=20
> Cc: Wenchao Wang <wenchao.wang@intel.com>
> Cc: Hang Yuan <hang.yuan@intel.com>
> Signed-off-by: Colin Xu <colin.xu@intel.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 588c8d947a08..fccae4e7de48 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -423,6 +423,16 @@ F: include/hw/block/dataplane/xen*
>  F: include/hw/xen/
>  F: include/sysemu/xen-mapcache.h
>=20
> +Guest CPU Cores (HAXM)
> +---------------------
> +X86 HAXM CPUs
> +M: Wenchao Wang <wenchao.wang@intel.com>
> +M: Colin Xu <colin.xu@intel.com>
> +L: haxm-team@intel.com
> +S: Maintained
> +F: include/sysemu/hax.h
> +F: target/i386/hax-*
> +
>  Hosts
>  -----
>  LINUX
> --
> 2.22.0


