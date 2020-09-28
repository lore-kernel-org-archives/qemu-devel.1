Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82732C47420
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E414622262
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E414622262
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMo1j-000164-Mq
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 03:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMnws-0006X6-21; Mon, 28 Sep 2020 03:51:51 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kMnwp-0000mn-Ap; Mon, 28 Sep 2020 03:51:49 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id CAACA580129;
 Mon, 28 Sep 2020 03:51:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Mon, 28 Sep 2020 03:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=CpqnTLEdugbPMWpapaa1UpYzDyj
 DwYAHkUpuLvhbAMQ=; b=Eo8ymBY5jzvIIzDjNmQZLd94wZd0F8keqV6yeUs+//j
 KgalHVNanNlJo4uhIDyq8q2aroz78dfTuBqtTVkkpknJAge9dNJ+6Ij49wMietk1
 AvqlsPXTQq3mr4Py0lH3uJWLCY0VPsoKwZHBFdyK8BUyXeNDrvf/8Aaldsk35ebJ
 5SCl284GG6bb+jmtitczztoaMyNHwYtEy62NWHAMX5EUPBGOTSkmLJJYiCz6q65j
 8P/GAAl6tNTNWWreeDdNmX4UIifUHz7CYwjxPSrpap7PWIKZkJobi9aMZKp02ufi
 beX60Sc9Xo5HzGi/9bp2aOyVLqpJehM8NCMb6kF2vzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=CpqnTL
 EdugbPMWpapaa1UpYzDyjDwYAHkUpuLvhbAMQ=; b=tiJnOTCMbvxzKzkP/rrb1E
 0WW9915brJ60wdC4EYdEs143wXb+/BArSJpkfhePW8l6C1j1OqjnurbNRjPLP5ct
 uY6y3UtsxACA1Wyvguycihh6VhvBKQjy4GAKcvvXIg2Z8+veTfm1u89/qyetiQzc
 ySy3wGI7iVQKm4Y9wtcRvfGtdP+p/+C/HPjYK0gwEObOX13KaQ19U548C0R6osW0
 yNOzVQejkIJkUmfepO/3d47OPSt/0gp/CoKt85l1OKWjRuDwbHls9c44jJkB5v2m
 2OOP/4Pmof5xFZse9r7wiPSxAbr9Jzb23hEmLy7k/q5CdNpSUKHEfWQ+wcH35KKA
 ==
X-ME-Sender: <xms:D5ZxX7a3xwpe1QaRkNg4jNGr_nn5mKuJ-tf4aQUrnCaf_F4ZUmNX8Q>
 <xme:D5ZxX6bY1H1_WUAT15buGQ9chcQ1n8ClJCYkMdMFDQNei8bXh5QVPYlkOHa61HMoX
 M6tOOVTOC4E4mH88xE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehgdduvdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:D5ZxX9-6rXLUO1N4AAb-jMqVXWmyQDo-KqAo39fDg2BNoRNkf9JSkw>
 <xmx:D5ZxXxpXVNZJ_9ZcdPSyUNg0rZaNmU9BKih-QOZn6NOROklT2SGeGg>
 <xmx:D5ZxX2o2ZhwUkAYNq7OkcNZxejP9BhgqPoIb2TuhGbEwRJUjeERM_A>
 <xmx:EZZxXzTb9KEkIUC91DmrPzQU9nDc0B0XlGyiHjOe8_ilyxTkQ2Q7VjTp6Xs>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1895C328005A;
 Mon, 28 Sep 2020 03:51:41 -0400 (EDT)
Date: Mon, 28 Sep 2020 09:51:40 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 13/14] hw/block/nvme: Use zone metadata file for
 persistence
