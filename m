Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFCFC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9F62084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvp/V7SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9F62084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQr5c-0003DQ-KF
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:24:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQr4R-0002cj-Gq
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQr4Q-0003oJ-GP
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:23:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hQr4Q-0003mO-9P
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:23:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id h11so1895789wmb.5
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 03:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=ORlIJW1ZD0nZ9aWk/z/m+9BDPE634oBXKYOP+njEA2M=;
	b=Wvp/V7SAK+XaS0KEUQqN0tHtfQg4GhZbrkbU30oH9D3yBuiItxmALROpr6BUdv3cFc
	fJw4qOPw+UtZ0NOEfNQOcrv/6AMwk7eGmNDnXrNVAjMWm/4jJteTE12bnOikWMM/4tyL
	uOd9MRbzoCzx8kdeL6JgUeM8li7oF+jsN5QVlmaByinCqh3PJDrx/hCvAsJni+77OeiB
	yRLhSqQccobGnd4VlU5wGHlSrGwGyUqXiqlx50qkPDA02HzRFAvV3LLp3JRzChMPiqRY
	ELgALLqJMgGfpeGFbyiGRMO3BA68YBxwmHu3a4n6KiQ+Qo0nzxRD13K2cFra/uc1j+r9
	hGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ORlIJW1ZD0nZ9aWk/z/m+9BDPE634oBXKYOP+njEA2M=;
	b=R71Ig8Wee//82NB+jdxfyQrL06yaFbxsNi+wzl9e4KTef65dhnXTF5XRKaQKhvOWZn
	ehtsnes17oF1DNZ/k9i3bS10K07aCGj9ca0jiYZ0vvyvvWJztpU2X8D7OyI1bEsPZ9ii
	ZVZAR6p7KzhjI4yKiTZdvvis1kp/ROZmp8ir4GXXao8FAkczV9fF2jdPjG7ISf5vs8L/
	HTqG5yy9u2fNSvJF0rWi/sk8g+cpwJD9sp6Z4FGN3kRJWC6pI9XsZl7aFnUNGnsdJF/H
	DEdPusT/xNgkBJyjFTFFghj17hJvt2+2XY1umEOPGBl/t9DBRAYTfQLadiodtzMW/7lh
	/MFw==
X-Gm-Message-State: APjAAAX7+3qUtAH+18f8wI/SlPb3a2Sat5O7yPsR9BrDZDjC2Wnkz9rz
	AwmO4zrvnB+V9SSziklYe/4=
X-Google-Smtp-Source: APXvYqyC9U/9S2NYRWTUdb/W11hIob9GALohAvHXn+Ut7PiEXLaUCkSPdjMQ3KjvN4x8WP7buaD5ow==
X-Received: by 2002:a1c:5fc2:: with SMTP id t185mr23189006wmb.95.1557915813322;
	Wed, 15 May 2019 03:23:33 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id 88sm3612384wrc.33.2019.05.15.03.23.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 03:23:32 -0700 (PDT)
Date: Wed, 15 May 2019 11:23:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1828508 <1828508@bugs.launchpad.net>
Message-ID: <20190515102331.GC29507@stefanha-x1.localdomain>
References: <155746839267.15002.8138674450166661929.malonedeb@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <155746839267.15002.8138674450166661929.malonedeb@wampee.canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [Bug 1828508] [NEW] qemu-img created VMDK files
 lead to "Unsupported or invalid disk type 7"
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
Cc: fam@euphon.net, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 06:06:32AM -0000, Jake Mikelson wrote:
> Public bug reported:
>=20
> Using qemu-img version 3.1.50 (v3.1.0-13607-geb2db0f7ba-dirty) on a
> Windows 10 machine.
>=20
> Converting a VHD to VMDK.
> qemu-img.exe convert "c:\test\AppD-VM01.vhd" -O vmdk -o adapter_type=3Dbu=
slogic -p "c:\test\AppD-VM01.vmdk"
>=20
> I have also tried:
> qemu-img.exe convert "c:\test\AppD-VM01.vhd" -O vmdk -o adapter_type=3Dbu=
slogic,hwversion=3D6 -p "c:\test\AppD-VM01.vmdk"
>=20
> Attaching the VMDK to a VM in VMware produces the following error when
> powering on.
>=20
> Power On virtual machine:Failed to open disk scsi0:1: Unsupported or inva=
lid disk type 7. Ensure that the disk has been imported.
> Target: MyVM1
> vCenter Server: VCENTER
> Error Stack
> An error was received from the ESX host while powering on VM MyVM1.
> Failed to start the virtual machine.
> Module DevicePowerOn power on failed.=20
> Unable to create virtual SCSI device for scsi0:1, '/vmfs/volumes/5cca0155=
-bdddf31d-2714-00215acbeb1e/AppD-VM01/AppDdisk1-VM01.vmdk'=20
> Failed to open disk scsi0:1: Unsupported or invalid disk type 7. Ensure t=
hat the disk has been imported.
>=20
>=20
> If I do not specify the adapter type, it creates an IDE VMDK which works =
perfectly.
>=20
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1828508

Which version of VMware are you running?

Stefan

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzb6KMACgkQnKSrs4Gr
c8hOswf+Nk4HcBAZ5RxLNDt+NlDABcpwPfVb5sVEAkj8LC5oLLjeXZFkph6DrYnX
y5b+X8YXpygOv8274ExDiQgb+3jtGLX5stTCNYBAkPW3BYMf8cBgSvCXaTG69yPn
rPIZi0Uw026adxGYupo0kk2I1URLomMaOjAWqhuj9q6/knmT297FqXAdaeahbyqy
IEPb/j9uGNDkpMGlM8YyLAGRhS41a9u4LzUeaighLbM3bFK4H9xrTc7iM9yTdALQ
xFCjDdJNCQqhumbm3JcynRxGqJuu9hQpdv9fzzejOi205rVCZK5Kgfq+EL1iaUJl
HAayyxK5Cc0ZJKU1sIGUV2nW3czHTw==
=bK94
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

