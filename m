Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF477C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6783C208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjlUf6Uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6783C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHojo-0001FX-Db
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHoih-0000AW-Jx; Mon, 14 Sep 2020 09:40:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHoif-0002f2-H8; Mon, 14 Sep 2020 09:40:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id z9so101579wmk.1;
 Mon, 14 Sep 2020 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=f+sii84dn2lYT7q7EOfMOzcU12Sas9pWjWkkVvVto9w=;
 b=fjlUf6Uc9YI7+hq85I92Yw7L9hITJoMFAC7bKAbkiqoKizLrVYb4syAwREnQj1vnI6
 t9CX9QDA81fJSzxH0NzAsge7Y/XEU/m6Chq/QRTkyRU5cxXjz2lNS1r56/sHbng/Y73n
 b+YVgKiv24xIo1ydapf1qeAd7srKO8qIa0KhnoUcbtpSnLWiwl1eJqmLJLvuUUHEhEMA
 pobai5EeIZg0Cj/ashWksXC1LtXaxn2DldZY4v3C7fLAO4lkCwePRlrhH1c07uv/Nwwu
 /fgJMZRpsqcmvJMAQoPfe/kDbLULK/84U59BydSGLvRnbcoEp2jZHgEf+FeA4KjEYTEN
 0vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f+sii84dn2lYT7q7EOfMOzcU12Sas9pWjWkkVvVto9w=;
 b=IY+P0NKwsF7O68QVIIAVxOJWe60x74KdPEg2eLe5ZBccq64sfwa0RWAoZVlgjIm+ep
 shQAAbP4HfiJJrNWRWV+x4egA7TVN2Qy9exa2A9b7q1XO6SLwkIgygxnimLjEkZ83L+9
 NyPvH8rztXTJ3uf6vtBb0f1rsoQhbAdlGhbSi9+ry/yfaUHsT8dK1VO5fTCjHlxisFqa
 S5wfwXwVBFIbn4+piWBMWmm02JqmG65CQ5G6rexz0x8eyacW5FIFFFZCKPDW5WAZdG/D
 1dyyQrX9K+HysW64PP2M/W0dEHD+LBoBXpjaswDZxeUsZTFI4mzN92zJsEuYnyEtxB+x
 GVXA==
X-Gm-Message-State: AOAM531istzRelcus3fpJJlKgP6rOqn+IU+PbXeTtic61rgbYM/IR4jf
 Xo1qgOcIENF8XiEKLh0geKAkY5aYHqjHRQ==
X-Google-Smtp-Source: ABdhPJw2hmozeyYjO9S9sLXeYOpTJbuokxl1qBqzPG5iML9nNyBBuDWORmYDjobi+bjmEITh16i5eQ==
X-Received: by 2002:a1c:4381:: with SMTP id
 q123mr14624910wma.108.1600090831571; 
 Mon, 14 Sep 2020 06:40:31 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v17sm21961218wrc.23.2020.09.14.06.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 06:40:30 -0700 (PDT)
Date: Mon, 14 Sep 2020 14:40:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dima Stepanov <dimastep@yandex-team.ru>
Subject: Re: [PATCH v4 0/2] vhost-user reconnect issues during vhost
 initialization
Message-ID: <20200914134028.GA628463@stefanha-x1.localdomain>
References: <cover.1590396396.git.dimastep@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <cover.1590396396.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Qing Wang <qinwang@redhat.com>, qemu-block@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, Cong Li <coli@redhat.com>,
 dgilbert@redhat.com, qemu-devel@nongnu.org, raphael.norwitz@nutanix.com,
 fengli@smartx.com, yc-core@yandex-team.ru, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 12:11:17PM +0300, Dima Stepanov wrote:
> Before revising the vhost-user initialization code, we suggest adding
> the sanity checks to be aware of the possible disconnect event and that
> the vhost_dev structure can be in "uninitialized" state.
>=20
> The vhost-user-blk daemon is updated with the additional
> "--simulate-disconnect-stage=3DCASENUM" argument to simulate disconnect d=
uring
> VHOST device initialization. For instance:
>   1. $ ./vhost-user-blk -s ./vhost.sock -b test-img.raw --simulate-discon=
nect-stage=3D1
>      This command will simulate disconnect in the SET_VRING_CALL handler.
>      In this case the vhost device in QEMU is not set the started field to
>      true.
>   2. $ ./vhost-user-blk -s ./vhost.sock -b test-img.raw --simulate-discon=
nect-stage=3D2
>      This command will simulate disconnect in the SET_VRING_NUM handler.
>      In this case the started field is set to true.
> These two cases test different QEMU parts. Also to trigger different code=
 paths
> disconnect should be simulated in two ways:
>   - before any successful initialization
>   - make successful initialization once and try to simulate disconnects
> Also we catch SIGABRT on the migration start if vhost-user daemon disconn=
ected
> during vhost-user set log commands communication.
>=20
> Dima Stepanov (2):
>   char-socket: return -1 in case of disconnect during tcp_chr_write
>   vhost-user-blk: delay vhost_user_blk_disconnect
>=20
>  chardev/char-socket.c     |  7 ++++---
>  hw/block/vhost-user-blk.c | 38 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 41 insertions(+), 4 deletions(-)

Hi Dima,
The cover letter mentions ./vhost-user-blk --simulate-disconnect-stage=3DN
to simulate unexpected disconnects but I don't see that option in
contrib/vhost-user-blk/.

Is there a test case?

Thanks,
Stefan

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fcswACgkQnKSrs4Gr
c8guXQf9ERZnmkWgwwgG9SEwEKB7lH3drZaJ/d6LBr9gz88d+iX4661DHQYh/lhk
1F7WK9Raa/iSSg5O53du6nVeO0oFz8d8N0rtAEIeukQLnUYNx++iNP3CICmxrmyk
Uv+jgI1c0+A0i0hQZXGtQY/S4+akS1JVPK4xN4S97FQ/UJNBDzilOLR8Xgwvhen+
ewGQ4EE9XbA/Wnm3HsYkNKXZWMaYZbDEoAlIv7QXlIYGlLOQqyDPcsVcz+ukp8QJ
WbwXCU/hQt1EUZIxceVm7uNAvA8u3LXgp3xmBoV7HsEJTrkN3yu73eY4ALlyWv4/
7QGryK8E2gUwsRae2UO7U9GfZ87d/w==
=wCGC
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

