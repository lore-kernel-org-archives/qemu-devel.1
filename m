Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8C0C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 07:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D05C206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 07:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D05C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49221 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIpYm-0001z7-QC
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 03:09:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hIpXZ-0001L7-QT
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hIpOJ-0004tZ-U0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:58:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:32987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hIpOJ-0004qi-LY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:58:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Apr 2019 23:58:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; d="scan'208";a="225842451"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
	by orsmga001.jf.intel.com with ESMTP; 22 Apr 2019 23:58:47 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
	FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 22 Apr 2019 23:58:47 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
	FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 22 Apr 2019 23:58:47 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.206]) by
	SHSMSX106.ccr.corp.intel.com ([169.254.10.21]) with mapi id
	14.03.0415.000; Tue, 23 Apr 2019 14:58:45 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2] net/colo-compare.c: Fix a crash in COLO Primary.
Thread-Index: AQHU95yIedX63frbAUOd9W+1JdrB/aZJVDZQ
Date: Tue, 23 Apr 2019 06:58:44 +0000
Message-ID:
 <9CFF81C0F6B98A43A459C9EDAD400D78060D6618@shsmsx102.ccr.corp.intel.com>
References: <20190420191425.7d1dab82@luklap>
In-Reply-To: <20190420191425.7d1dab82@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGU3MDhmZGQtZGMyNy00ZmM0LTg4N2ItNWQyMTIyYzJhNjNhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWE40RWxYYnVvXC9SOERSTjRHM2ZiVlh2R2x3SE5XRWk1ZHgzMm90TmY4UzZ1TXRmWEMxXC9vbXpiMHJGNU1KVmRcLyJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH v2] net/colo-compare.c: Fix a crash in COLO
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
Message-ID: <20190423065844.IM2xAhrCSZg1Zc7Vy8SyrhS1vf89V1wV95bSNVzXANo@z>


> -----Original Message-----
> From: Lukas Straub [mailto:lukasstraub2@web.de]
> Sent: Sunday, April 21, 2019 1:14 AM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH v2] net/colo-compare.c: Fix a crash in COLO Primary.
>=20
> From: Lukas Straub <lukasstraub2@web.de> Because event_unhandled_count
> may be accessed concurrently, it needs to be protected by taking the lock=
.
> However the assert is outside the lock, probably causing it to read garba=
ge and
> aborting Qemu erroneously.
>=20
> The Bug only happens when running Qemu in COLO mode.
>=20
> This Patch fixes the following bug:
> https://bugs.launchpad.net/qemu/+bug/1824622
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Looks good for me.

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

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


