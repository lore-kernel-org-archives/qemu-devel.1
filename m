Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F0EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFA7208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXx8MWkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFA7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47787 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9gm-0002Bq-IO
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:52:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hP9SX-0004wV-56
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hP9SV-0001Ji-9I
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:37:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hP9SR-0001GF-HG
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:37:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id r4so8765454wro.10
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=IXYisd2zHrZjUov5dKVWL1eEl+9YXG6q5gEQ9uzRqSI=;
	b=PXx8MWkTJwiIyTOuh+UkpjObu//iP9V8KspNuR8IKKHGPiqDP6W9ZhutB/PWRULfh9
	c95uhWHhurG6a62Fus0O9ykwhbTfYTlYuxfz332vvQtKkplBluOHAB8QKl56VFZ7UcKj
	vSvJEfeJSY28aIEfSbXxKepuHLdfMDY/AwIwzUh+xieGr3TKEDtPGowURoogjSmkY94e
	86ye5x6RyJtixOlU3hZMFksppvDTxHYVbl58UUoFBqdgn4g2S3DX+KTmGEsrUwliHPat
	fG7uBQeOWr7cWMGc7zEYKUZu+jImf9TPAMtqTaoKl+euMlbf/2HubcrnLrNoJ1smaICt
	MaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=IXYisd2zHrZjUov5dKVWL1eEl+9YXG6q5gEQ9uzRqSI=;
	b=CGWxXQpUTLjvxPXPD0jYaHXgj7jGwuPPZy7Oiq8pjENeyTKybwMW6mf0hivQJTy4U6
	y1wwerFka0zAmLclK9HiClLbCzVDQIzzeS9uruFCszwMatt9oaDfHDVvPwSyxZXWn+bL
	fVvXUgEFzqo1+kT64fHTA+Gh6grQGLao7va/yJB6zmiCAlTNC4lUJ9zS0afLcAAFZhNm
	RPTPnMj44YKDy7fO9D5igpMHASGKXmmKEnbog2XNykBY+x7mXYPSVz0I3gz3WLqKrFpg
	cDHRtBTMjQUdk1q/DTkBxNJ4HgiV20EmWt+gFxMruB28a6N5Xy4EeSNMTt61deaqUaKE
	1zGQ==
X-Gm-Message-State: APjAAAXLOAqYri8FXr8SYuWuhUmL/q11I9jSopRVmi2bMmEgMaE90xvV
	Y/eMlE+FDoqew4dc8r022mA=
X-Google-Smtp-Source: APXvYqwRLTGx7edHduAMkjc3v4GNu8gaK2Og3b/hL/LNRiH6A5kxYycpy3MBDWjDJ41Y1wXksVt0Vw==
X-Received: by 2002:adf:ba43:: with SMTP id t3mr180510wrg.188.1557509837039;
	Fri, 10 May 2019 10:37:17 -0700 (PDT)
Received: from erokenlabserver ([41.203.78.145])
	by smtp.gmail.com with ESMTPSA id
	c139sm8598492wmd.26.2019.05.10.10.37.13
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 10 May 2019 10:37:15 -0700 (PDT)
Date: Fri, 10 May 2019 18:38:36 +0100
From: Ernest Esene <eroken1@gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190510173836.GB1927@erokenlabserver>
References: <20190504181119.GA3317@erokenlabserver>
	<20190509130056.GA17133@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20190509130056.GA17133@stefanha-x1.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2] chardev/char-i2c: Implement Linux I2C
 character device
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 02:00:56PM +0100, Stefan Hajnoczi wrote:
> On Sat, May 04, 2019 at 07:11:19PM +0100, Ernest Esene wrote:
> > Add support for Linux I2C character device for I2C device passthrough
> > For example:
> > -chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
>=20
> There is a mixture of "linux-i2c" and "char-i2c" names in this patch,
> which I find confusing.  Maybe you changed your mind while writing this
> code.  There are two options:
>=20
> 1. Call it "linux-i2c".  Other host operating systems will need their
>    own equivalent objects.
>=20
> 2. Call it "char-i2c" and make all the parameters optional since they
>    are likely to work differently on other host operating systems.
>=20
> I tend towards the second approach because I think I2C is simple enough
> that a single user-visible object can work on all host operating
> systems.
>=20
> Please make the naming consistent in the next revision of this patch.

My coding skills is limited to only Linux, I prefer the first approach
as is makes it easy.

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlzVtxQACgkQJZ4JoaCv
xKqotQ//cvT5BcR9WRnb/nl4Ei3/c0+w5Sibkv2eTEnQcS4O5RmK3b8heOWOhFl9
wJroDidcSmmtMmotPgs/K3758d5QLsE7DmkoBi1Oy720R01Ol0JjGpttQFQ/VkQf
6O71CHr3Mc1Rag7wTMyN7H+4P0SNLub6wSqAjQoR1DaBgVZIpOBxT1l/mXAUHyGi
Z/ZLOngMEC6gvKccFFfKVvivV59Ol0pgAaCKcbfy1/LMeEKlTvxBrv56nQzTY38V
Ikqtz/0+MLnFhhVPMvix+e9tS30Hslf+WwThtqkoIptBTumeTk42Bg/MDBQl+dMO
kLdN+ruxMCfktCOeYVqeRds4lHYcy7fZTIgdax5s3x5oMySjcejT9Uw/vBIeVG3y
KlZlNqIrlTJ7CAgKDatBW4VWnz0LvDqKhmVkfgcE7i3pKFPuWT89rmaKO0bqu0eV
S/nDZHiqm1FpSkYmOGaH7MTXiN0SPD0J9xdes7BESN8rjX1unthPiWnQVyVCZLjf
TjuYMZFGAtfaeZ3krRiofLwVpTOr8j1vmgwFCnrTZGq7UcXku4i1yb3jAR/1DwlY
t6WU2dbmbCwzCFUlSUhGgtz4HakUpQPEGvbj9e19tqwhGdoqeRRDGsR5v0URX5eI
jUAM9P69FYSWglsIRpJsQdAtEZBdYJdXjTOR8tdvgjjcLrIzDlQ=
=CTzZ
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--

