Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C5FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836DB20829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlAo2mZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836DB20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1SGY-0004lM-Q1
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 06:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k1SEO-0003gC-4z; Fri, 31 Jul 2020 06:25:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k1SEM-00028r-FQ; Fri, 31 Jul 2020 06:25:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id 88so27485621wrh.3;
 Fri, 31 Jul 2020 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZYFhERwvGY637AV/2sUa1XjFRSZ6Ve8TtVRxCJ2G52E=;
 b=XlAo2mZxLnEkjbUsh00aJgIbIIbO2h6Sepd3TpJ8LMnhZdeThl/DIaYmHkVpxQ6evX
 bnewG6Sdh6Fs5jQoEnvNzvfmVfQ18hLzvqj/k2QIdAmWxe4zG6B2MUUNGcd1DNGft1Xs
 6US7ETncqMLhBBUQQXpvws0yYFBH2rod7ILuth6lv+zH3YEXUZmYoMc27kvE0bHFw46S
 hQpWRJEuQ4zNjlS3KS8l/yBTA9XBCyZzGn3hbrSoP80X6g8c3oD/7DSZk1w6cJvpIaKi
 V7nQfuINf6mB+My8mNaW18EqFZcXUq7uDg+yncQFnwTw6hGAXxHdn4ti/WcLLTgzsbuF
 QFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZYFhERwvGY637AV/2sUa1XjFRSZ6Ve8TtVRxCJ2G52E=;
 b=dKgVDnNbIodZI4fNcDw3FyutpqdQw8+pdXi5qsuThyAj/a8Z6t5aej1bQGjHD9Wlgb
 t38BZjtFxR7AjAdv9dL4kLNrw2nJY9r0OWNrYjMpg3XK8HSopomnuU73o/fheNi4yfPT
 Mf/9xrvMMISHs+yXqU/nfQw8qgxBajlW2FerD6ng/kodQXWOlATG9t84g+eeptsZ6eDJ
 2n6Rt+NVnc0xnQt36SWhg+ZhqJrc2vEj7pMm+F6zlC9KS+ysLiNxQ3nZZSYgeOHvvtIM
 tl/mrIqhMe4RbPBB5K8pvAaPdCsOXZbx+4EU1/4u3+0MPWJOkt+07IdrFzBubkCA2ciG
 U+8g==
X-Gm-Message-State: AOAM533sfch8Xpvx99/zEA1/bVTCKRNIVAe6X0P5Q3rQwjoL39RFHEX0
 rSHelfqzT107ZfVRFRzSCr8=
X-Google-Smtp-Source: ABdhPJzafa3VUDEgVqgO5nKleAUg3TILXTbUHQHxn9bajoBmUOSB36UzLyEKPpvAx8+8+mVfkDMdKA==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr2869393wrr.396.1596191133833; 
 Fri, 31 Jul 2020 03:25:33 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 128sm12414487wmz.43.2020.07.31.03.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 03:25:32 -0700 (PDT)
Date: Fri, 31 Jul 2020 11:25:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 0/2] block: add logging facility for long standing IO
 requests
Message-ID: <20200731102531.GC177875@stefanha-x1.localdomain>
References: <20200710172711.8059-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20200710172711.8059-1-den@openvz.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 08:27:09PM +0300, Denis V. Lunev wrote:
> There are severe delays with IO requests processing if QEMU is running in
> virtual machine or over software defined storage. Such delays potentially
> results in unpredictable guest behavior. For example, guests over IDE or
> SATA drive could remount filesystem read-only if write is performed
> longer than 10 seconds.
>=20
> Such reports are very complex to process. Some good starting point for th=
is
> seems quite reasonable. This patch provides one. It adds logging of such
> potentially dangerous long IO operations.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>

If I understand correctly this only reports completed I/Os, so if the
host hasn't given up on an I/O request yet then QEMU will not report it
is taking a long time. In the meantime the guest could start printing
timeout errors.

I think this patch series is good as it is. In the future maybe a QMP
command that lists in-flight I/O requests would be nice. That helps
when troubleshooting I/Os that are hung.

Stefan

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8j8ZsACgkQnKSrs4Gr
c8itIgf9FFqGu9Shq78udz1uJ6Vc2RU+TtAShwvQj/sE/5r3fvZrHWE55wnDG552
apYsNSUSIiCYVvOV/KvGTwwYBSZeMleKAY12g0jgQ7AykxORUMVSR3pV2yO1X5I2
Lrz7pC5d/8RqMaoaDg1SKOuyptjoTv5x3ota09KdtIGSOwOZbb+iiJOqcISu7K3i
HI9wAWksbL81AkRC/Oei4yzPio/mbunN5GhKSklH7GTCsxx8xVdI+/R0GStIRL1x
IlIyJNgvyk52aXCrj9o6WQJLLirb9hTrQxL0pZ6tN44pNyNQVVhawERVpYemxvz0
75nohA6TtuKO8csmsYXDyvlws7/ZWQ==
=mzjR
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--

