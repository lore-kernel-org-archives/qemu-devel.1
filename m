Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A12C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 17:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26E3222A8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 17:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26E3222A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59445 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHXTp-0004VX-2g
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 13:39:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hHXT0-0004CV-VL
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hHXSz-0007V9-NM
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:38:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:48271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hHXSx-0007Tp-51
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:38:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Apr 2019 10:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,370,1549958400"; d="scan'208";a="132773265"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
	by orsmga007.jf.intel.com with ESMTP; 19 Apr 2019 10:38:18 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
	fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Fri, 19 Apr 2019 10:38:12 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
	FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Fri, 19 Apr 2019 10:38:12 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.206]) by
	SHSMSX154.ccr.corp.intel.com ([169.254.7.149]) with mapi id
	14.03.0415.000; Sat, 20 Apr 2019 01:38:10 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH] net/colo-compare.c: Fix a crash in COLO Primary.
Thread-Index: AQHU9renT4s6UsnJzEKAqQaH2DVJn6ZDvT4w
Date: Fri, 19 Apr 2019 17:38:10 +0000
Message-ID:
 <9CFF81C0F6B98A43A459C9EDAD400D78060D262F@shsmsx102.ccr.corp.intel.com>
References: <20190419155605.5349857a@luklap>
In-Reply-To: <20190419155605.5349857a@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDU0NzU1OWYtOTA5Ny00YzM5LTgzZDMtYjYyMDI3MzNmOTIzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNHMrR1lwU2hvdGpRaFwvczJmanJ6NzZHOURyUTl1TEQ0d0hqcFptOFRcL2o4dUN1TndVVFB0c3BGXC9mME1WMzBrRiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare.c: Fix a crash in COLO
 Primary.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419173810.FhmHlniW4xwltbLaroL0eebbWhkkgT9Q-AAyWWAnDHc@z>




> -----Original Message-----
> From: Lukas Straub [mailto:lukasstraub2@web.de]
> Sent: Friday, April 19, 2019 9:56 PM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH] net/colo-compare.c: Fix a crash in COLO Primary.
>=20
> From: Lukas Straub <lukasstraub2@web.de> Fixes the following bug:
> https://bugs.launchpad.net/qemu/+bug/1824622

It looks good for me, but I think you need add more comments in commit mess=
age,
For example what situation will trigger this bug and why it will occur.
After that, I think you can close the bug in Launchpad.

Thanks
Zhang Chen

>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> bf10526f05..fcb491121b 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -813,9 +813,8 @@ static void colo_compare_handle_event(void *opaque)
>          break;
>      }
>=20
> -    assert(event_unhandled_count > 0);
> -
>      qemu_mutex_lock(&event_mtx);
> +    assert(event_unhandled_count > 0);
>      event_unhandled_count--;
>      qemu_cond_broadcast(&event_complete_cond);
>      qemu_mutex_unlock(&event_mtx);
> --
> 2.20.1


