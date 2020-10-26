Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1B022247
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5NnCLss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1B022247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWwHU-0002bW-DP
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kWwGN-00028p-Vk
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kWwGM-0007hT-17
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603694748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9XgLRF8gmVfdjpwKlNhg3+9W1qrwLqgBoGD3JOBxsM0=;
 b=b5NnCLssYlwfWO7ZpS3+FhWH399omftMzYvvF7ugcCw0jSuFkGU25lxWCvxb+vwouaTIsn
 /hTHLmWmez1YO+ERM9hALAfdKTTQgJ8lsbI8K3eeWpgINiVIaQfycmWb8KEj6dJJXI/JLZ
 4S0Wwo0hmCf7oDTjrDI7gyRw5zeaTiE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-EVcKt0KOOdKgoSe7yXHGDg-1; Mon, 26 Oct 2020 02:45:45 -0400
X-MC-Unique: EVcKt0KOOdKgoSe7yXHGDg-1
Received: by mail-pg1-f197.google.com with SMTP id j5so1240617pgt.4
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 23:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=57L6LHQJ3ZISpXuBwDjdkNh/D7kOY/CXLFEAjZZT11I=;
 b=X1kFCSdx6zvzwLL96D3F+qLfxvQpFH8zxKVKqeEDnJ+Hi5YbhVSegAuAI529woV4DV
 +uzCMQyCTNXqHGCrCibfHCAU9x5o6unu2IjTqNEEIJeyE2JD9T4XJZnfTkX9ZgdFQx8u
 Zy19u2DIaqcTEQagWWGauDK7avplGPjSa1CpRUa2BO/EVSY7HRURVTl3MMokj6mEaLn9
 gAD4tAl8hoZyGNOv2xzZoULXbJ37SxlNomiqMjiLs4Cv02v8rI1lJw/vhK29D7NK6bgK
 aTqir7Vp9/n2pTNFsbUSVmov9XZOWTrhpSkE06raqKX71WnaORrthiWxZfUl0Z2Vo1gw
 NBvA==
X-Gm-Message-State: AOAM531mxUkEX50m4MMNJUt0d/UIHLFVXWPMJrP5nz5/KJ0TmIJumdIl
 C2qDnXv0QJB/Y+iVHoI5pzQM8MG+eYZGRkWnASVcYWzPqsRkERzKZxT5nFWnsrQQlalN6yHxMKo
 GwmP8fuP5OgRRGdc=
X-Received: by 2002:a17:90b:1096:: with SMTP id
 gj22mr18550171pjb.183.1603694744618; 
 Sun, 25 Oct 2020 23:45:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyArwU2CMO6hGOqa0CLSfWheps9QYFiIinjLBOEbm60M7YsoDpADfA2Hu9OQEojxquuPwfI/Q==
X-Received: by 2002:a17:90b:1096:: with SMTP id
 gj22mr18550158pjb.183.1603694744417; 
 Sun, 25 Oct 2020 23:45:44 -0700 (PDT)
Received: from yekko.fritz.box ([2001:4479:e200:1100:3c24:4d96:ea81:be55])
 by smtp.gmail.com with ESMTPSA id n1sm9223150pgl.31.2020.10.25.23.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2020 23:45:44 -0700 (PDT)
Date: Mon, 26 Oct 2020 17:45:37 +1100
From: David Gibson <dgibson@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201026174537.128a4173@yekko.fritz.box>
In-Reply-To: <CAC_L=vUgsh=08m8EEuEucRtdX73X5kw5ov4Ekg7jFjbHsU6f2w@mail.gmail.com>
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <CAC_L=vUgsh=08m8EEuEucRtdX73X5kw5ov4Ekg7jFjbHsU6f2w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgibson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/6D3mQxb_I=ExoMfFbMhLmkv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/6D3mQxb_I=ExoMfFbMhLmkv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Oct 2020 09:26:48 +0300
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:

> Hi Michael,
>=20
> On Thu, Oct 22, 2020 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote=
:
>=20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> Simplistic does not mean wrong or incorrect.
> I fail to see why it is not enough.
>=20
> What QEMU can do better? Wait an unbounded time for the blinking to finis=
h?

It certainly shouldn't wait an unbounded time.  But a wait with timeout
seems worth investigating to me.

> What if we have a buggy guest with a kernel stuck in blinking?
> Is QEMU's responsibility to emulate the operator itself? Because the
> operator
> is the one who is supposed to wait.
>=20
>=20
> Thanks,
> Marcel
>=20
> [...]


--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/6D3mQxb_I=ExoMfFbMhLmkv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+WcJEACgkQbDjKyiDZ
s5JH/Q/5AWBHlTDNiUibuDxo77r5BwboL/g7cltfL/BdSoSLm2y892rny5g7BD0U
esNyU9k7pUTUe8GBWFyp5M4d1+5OrO2Wj8yhhhmmAnh7WYyZznb2hr9pgN+/L+X5
RGT4kqwqo4PTeVTBA0vgfIF8OEP8na8T/D43qg9MZ3Z4kgjDGIAfD+CwGPXQOGcv
aMXnVeLQ6PKbYTDVnXgy1xZoJ0TOvSupBKSr1BsS80xghIgU23vzygRiLx/k3IFP
P+Lyt4Drv7hrOpCN6L+sqWtYWL3KAdRI4wHxY2Sek3oP1z60rI/4g0HVWLZy8PHC
eqNV6KNOfUm1CCddoR7JoMHb31l2gCillOK0OnJQYoaxF3w6rXK1Rt+BVfNkqpcH
YnU6vUkkBAoJGvfMZaOmHNmS6sZXnUR8aEEkTsDlYlga0hikU/oDrd/7iINk7DcE
Cdzso/g6l3W2WAaN+0jclv9wNdoYwYky6QgBd3vcFGbKk/EB8UYUJfZGNTR6HavN
V4wQtvoNRCB4gmVNEZOlraSZz6yYyORbWl40l8cmYtPTw2Px1rhpGJUtbumEPPKZ
PtIa42u7Mqxauzr84I5N2sko8WtDAgt8gtcPjE7dyun+i0RKWVAleHRI0fLKtBnR
JCbpGGC3i2QICkAXAmTsbUbfg3t4fN3Z75/qLc4cpfhXZzAf6yA=
=5dx5
-----END PGP SIGNATURE-----

--Sig_/6D3mQxb_I=ExoMfFbMhLmkv--


