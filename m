Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D873C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AD320661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AD320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSubQ-0003fw-J4
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 23:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jSual-0002Yt-W4
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jSual-0003r0-Ap
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:37:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:27945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jSuak-0003qe-9N
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:37:58 -0400
IronPort-SDR: PP08wfaE3PxYzIIk2sNCdu0g99VOK3jESVb0DuKvlkZFyQftK0rjU3+9Qp2ofbEgfiZHboV3WZ
 Xr5cEdjGUZxA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 20:37:55 -0700
IronPort-SDR: KWE7e+uFEOQbPFnK6+2ZT+NQfNj5sETAOA6lwZ1nYG72HxupuyKP1KVSzqm2C+2Yl36qFAWng4
 DAOhB0ouw3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,322,1583222400"; d="scan'208";a="431573314"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 26 Apr 2020 20:37:55 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Apr 2020 20:37:54 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Apr 2020 11:37:52 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Mon, 27 Apr 2020 11:37:52 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 4/6] net/colo-compare.c: Only hexdump packets if
 tracing is enabled
Thread-Topic: [PATCH v3 4/6] net/colo-compare.c: Only hexdump packets if
 tracing is enabled
Thread-Index: AQHWHBBS3Ct95wCfKUa2kJjtzDwH5KiMUiTw
Date: Mon, 27 Apr 2020 03:37:52 +0000
Message-ID: <68fe3d6a83e243e5981d77a7f596cc5e@intel.com>
References: <cover.1587935686.git.lukasstraub2@web.de>
 <e0e3f058620cce728ec5cb18d136f2f2b475b5ec.1587935686.git.lukasstraub2@web.de>
In-Reply-To: <e0e3f058620cce728ec5cb18d136f2f2b475b5ec.1587935686.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.120; envelope-from=chen.zhang@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:37:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.120
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Monday, April 27, 2020 5:19 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: [PATCH v3 4/6] net/colo-compare.c: Only hexdump packets if traci=
ng
> is enabled
>=20
> Else the log will be flooded if there is a lot of network traffic.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>=20

Looks good for me.

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

---
>  net/colo-compare.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> ff6a740284..6634911770 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -479,10 +479,12 @@ sec:
>          g_queue_push_head(&conn->primary_list, ppkt);
>          g_queue_push_head(&conn->secondary_list, spkt);
>=20
> -        qemu_hexdump((char *)ppkt->data, stderr,
> -                     "colo-compare ppkt", ppkt->size);
> -        qemu_hexdump((char *)spkt->data, stderr,
> -                     "colo-compare spkt", spkt->size);
> +        if
> (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> {
> +            qemu_hexdump((char *)ppkt->data, stderr,
> +                        "colo-compare ppkt", ppkt->size);
> +            qemu_hexdump((char *)spkt->data, stderr,
> +                        "colo-compare spkt", spkt->size);
> +        }
>=20
>          colo_compare_inconsistency_notify(s);
>      }
> --
> 2.20.1


