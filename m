Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24E8C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B8F20714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B8F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ5W9-00088L-QA
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 21:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jJ5V9-0006ou-Ih
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 21:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jJ5V7-00078b-SQ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 21:15:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:41481)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jJ5V7-00076E-I2
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 21:15:33 -0400
IronPort-SDR: fAXQK+7H3EAKEqBRqhT/4C6uDiGYIkToEboqlI9ojKcuaGL9SvwRIrkDlPqoZC8u9Cauen6Da+
 YQpnJGOf//2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 18:15:32 -0700
IronPort-SDR: xiRJMhOWYnmZ1eQbezc10lX7eJwJYn3+CihczhZzG80AJlj7R8mcOlWJTGL5rDKzy71SvJFNqk
 Nyec9+7aXsLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,326,1580803200"; d="scan'208";a="239979572"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2020 18:15:32 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 18:15:31 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 31 Mar 2020 09:15:30 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 31 Mar 2020 09:15:30 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Derek Su <dereksu@qnap.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Thread-Topic: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Thread-Index: AQHWBP8jbziCKwk6wUatrdITk0cinKhh6ZMQ
Date: Tue, 31 Mar 2020 01:15:30 +0000
Message-ID: <302c2946a968453fa3c77b17a14f0328@intel.com>
References: <20200328124646.7778-1-dereksu@qnap.com>
 <20200328124646.7778-3-dereksu@qnap.com>
In-Reply-To: <20200328124646.7778-3-dereksu@qnap.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.151
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "jwsu1986@gmail.com" <jwsu1986@gmail.com>, "chyang@qnap.com" <chyang@qnap.com>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>,
 "ctcheng@qnap.com" <ctcheng@qnap.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> Subject: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary =
or
> secondary queue
>=20
> The pervious handling of the full primary or queue is only dropping the
> packet. If there are lots of clients to the guest VM, the "drop" will lea=
d to the
> lost of the networking connection until next checkpoint.
>=20
> To address the issue, this patch drops the packet firstly.
> Then, do checkpoint and flush packets.
>=20
> Signed-off-by: Derek Su <dereksu@qnap.com>

Looks good for me.
Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

> ---
>  net/colo-compare.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> cdd87b2aa8..fe8779cf2d 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -125,6 +125,12 @@ static const char *colo_mode[] =3D {
>      [SECONDARY_IN] =3D "secondary",
>  };
>=20
> +enum {
> +    QUEUE_INSERT_ERR =3D -1,
> +    QUEUE_INSERT_OK =3D 0,
> +    QUEUE_INSERT_FULL =3D 1,
> +};
> +
>  static int compare_chr_send(CompareState *s,
>                              const uint8_t *buf,
>                              uint32_t size, @@ -211,8 +217,10 @@ static i=
nt
> colo_insert_packet(GQueue *queue, Packet *pkt, uint32_t *max_ack)  }
>=20
>  /*
> - * Return 0 on success, if return -1 means the pkt
> - * is unsupported(arp and ipv6) and will be sent later
> + * Return QUEUE_INSERT_OK on success.
> + * If return QUEUE_INSERT_FULL means list is full, and
> + * QUEUE_INSERT_ERR means the pkt is unsupported(arp and ipv6) and
> + * will be sent later
>   */
>  static int packet_enqueue(CompareState *s, int mode, Connection **con)
> { @@ -234,7 +242,7 @@ static int packet_enqueue(CompareState *s, int
> mode, Connection **con)
>      if (parse_packet_early(pkt)) {
>          packet_destroy(pkt, NULL);
>          pkt =3D NULL;
> -        return -1;
> +        return QUEUE_INSERT_ERR;
>      }
>      fill_connection_key(pkt, &key);
>=20
> @@ -258,11 +266,12 @@ static int packet_enqueue(CompareState *s, int
> mode, Connection **con)
>                       "drop packet", colo_mode[mode]);
>          packet_destroy(pkt, NULL);
>          pkt =3D NULL;
> +        return QUEUE_INSERT_FULL;
>      }
>=20
>      *con =3D conn;
>=20
> -    return 0;
> +    return QUEUE_INSERT_OK;
>  }
>=20
>  static inline bool after(uint32_t seq1, uint32_t seq2) @@ -995,17 +1004,=
21
> @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)  {
>      CompareState *s =3D container_of(pri_rs, CompareState, pri_rs);
>      Connection *conn =3D NULL;
> +    int ret;
>=20
> -    if (packet_enqueue(s, PRIMARY_IN, &conn)) {
> +    ret =3D packet_enqueue(s, PRIMARY_IN, &conn);
> +    if (ret =3D=3D QUEUE_INSERT_OK) {
> +        /* compare packet in the specified connection */
> +        colo_compare_connection(conn, s);
> +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> +        colo_compare_inconsistency_notify(s);
> +    } else {
>          trace_colo_compare_main("primary: unsupported packet in");
>          compare_chr_send(s,
>                           pri_rs->buf,
>                           pri_rs->packet_len,
>                           pri_rs->vnet_hdr_len,
>                           false);
> -    } else {
> -        /* compare packet in the specified connection */
> -        colo_compare_connection(conn, s);
>      }
>  }
>=20
> @@ -1013,12 +1026,16 @@ static void
> compare_sec_rs_finalize(SocketReadState *sec_rs)  {
>      CompareState *s =3D container_of(sec_rs, CompareState, sec_rs);
>      Connection *conn =3D NULL;
> +    int ret;
>=20
> -    if (packet_enqueue(s, SECONDARY_IN, &conn)) {
> -        trace_colo_compare_main("secondary: unsupported packet in");
> -    } else {
> +    ret =3D packet_enqueue(s, SECONDARY_IN, &conn);
> +    if (ret =3D=3D QUEUE_INSERT_OK) {
>          /* compare packet in the specified connection */
>          colo_compare_connection(conn, s);
> +    } else if (ret =3D=3D QUEUE_INSERT_FULL) {
> +        colo_compare_inconsistency_notify(s);
> +    } else {
> +        trace_colo_compare_main("secondary: unsupported packet in");
>      }
>  }
>=20
> --
> 2.17.1


