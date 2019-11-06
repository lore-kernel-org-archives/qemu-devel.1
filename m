Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E4EC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC23F2166E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD+jdRB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC23F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNEM-0004fm-S4
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSNDV-0003uP-TQ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSNDU-0002Ua-3g
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:27:29 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSNDT-0002Rh-T3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:27:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id q13so26339039wrs.12
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 07:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=44uH3AShVe/HpszkEuojBzIwRr0mf3pLIr9SH9+up0c=;
 b=ZD+jdRB2S5QX3jMHLJDa30IYmmps9PvQWvTpBWqys65JEw9/+F8wF3jFgDcDnIEY73
 N/qZgPksHRY1cBHbBsTO2ED20sK2x0RNjA5H7ER0XJ1cQOBFPFtvlWIM+R4THnJjNx1w
 7RjqGnaxGLD8QYKS+WloDy2J2K+i6Wa3e8hVbwis4x518ldTRn++ZgW+ONPyqd3nwsoP
 X5iTKeOo20Ix5PzRaJMo9PlN17dE4T6a25yAnzkJpfkE3NpZ3Q84BDUuIStI7TKn9kls
 uf66TJwAeu+24GGoaOZTNU92y3TFwFFbvNkAHw4KT47lt8NVqaoQa/mPiH33/OCOLC9/
 9I4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=44uH3AShVe/HpszkEuojBzIwRr0mf3pLIr9SH9+up0c=;
 b=AIBK7ulYgXR6mC9g28VBtS1KA2W7SycFEQUAQy/eFvPafJSqOoDXpghqntA7gOURES
 rYLQCiT7WdS+WgX80yYmnxfQctswgwbhoMPh0SzhY8FMu1ZHS9KLYsTwMJsCZIRGn0Vj
 zgyPy+HCDD+zrvWYcu51owyR4Hs7WHqkRF2ZtYgt4i4Nf9Z5u5Q6r6feeh7pRrOcey8r
 pCU6ye2qcR4+vcbidXR5EB18cG2lvqQl8W6xJTm3LujRcluLmJuZsB0813y68ExMR15x
 X6ynCrQI/lGjaoMMxxLYH/p/nKKaUh2GNU8mwyN4ZPUPLXK4Qw3dg4Z2RgayivLENm1U
 6SSQ==
X-Gm-Message-State: APjAAAXm0cl3i8cOgoonYx5KpdatQ3CNUNKzj9dd3KNhRdnaC5rEqoXS
 9ealufp5cNmpi8Z+xbLz+LxgQp3CdL0=
X-Google-Smtp-Source: APXvYqyqjQJI/i9ZzV4ZRXtxn2tZj/x/KGs4JBvAWTAVjoateHzhTBBsOaq7wrJZVd3UiFfDOgIttw==
X-Received: by 2002:adf:d091:: with SMTP id y17mr3355030wrh.182.1573054044811; 
 Wed, 06 Nov 2019 07:27:24 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id j3sm16747963wrs.70.2019.11.06.07.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 07:27:24 -0800 (PST)
Date: Wed, 6 Nov 2019 16:27:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/20] Add virtual device fuzzing support
Message-ID: <20191106152721.GF340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <157244903636.32191.2954681158974218419@37313f22b938>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <157244903636.32191.2954681158974218419@37313f22b938>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: alxndr@bu.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 08:23:57AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191030144926.11873-1-alxndr@bu.ed=
u/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>   CC      tests/test-qapi-types-sub-sub-module.o
>   CC      tests/test-qapi-visit.o
>   CC      tests/include/test-qapi-visit-sub-module.o
> /tmp/qemu-test/src/tests/test-char.c:31:13: error: static declaration of =
'main_loop' follows non-static declaration
>  static void main_loop(void)
>              ^
> In file included from /tmp/qemu-test/src/tests/test-char.c:10:0:
> /tmp/qemu-test/src/include/sysemu/sysemu.h:117:6: note: previous declarat=
ion of 'main_loop' was here
>  void main_loop(void);
>       ^
> make: *** [tests/test-char.o] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 662, in <module>

Oops, the main_loop() change definitely broke tests/test-char.c.  Please
take a look.

Stefan

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C5lkACgkQnKSrs4Gr
c8irKAf/RcWyf0ztc33lGLSFMzIt0iPg7HASIpmyUjUfZuJUITHLMlj5XmnLWIR+
KF5pCpgztJ31wjpbiq9DryyNl5kfbUAIPAhHeze0L0rFFYeerwekBfSAPHxdSOoP
ezXkT2B8BHPpex9XmQCzN8qx2bLsiFx9akcn+thijee4cNYzbB47bjavF1vuJ028
CPoMD3wmz4m1vKqK+sk5+MPgFhPvOKxBx3d42y56SM/Bvn9o8HAFnnZ+tOpbq9G2
Wpz4/JTJPTz7kM0sMA/DXviIn+GNVxreNy9ZURafq1fMRXJUTd9f/a3iOHatXsR0
4T5KgX1V6Tn1fiCH0uu7uMwVWZJVDQ==
=CTiw
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--

