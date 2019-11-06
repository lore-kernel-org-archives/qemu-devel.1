Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F6C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071DD2173B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJPNUxNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071DD2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGlA-0006D0-9X
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSGjq-0005Rd-Vw
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSGjp-0002Q1-VR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:32:26 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iSGjp-0002PZ-Oc; Wed, 06 Nov 2019 03:32:25 -0500
Received: by mail-wr1-x441.google.com with SMTP id e6so22790433wrw.1;
 Wed, 06 Nov 2019 00:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PI1Ee9JC8SG5uF3AAVIToA/wXkCDJ9gZ5Oy1LOHEGMs=;
 b=sJPNUxNoLw3LvH2CRXOdrWhFml6ZX0dSUzkzU02KCD3JMTNo6h/VDIidWGLmlwdb4X
 3lxiClGgQNe9DJlYAFlxo1KoiJQSvY/K0oXOFxlUL84XUcagLA8M/3Znt4qFE7Pus4wt
 HyJy2kQ0ShiukLITlRcvVunGFIB+29s3+uFZSX+3uqwLE4c2w05om7K+eVFIV1zL54UM
 u2ivrznk3p0/RQAf2rDniX+m/QAPb5pbDfuaJu8KFkXgzJS2JMtwrchl0AOBd/e9jwy9
 gcHU9BzF8RrbvP84PqT9YsClEby+mpiDkW+415HT38OSP2nThjoJLVY4JmY0pjKc8+Xs
 zOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PI1Ee9JC8SG5uF3AAVIToA/wXkCDJ9gZ5Oy1LOHEGMs=;
 b=Ay5qG+Pudswi44Go76YOthz2cY5lmsXiYWg6tvMmFNGgcVtGqB+iWMOJMmG2QfIGGR
 7SVuBDWBbbFwXUXaWrsHn5SUvb9SvRUrP2xloxAEiushb7dViEfzeqq6qotPwKfvl68W
 WrbMGbWl4C8PmuuTH24oiHUujKV+PdgtpyfBdXVc/P32R6TXMviXsa2US/6KK8yhtegX
 c0fmRITgZ9OQcnC0dmektaZUufgDodLj0jxLhJAS6lt97FUvAmVNgqrzDs3JuUtXuAh3
 QaZ5IJXhAlVINYi+q7MqUb+g3gN8WNhqgxAOXNTT1OPzVqBybEdBCYRuqHdWmk8JBQng
 Dcww==
X-Gm-Message-State: APjAAAXBMlKnOUqwvILX8yN5Sl+IRZh3+S2ZGMhDPcugfsUEPWb1kROL
 9dB7SzfHSnoVGN3TQLcxKow=
X-Google-Smtp-Source: APXvYqz9A3BHVCaDEeR7WUo6uo1h3r8djlj4OhG9kts6b1OQs8hQX7oE5QZbWxNovIwY7nTFQ7yWEA==
X-Received: by 2002:a5d:4047:: with SMTP id w7mr1449843wrp.270.1573029144546; 
 Wed, 06 Nov 2019 00:32:24 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id u1sm33167907wru.90.2019.11.06.00.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 00:32:23 -0800 (PST)
Date: Wed, 6 Nov 2019 09:32:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: backup_calculate_cluster_size does not consider source
Message-ID: <20191106083222.GA189998@stefanha-x1.localdomain>
References: <1767781109.66.1572948164492@webmail.proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <1767781109.66.1572948164492@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2019 at 11:02:44AM +0100, Dietmar Maurer wrote:
> Example: Backup from ceph disk (rbd_cache=3Dfalse) to local disk:
>=20
> backup_calculate_cluster_size returns 64K (correct for my local .raw imag=
e)
>=20
> Then the backup job starts to read 64K blocks from ceph.
>=20
> But ceph always reads 4M block, so this is incredibly slow and produces
> way too much network traffic.
>=20
> Why does backup_calculate_cluster_size does not consider the block size f=
rom
> the source disk?=20
>=20
> cluster_size =3D MAX(block_size_source, block_size_target)

CCing block maintainers so they see your email and you get a response
more quickly.

Stefan

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3ChRUACgkQnKSrs4Gr
c8iw7ggAgmTIgT+MykFNQwwA8C8Y25mka53rQzGOnP5P+0oTLO7Uy/5M/Vqmhu+o
6HLtW6SIBN0NsGT85HhwqwhshZkl6o6S9JxOFYaB9QvmEXpj+IM7lj+KpHpkrMtv
zrzNqJ0b7Pprx/WJHn/bQj1qt6V7WYa1qbJgLiI7equttfVD2BJjtX/RfInOnlI6
n4E9ILj+NSd6tOEJxs8qHl8QH8msSswofLMsacaIsHM7G7Q5MceLBXzgxxZ1zoF9
Oz9qYl/EPaWNUhTQ/+t5j0NnPCz1fj/iJ1pKS9GMI+SEJh4EPAJvagbM1ejUk1QP
OibBNxNdtMf2JXCQI9i5h8H+ReD0Fw==
=GTPf
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

