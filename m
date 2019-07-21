Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4001EC76188
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 09:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA322084C
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 09:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA322084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hp7pF-0001Nq-8i
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 05:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38165)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hp7p5-0000zT-3p
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 05:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hp7p3-0006Bk-Td
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 05:08:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:54163)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hp7p3-00068i-Ig
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 05:08:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jul 2019 02:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,290,1559545200"; d="scan'208";a="180089676"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga002.jf.intel.com with ESMTP; 21 Jul 2019 02:07:59 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jul 2019 02:07:59 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 21 Jul 2019 02:07:59 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.232]) with mapi id 14.03.0439.000;
 Sun, 21 Jul 2019 17:07:57 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH V3] net/colo-compare.c: Fix memory leak and code style
 issue.
Thread-Index: AQHVPUsLqGBEGDJMrk2Ek2iZfotKjqbUzBag
Date: Sun, 21 Jul 2019 09:07:56 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061D4AC0@shsmsx102.ccr.corp.intel.com>
References: <20190718092219.20081-1-chen.zhang@intel.com>
In-Reply-To: <20190718092219.20081-1-chen.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjlkMDdiYTgtNjY1NC00NjZhLTg2YmYtNzU2YzhjNDQxMjAyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidzBOYlg5UXhabkRNeVplXC9OZEVvRlpDNmZwYXdOeFdqMkNxSkliYzAxSlpNZjJUWnRjd3lpVHd3d24rWXByUXoifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH V3] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry, I re-sent the old version.
Please redirect to V4 patch.

Thanks
Zhang Chen

> -----Original Message-----
> From: Zhang, Chen
> Sent: Thursday, July 18, 2019 5:22 PM
> To: Li Zhijian <lizhijian@cn.fujitsu.com>; Peter Maydell
> <peter.maydell@linaro.org>; Jason Wang <jasowang@redhat.com>; qemu-dev
> <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH V3] net/colo-compare.c: Fix memory leak and code style is=
sue.
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> This patch to fix the origin "char *data" menory leak, code style issue a=
nd add
> necessary check here.
> Reported-by: Coverity (CID 1402785)
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  net/colo-compare.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 909dd6c6eb..fcccb4c6f6 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -127,6 +127,17 @@ static int compare_chr_send(CompareState *s,
>                              uint32_t vnet_hdr_len,
>                              bool notify_remote_frame);
>=20
> +static bool packet_matches_str(const char *str,
> +                               uint8_t *buf,
> +                               uint32_t packet_len) {
> +    if (packet_len !=3D strlen(str)) {
> +        return false;
> +    }
> +
> +    return !memcmp(str, buf, strlen(str)); }
> +
>  static void notify_remote_frame(CompareState *s)  {
>      char msg[] =3D "DO_CHECKPOINT";
> @@ -1008,21 +1019,24 @@ static void
> compare_notify_rs_finalize(SocketReadState *notify_rs)  {
>      CompareState *s =3D container_of(notify_rs, CompareState, notify_rs)=
;
>=20
> -    /* Get Xen colo-frame's notify and handle the message */
> -    char *data =3D g_memdup(notify_rs->buf, notify_rs->packet_len);
> -    char msg[] =3D "COLO_COMPARE_GET_XEN_INIT";
> +    const char msg[] =3D "COLO_COMPARE_GET_XEN_INIT";
>      int ret;
>=20
> -    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
> +    if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
> +                           notify_rs->buf,
> +                           notify_rs->packet_len)) {
>          ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true=
);
>          if (ret < 0) {
>              error_report("Notify Xen COLO-frame INIT failed");
>          }
> -    }
> -
> -    if (!strcmp(data, "COLO_CHECKPOINT")) {
> +    } else if (packet_matches_str("COLO_CHECKPOINT",
> +                                  notify_rs->buf,
> +                                  notify_rs->packet_len)) {
>          /* colo-compare do checkpoint, flush pri packet and remove sec p=
acket */
>          g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +    } else {
> +        error_report("COLO compare got unsupported instruction '%s'",
> +                     (char *)notify_rs->buf);
>      }
>  }
>=20
> --
> 2.17.GIT


