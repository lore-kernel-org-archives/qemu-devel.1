Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358AFC10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6447120678
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0civwsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6447120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJe2a-0004VE-49
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:03:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJe1g-0004Bv-Pq
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJe1f-0008Ru-Q9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:02:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hJe1f-0008R1-Gz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:02:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id t17so18506595wrr.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=oD+u8bJDgvpwKTG13+X2Xdxr9TT9QSlA31YNEFuf9ug=;
	b=A0civwsV147MoPGI/RYXxt+Thl8svZBm8JDjsQkUs6e91nf59jHO0jbAZzh+pcY/ql
	mO3/QH2jhqk1Ado2YoU7D7opy1uao8kfLZi5WeCTwGKm+OXvxMoJYPMo/ccO+myZgQvp
	XzCaEgBTnJDXzypDFgj3B3kdYXvP7Vu90ZpyZIs0x3wUI8vGyDiBiNytU3WqEmgDo7Q7
	RO+G2LxQDoODPoZGkwaA9U6pgKCSFO5MghIrIGYrHiwmkct6lu8oWZmsXu9fvPn2neCY
	jK6HR+XFHp5JYSQXO1/whsa5w/2Bu/0WzMe0aoJxRqfRC+56WOZ3D5BP3aHepBHVYBEz
	kDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=oD+u8bJDgvpwKTG13+X2Xdxr9TT9QSlA31YNEFuf9ug=;
	b=STh/pCNpMDtFdKv9mIywczjgsiozHvk6TQ9cLDnhnsdHEMQKs7QPtMz6+9pTrPQDbB
	hykFtJoF2qPzOPkFN/vaF0EiQ2UPFDUAbjGvhSQOBbUWqEDw6ws/0vej9nBvNowOVfFP
	IJTvyl/ivg6MtRSITKUqT0blfC4MvthDzoj2wT/xx+6sWyF+SgKZ7Tn4SV9IQUdiyLeJ
	hdfEOc+uVbTZShN8LGTbxhqBfmQp1F54PMNnmUsiW1LubrxKzq2lP3DmQjLmXXo2w0J5
	kQlf/JkTjYn/Dv7452/qUexeCAPNLNjya5BFRmlBj+NwvS0nfuBwZz0AaAkv1zkx57bA
	6ZWQ==
X-Gm-Message-State: APjAAAUPD4kz9Ao7U3udIK0QQfdQju6o9NXl0ZMkpPJzESruMBZcr8kn
	gwM+x7UeOsj5FkoHS58JZ3M=
X-Google-Smtp-Source: APXvYqxwqBY3TSUyZceHRwvwKQfGcgV9+sND9zNJ0xzWkHWuJJW0Y6+2AAC1RVmf9GAx2BLIbrGsYA==
X-Received: by 2002:adf:d081:: with SMTP id y1mr16054808wrh.283.1556197374070; 
	Thu, 25 Apr 2019 06:02:54 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	v18sm11450730wro.11.2019.04.25.06.02.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:02:53 -0700 (PDT)
Date: Thu, 25 Apr 2019 14:02:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190425130252.GA17806@stefanha-x1.localdomain>
References: <20190424152401.28304-1-stefanha@redhat.com>
	<20190424164447.GB18406@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20190424164447.GB18406@habkost.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] virtio: clarify VirtioPCIDeviceTypeInfo
 usage
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
Cc: sebastien.boeuf@intel.com, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425130252.taKCz_cvLQZTu097E7qvHyY5oRjFvZ2xjuxngA3tmcs@z>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 01:44:47PM -0300, Eduardo Habkost wrote:
> On Wed, Apr 24, 2019 at 04:24:01PM +0100, Stefan Hajnoczi wrote:
> > How to use .base_name, .generic_name, .transitional_name, and
> > .non_transitional_name can be confusing.
> >=20
> > Existing devices have .generic_name but its behavior is somewhat magic.
> >=20
> > Devices added to new versions of the VIRTIO specification should forego
> > transitional mode completely and always operate in non-transitional mode
> > because there are no existing drivers for them that require backwards
> > compatibility.
> >=20
> > This patch adds comments that hopefully make it easier for developers to
> > decide how to fill out VirtioPCIDeviceTypeInfo.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> > index 18581854ca..debdee28b3 100644
> > --- a/hw/virtio/virtio-pci.h
> > +++ b/hw/virtio/virtio-pci.h
> > @@ -209,7 +209,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
> >       * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONA=
L_PCI_DEVICE,
> >       * but PCI Express is supported only in non-transitional mode.
> >       *
> > -     * The only type implemented by QEMU 3.1 and older.
> > +     * The only type implemented by QEMU 3.1 and older.  This type is =
less
> > +     * explicit than the transitional and non-transitional device type=
s.  Its
> > +     * behavior can be affected by machine type compat properties.
>=20
> I'm not sure what you mean here.  All types can be affected by
> machine type compat properties when necessary, don't they?

That's true.  I didn't realize that the compat properties are applied
after instance_init().

Will fix in v2.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwa/8AAoJEJykq7OBq3PIWi0H/3ZqK0ITByN1lq2o6Spg65zK
hqAcm5vYkcJ5E5HNtZQoQ+PfkT8v51yLrVYf1UbU0OVfYzmWeUeKwk5VOcJYxS4X
YBg5x7MQR8LOUxDgwYQYkNL2ID5FR8cTEAsxL8l/dqBVgm34nbxXfKfB2Zgmf1R/
STxmoTZwH/FPriS0Kr1S0nvHlJHWJBkZZw61GCML93lcUzz4k0N1NQiXGp8owLkN
wMD6xZCBto5TDYfXhO1bw2QN+u6NWvf1Rv0RNuUiw9sWPisyKk6yeiAyPcv70Ebh
tsIzQEiPTMHXk/URNI1HozjZGLvKhaH3pgfrI7NhL99FY0Td6+iHS/tyDRcB0IU=
=MKHc
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

