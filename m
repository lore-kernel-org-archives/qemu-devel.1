Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B684C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652B920643
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bavXu5Sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652B920643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYfJ-0004N8-I1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVYbW-0000Vr-Vw
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:45:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVYbW-0007Zi-5l
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:45:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id r26so8494287wmh.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7ItO1q3xxMNwuqkCQvMpK8niR4rD7W0RUQydVApgkhE=;
 b=bavXu5SxfSFEOdDUIr3bIYr2pQtZ/yHpugQzQeyKwupCgfkJhO5DUjnppxb+EtWyuK
 GAdZsuVIeBE5U75UFTLZT28aVQj5gE60HbsN+j/x5SVivcxH1LWOH3mMoMW2sWMP9eLZ
 KGdDMZ6zRwZmq2DHSwH1vBWHfADPI+vieKSPOYf8ew9p0u2srpzLVF0kPUo6SaSowxmz
 r31Q4L2iwd8p0KQomTa7LgSk54H0gbWRSwYhOS1uQiidqVohz/3A6HYgaVvbyCByEIgo
 HYvMXsOt+yvNpju7ad1LRDprMxfmzGgb1x2mGeYTTeogrplHW+3mL2W7IyCStCbnCSQI
 +0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7ItO1q3xxMNwuqkCQvMpK8niR4rD7W0RUQydVApgkhE=;
 b=q5ANbTMponaw0jwZE6zIvrxB8gNVE7juepNVkQEgWe8kAZQcUiPm117eeEVe48cBMK
 MOitoAY7J6l0dzmjBkHnCkP8BzypisCq4GfD5fgQ//hB6bZCtWBJ5J23Nc1SeIIKoXfZ
 sSPaObFqNCN5TGpEAQfccitPA+ojoTe3AQSSVIf3wV8kfwcFzk/cFznrh6SwXziPGu1m
 rMQvMEfnpUXCfpn70LtmnbdCCX+Ptpaxy1BkV7aNOg66jbqOHxb1An6SFaXVPYd9KAAu
 eY1TgmUib1n0CMMy04DSjAGtAytFbNdDo09XwCIWp6m0mQaEn3j8huMmSTjQtcTCmeuD
 7gUw==
X-Gm-Message-State: AGi0PubdkZcMW66nFxMfm0oaK2honImX7iFt1zJZrzIp7fH76AmVjRTM
 oItPUFnKW6LqDqjRg8G43CE=
X-Google-Smtp-Source: APiQypKiStuHlwuFMSEYpsLw7ue99PKSUQrgQbmXCHe2I2b+dDdrRISzV5czKGJlyKDphQUn9nY+Gw==
X-Received: by 2002:a1c:6455:: with SMTP id y82mr13755251wmb.128.1588589140455; 
 Mon, 04 May 2020 03:45:40 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w12sm17876280wrk.56.2020.05.04.03.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 03:45:39 -0700 (PDT)
Date: Mon, 4 May 2020 11:45:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 3/4] device-core: use atomic_set on .realized property
Message-ID: <20200504104538.GC354891@stefanha-x1.localdomain>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200416203624.32366-4-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20200416203624.32366-4-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 11:36:23PM +0300, Maxim Levitsky wrote:
> Some code might race with placement of new devices on a bus.
> We currently first place a (unrealized) device on the bus
> and then realize it.
>=20
> As a workaround, users that scan the child device list, can
> check the realized property to see if it is safe to access such a device.
> Use an atomic write here too to aid with this.
>=20
> A separate discussion is what to do with devices that are unrealized:
> It looks like for this case we only call the hotplug handler's unplug
> callback and its up to it to unrealize the device.
> An atomic operation doesn't cause harm for this code path though.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/core/qdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f0c87e582e..bbb1ae3eb3 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -983,7 +983,7 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
>      }
> =20
>      assert(local_err =3D=3D NULL);
> -    dev->realized =3D value;
> +    atomic_set(&dev->realized, value);

A memory barrier is probably needed so that the atomic_read() thread
sees up-to-date dev fields.

Stefan

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6v8lIACgkQnKSrs4Gr
c8jDqggAgDuaoRQ42tmkGLXkYsxgRGSdXQnlREZ7mRp2G0d6/vxjuuY3vpAVJDMH
G5iU4+H3OgMtQQXsVtq2E3FPJJSOnvbnPrCC60EucRZQ0PhMGm7CPK531GSjBVeJ
exgUo0wtMctA5b1dD8TgwnzGNuPpeGWeyMYc7msknQDgFj4wHrDmxg/gLqkYH2Pc
BAI63O7O6eAYq+o4gPcXJNWBgtD52iDso1QIFb5q2KTunzgP74t6ekB71ZLbQwkR
dNs3hsQtZ5VD08mtEqRQazM12/OJkaHQ6WH4HSD23zOSGmSiF06Ea8DEQnBFw6U2
HQuw5U6+IFfHvdbqfVvUy8/60fIo1w==
=z8Gf
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--

