Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB680C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7197020835
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRIwnfk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7197020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35937 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLs0z-0004dz-O4
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 12:23:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLrzb-0003lv-Mm
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLrzU-0001uQ-C9
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:21:56 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:40540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hLrzT-0001NO-RU
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:21:51 -0400
Received: by mail-it1-x143.google.com with SMTP id k64so10563075itb.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=HIM3K0zcfSn/egqvrFEMwlAI/9MqocEddrKLyJvw+Co=;
	b=oRIwnfk+5kyOrXqqtYxU3saEDZv/1NnsqVqobgE5LxCwlkAguOKBr3tfF1lWsJBjk4
	HQYO6tTklSqCnrjc9D+P1xxTrKTXjdctdDtZt79lZq6rZOcyOhcQJehUg0qyBiFVm7HZ
	HkIJup5hXO6peWF/oBnOHYGrThZaOV7/Ct85Hh9H594SaoGDBV0K9PQC6V0hSVyUfl0K
	t6CqFCeNNqeQmemmBY5KZ+fdE/mEAyIsxV8YDyXbUIE9H/6Oot/5ltZwP7b5jReC1OBU
	nFJ+DyPAD5e7qn10GqJBlR3maTPdALnrPTcx90IeP6DI932zEcvtw8q+UJZfECdhCyBA
	77IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=HIM3K0zcfSn/egqvrFEMwlAI/9MqocEddrKLyJvw+Co=;
	b=GVCMy94P78jh82ntruplDK8P6MtiXD41LZqaqPJLNZzUnYcxTJsbf18sm83If3AhAo
	vz5YuM/jZrDWmw3r2TYjs3rcvUrLgtpgVaJoDi6hOng3OfidXjagFqrYdOWizbhSrYrc
	ZBUm5WFntSralhpiNmJ6R5WleNvSJ67Kql7FKAGqP6hrYahuVPBoGdJs8VSoBLEkUBie
	KAirhXrV2GXLEgCyBt19aWHMz5Mg7pEPAeGPHyXMrLsXRuNGqGDklz9nlaSFVUxQA8k3
	PdAmW4SvnYN+9MasE8jIv5mMDtFfRxgw/vaCb92E+Wnvt5d2yxTZKRDD/uTqbCmiOaaj
	eJbA==
X-Gm-Message-State: APjAAAW6GjraiEGfeyb2fEh4PYzJmstpHaYFE60phTNM9ziGHmhZpoli
	KfkBkhh7ANXTpii1qBU2Ahw=
X-Google-Smtp-Source: APXvYqwPDcBh8RSdcWIIIpWCM1WE6P4cq3UL6o23YxBrs7RS7i7xP0UrRMtk2VRZSpbiXU+s7sBkBw==
X-Received: by 2002:a24:ad5f:: with SMTP id a31mr9509875itj.55.1556727701831; 
	Wed, 01 May 2019 09:21:41 -0700 (PDT)
Received: from localhost
	(CPE64777d5479c3-CM64777d5479c0.cpe.net.cable.rogers.com.
	[99.228.64.175]) by smtp.gmail.com with ESMTPSA id
	n138sm2983504itb.32.2019.05.01.09.21.40
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 09:21:40 -0700 (PDT)
Date: Wed, 1 May 2019 12:21:39 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190501162139.GC21155@stefanha-x1.localdomain>
References: <20190425130939.29674-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20190425130939.29674-1-stefanha@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v2] virtio: clarify VirtioPCIDeviceTypeInfo
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
Cc: sebastien.boeuf@intel.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501162139.fV2xPKS01Q7_z3MiqtfDFd1zNAOwyzRCwNIgaYu-Oak@z>


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 02:09:39PM +0100, Stefan Hajnoczi wrote:
> How to use .base_name, .generic_name, .transitional_name, and
> .non_transitional_name can be confusing.
>=20
> Existing devices have .generic_name but its behavior is somewhat magic.
>=20
> Devices added to new versions of the VIRTIO specification should forego
> transitional mode completely and always operate in non-transitional mode
> because there are no existing drivers for them that require backwards
> compatibility.
>=20
> This patch adds comments that hopefully make it easier for developers to
> decide how to fill out VirtioPCIDeviceTypeInfo.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Drop incorrect mention of machine type compat properties [ehabkost]
> ---
>  hw/virtio/virtio-pci.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Michael: This patch is for your virtio tree.

> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 18581854ca..0bd1fff942 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -209,7 +209,8 @@ typedef struct VirtioPCIDeviceTypeInfo {
>       * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_=
PCI_DEVICE,
>       * but PCI Express is supported only in non-transitional mode.
>       *
> -     * The only type implemented by QEMU 3.1 and older.
> +     * The only type implemented by QEMU 3.1 and older.  This type is le=
ss
> +     * explicit than the transitional and non-transitional device types.
>       */
>      const char *generic_name;
>      /*
> @@ -222,6 +223,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
>       * The non-transitional device type.  Optional.
>       *
>       * Implements INTERFACE_CONVENTIONAL_PCI_DEVICE only.
> +     *
> +     * New virtio device types should only define this and base_name, th=
ereby
> +     * allowing only non-transitional mode.
>       */
>      const char *non_transitional_name;
> =20
> --=20
> 2.20.1
>=20
>=20

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJx5MACgkQnKSrs4Gr
c8i8JAgAmZzBk7ZKK6fEUinAh5beow8nxry9vAJIZ0zLNyAq/9/KobMQYMEN6ZXU
ovccev6BKR0qL9fvWpP69UoUaWM8RU6ZKwfyZPLo3Wv9N7xB0s2LLEf/9ooN+3Zj
XcMrhIYPPNX8eeHWAUJ29qjCnE/sLbZ2tL4rewfhT87Bp+hLn3h8tCpIqCAcgMCv
Hc15Esd58WeaBHRAOfP8xht+4q/8g3O0z/mLFbF0a0EHO2BOwOF0klS38Zi8vove
OCck4saLTWuMuiKRIO9EOSIM+neRWikpRzlw/J6nNUqOlTBk5TH/drnpnla/Mc+F
tD0WCw9+9fspovZkgqYuk4kgjG/J8w==
=PQT5
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--