Message-ID: <20200928075140.GC1967@apples.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-14-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20200928023528.15260-14-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 02:36:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 28 11:35, Dmitry Fomichev wrote:
> A ZNS drive that is emulated by this module is currently initialized
> with all zones Empty upon startup. However, actual ZNS SSDs save the
> state and condition of all zones in their internal NVRAM in the event
> of power loss. When such a drive is powered up again, it closes or
> finishes all zones that were open at the moment of shutdown. Besides
> that, the write pointer position as well as the state and condition
> of all zones is preserved across power-downs.
>=20
> This commit adds the capability to have a persistent zone metadata
> to the device. The new optional module property, "zone_file",
> is introduced. If added to the command line, this property specifies
> the name of the file that stores the zone metadata. If "zone_file" is
> omitted, the device will be initialized with all zones empty, the same
> as before.
>=20
> If zone metadata is configured to be persistent, then zone descriptor
> extensions also persist across controller shutdowns.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.c    | 341 ++++++++++++++++++++++++++++++++++++++++--
>  hw/block/nvme-ns.h    |  33 ++++
>  hw/block/nvme.c       |   2 +
>  hw/block/trace-events |   1 +
>  4 files changed, 362 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index 47751f2d54..a94021da81 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -293,12 +421,180 @@ static void nvme_init_zone_meta(NvmeNamespace *ns)
>              i--;
>          }
>      }
> +
> +    if (ns->params.zone_file) {
> +        nvme_set_zone_meta_dirty(ns);
> +    }
> +}
> +
> +static int nvme_open_zone_file(NvmeNamespace *ns, bool *init_meta,
> +                               Error **errp)
> +{
> +    Object *file_be;
> +    HostMemoryBackend *fb;
> +    struct stat statbuf;
> +    int ret;
> +
> +    ret =3D stat(ns->params.zone_file, &statbuf);
> +    if (ret && errno =3D=3D ENOENT) {
> +        *init_meta =3D true;
> +    } else if (!S_ISREG(statbuf.st_mode)) {
> +        error_setg(errp, "\"%s\" is not a regular file",
> +                   ns->params.zone_file);
> +        return -1;
> +    }
> +
> +    file_be =3D object_new(TYPE_MEMORY_BACKEND_FILE);
> +    object_property_set_str(file_be, "mem-path", ns->params.zone_file,
> +                            &error_abort);
> +    object_property_set_int(file_be, "size", ns->meta_size, &error_abort=
);
> +    object_property_set_bool(file_be, "share", true, &error_abort);
> +    object_property_set_bool(file_be, "discard-data", false, &error_abor=
t);
> +    if (!user_creatable_complete(USER_CREATABLE(file_be), errp)) {
> +        object_unref(file_be);
> +        return -1;
> +    }
> +    object_property_add_child(OBJECT(ns), "_fb", file_be);
> +    object_unref(file_be);
> +
> +    fb =3D MEMORY_BACKEND(file_be);
> +    ns->zone_mr =3D host_memory_backend_get_memory(fb);
> +
> +    return 0;
> +}
> +
> +static int nvme_map_zone_file(NvmeNamespace *ns, bool *init_meta)
> +{
> +    ns->zone_meta =3D (void *)memory_region_get_ram_ptr(ns->zone_mr);

I forgot that the HostMemoryBackend doesn't magically make the memory
available to the device, so of course this is still needed.

Anyway.

No reason for me to keep complaining about this. I do not like it, I
will not ACK it and I think I made my reasons pretty clear.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9xlgkACgkQTeGvMW1P
Demyhwf+P5lQB3/Eq6yklOcWKJgypu34io55p/ONPMdj3KVaCYVeTcyriZSMwa7/
8PaLgdRExYkoQwZolpiiWusmM9BERpvvBX1yiSjgI308KLz+PV6JP4ZTZC21WaP8
z+mCf2s4KDO1cFJzH/0RdDjLQFwksU5O8x1j7dzRcFzAXsnOkvchiN0XZH7JS57+
o6HbxWilLG7vfYZEVuTsYm9PntXPW4tOCHYCOPD2RFhsnYZ8NRogPls0KMx3aJPM
uMtkJ7T+hlLiJ+RBjwvHC1PC3jOIpK1PBKeOZhJK38SkYWDfMjlQL2QGC518JkOk
R0H/8Z5tuzqxXtjjbdr/o/yNZzpnQw==
=e0JA
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

