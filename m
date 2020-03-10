Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36686C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F384A2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXj9yTXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F384A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbA3-0004xJ-ST
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jBb88-0002Mq-GD
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jBb86-0005jE-C4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:24:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jBb85-0005e5-U9; Tue, 10 Mar 2020 05:24:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id e26so440441wme.5;
 Tue, 10 Mar 2020 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eCDeSg7bCbu50R4Xu75uGm5JlyFJUqUmr7NN2D/J93A=;
 b=QXj9yTXpuLWn0ghU4cDJ3XNyg9SmVVPdqiaA4PooKXPRy6qktTTAU26AMGMRMHXQ/P
 RSq/x8+qSR9nLiVnlFQmASwFSYPImiYd19DTMIrt1UvIrp9aJ+C5mLwPtMpTgOK/N6jc
 Vtjb4QXDAC37IAqIPaMha+h/wZscwigqqccRCvOJlPq4kOqsyRgU1XN0Uc7kAQhwvnqV
 PzFCiGea5fGr0XwfmwtBp+5jbSNtFGq+JtTeJAkbVKB+D78VIXoS4O+S9MMdh0/O2x7I
 LF2rrVlIxd2CuZCznYJBfOdxSyXXE/FDvXxJZHNe+TOlSqNj9ehVV7Trvi4SrMIKxVsv
 U4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eCDeSg7bCbu50R4Xu75uGm5JlyFJUqUmr7NN2D/J93A=;
 b=g7na4LTZx9pDpfdmL/TiOC3Qd10jLH4CW9/EP6tR3sMSw99FQ6uWovEneB0X19X7Vd
 RldWUGgm4xl9RqNl0rDATSucWAKmsJAL1yP3sm0n0FY8rFQy2xa/+TzZqKRVdAy+Ez7S
 y7tZUulHZrc6JrmGqOhUUrpX0ItZ7ypErBimt6rpkU5FerVTxqP0EI7qNF3WuUmUJAaM
 awOvrAMsYWS9IZmlZUl7U5X5NYgT0+eAy7G9O5Wr99Fbt+96jSTPlawlQAMlpcdxAO3+
 SyRV+NtIBb6QIN192PGps3J8NV351odvRzh9ugGxqpNtZoJy2wTmUbUwSsa2oe923xga
 523g==
X-Gm-Message-State: ANhLgQ0SHm7MwUv3bMd9zN2f04zB15+e08eXYeuIC8LgxgitPxIKMUOK
 Gt7O8R1EQWfmCOWWuuUJpD8=
X-Google-Smtp-Source: ADFU+vseVdNk4oQmednFTm0Od9OyO9VhSDR4u7E5AToNjy/XjcqeGNM6rMt6RP9jJLkm4HPy54oqjA==
X-Received: by 2002:a05:600c:204a:: with SMTP id
 p10mr1156284wmg.55.1583832288214; 
 Tue, 10 Mar 2020 02:24:48 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o3sm3431950wme.36.2020.03.10.02.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:24:47 -0700 (PDT)
Date: Tue, 10 Mar 2020 09:24:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Lin Ma <LMa@suse.com>
Subject: Re: [Question] About GET LBA STATUS(16) support in qemu scsi
 emulation layer
Message-ID: <20200310092446.GA140737@stefanha-x1.localdomain>
References: <DM6PR18MB3322E8AF16F20D91557C3335C5FF0@DM6PR18MB3322.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <DM6PR18MB3322E8AF16F20D91557C3335C5FF0@DM6PR18MB3322.namprd18.prod.outlook.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: qemu-block@nongnu.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jon Maloy <jmaloy@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 06:18:00AM +0000, Lin Ma wrote:
> First of all, Thanks for your reply, Stefan.
>=20
> We know that the GET LBA STATUS works well under scsi lun passthrough due=
 to the vm directly talks to the scsi target.
> I'm curious that if I use file backend image(say qcow2) + qemu scsi emula=
tion, Does it make sense if I issue sg_get_lba_status in vm to get the lba =
status?
> If it doesn't make sense, That could explain why qemu scsi emulation laye=
r lack of this support for a long time and no user complains.

It does make sense to implement GET LBA STATUS because QEMU emulates the
UNMAP command.

Be careful though because there is no asynchronous bdrv_block_status()
API yet.  Internally the BlockDriver->bdrv_co_block_status() function is
already asynchronous because it runs in a coroutine.  It will be
necessary to expose a new bdrv_aio_get_block_status() or similar API so
the device models (i.e. SCSI emulation code) can take advantage of that.

Stefan

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5nXN0ACgkQnKSrs4Gr
c8iGvAgAwLMaZe4nhIFoRKE2U+LKImyrB04PP7d+hP3PfpA9ZCIKYkZbO4h1bkgQ
SFgswscS+UO/6DMhD8j8mDXwwBQF6hWy56UcjR3+prwc7zfVFUa2dlmdyXVuYE9n
2O7vtx704yA4y/zRo6oP53YSnbKvpCPFBONY3oKP1Aqx23Z5fxw2RH6K9UqoSFpf
NrEJd1lB/fgxnCBuKfP/uggCxxm4H5ifd1/x2vmVecrEZw/Oktt0ox2T5U2SNpN9
J9h6EgYcBWWK3YgHONphrWW+T12ivXLpl5tsCWgvgzMoAKkdifkqp5E+wib363nA
mAFBBXM9E71Ip+i3ajV5FBv5AolLOA==
=bTVo
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

