Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3657C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D86E205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwFTzRg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D86E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpQR-0000zM-BA
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jDnyr-0002iX-T9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jDnyq-0008PE-Aq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:32:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jDnym-0007nW-Bc; Mon, 16 Mar 2020 07:32:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id y2so5255956wrn.11;
 Mon, 16 Mar 2020 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0B1+ctOJUlMj+e2dM5JEA0+BJKMby+bYJP0UlJ7Qstk=;
 b=QwFTzRg0oHAO/fEBVhSQwciA3qOmDMr829eC5UKNTt9V0gQi04iDx/ySVl/0lrIyhv
 BjvL0pa51za/WfOeGtpHv+n7OTmnTy872J5UxgGpXLe/l6ZHysjTfNAwGYrBXc/HwR02
 paEL0EkGvzgYjQlX+49gqFEjC8TtLtljm+KGSPXjLd/jspgtl7oeh936GMuIdzABPjUG
 qN2ccs2hr8GGVnTBXLan3tSG6TrUmeGEwRoFxiQZcslIC3wu1fKjM+NYz6mUmsUAp0zw
 PRY67OJutNsbMlDslZV1YPRdFE+EpKRVjbEcsrSykmgtCMWg6563dsHsMgZ2StMqegNf
 sxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0B1+ctOJUlMj+e2dM5JEA0+BJKMby+bYJP0UlJ7Qstk=;
 b=oNUYXn4Km7FhUVnruAm+UrdZDxZNZqq+89+6NOUd4p4qgzKqkvd2mscA2Yf3NaSFkw
 O7jEv7pcmwHKG1rOnZrFzAB/Du2zUkq6ON4T1TulddR+WQ5F/MOdKt1D63+gAC3Rbc7p
 MsAZy57B21RyYSkq242+kjA7iF7oFQSf/ftZvIxMSCZ1D3M55MaS7zDgu2Fd6krZbdql
 qNZSIHfBDb3tBZIXBdAm4ThipbV5rStKWcLPpQRzqMbC0vKbYu/zpb7kq/UqwgeFCn49
 3p/Stc0o+JpwgO2oJFkyGmf3hIMcuIAmdIvdbgLErOV1c44oD72uDbVjWLy5wLkHjkq3
 6+XQ==
X-Gm-Message-State: ANhLgQ13SlhY73Z8TXx1CfXO71uhR8wLusrs7ms2sXIWNsTkDq5f5V5Y
 IOgTP445UScrUl+ht7SqaxM=
X-Google-Smtp-Source: ADFU+vsscvatyrzuZll9UwYXJANZYc/UPG2ECGDmIMh622bfYAlsmNRcsOEZEyCdOSZexG61EwPy3w==
X-Received: by 2002:a5d:5290:: with SMTP id c16mr33944303wrv.235.1584358338965; 
 Mon, 16 Mar 2020 04:32:18 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g12sm19187742wrm.87.2020.03.16.04.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 04:32:17 -0700 (PDT)
Date: Mon, 16 Mar 2020 11:32:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Subject: Re: [PATCH RESEND v2] block/nvme: introduce PMR support from NVMe
 1.4 spec
Message-ID: <20200316113216.GB449975@stefanha-x1.localdomain>
References: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
 <20200310095147.GC140737@stefanha-x1.localdomain>
 <15b8a77d-50de-2228-a0e6-a461b82f1873@linux.intel.com>
 <CAJSP0QXatOWgicLo5sGt9KA2QupC2qXD2LCdHWKgHFdzgt9pEg@mail.gmail.com>
 <12576914-0ef4-efd2-355a-cff3f4eeae69@linux.intel.com>
 <20200312060827.gjddwgmevyptsmpl@apples.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20200312060827.gjddwgmevyptsmpl@apples.localdomain>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Zhang Yi <yi.z.zhang@linux.intel.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, kbusch@kernel.org,
 Max Reitz <mreitz@redhat.com>, "He, Junyan" <junyan.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 11:08:27PM -0700, Klaus Birkelund Jensen wrote:
> On Mar 11 15:54, Andrzej Jakowski wrote:
> > On 3/11/20 2:20 AM, Stefan Hajnoczi wrote:
> > > Please try:
> > >=20
> > >   $ git grep pmem
> > >=20
> > > backends/hostmem-file.c is the backend that can be used and the
> > > pmem_persist() API can be used to flush writes.
> >=20
> > I've reworked this patch into hostmem-file type of backend.
> > From simple tests in virtual machine: writing to PMR region
> > and then reading from it after VM power cycle I have observed that
> > there is no persistency.

Sounds like an integration bug.  QEMU's NVDIMM emulation uses
HostMemoryBackend and file contents survive guest reboot.

If you would like help debugging this, please post a link to the code
and the command-line that you are using.

> > I guess that persistent behavior can be achieved if memory backend file
> > resides on actual persistent memory in VMM. I haven't found mechanism to
> > persist memory backend file when it resides in the file system on block
> > storage. My original mmap + msync based solution worked well there.
> > I believe that main problem with mmap was with "ifdef _WIN32" that made=
 it=20
> > platform specific and w/o it patchew CI complained.=20
> > Is there a way that I could rework mmap + msync solution so it would fit
> > into qemu design?
> >=20
>=20
> Hi Andrzej,
>=20
> Thanks for working on this!
>=20
> FWIW, I have implemented other stuff for the NVMe device that requires
> persistent storage (e.g. LBA allocation tracking for DULBE support). I
> used the approach of adding an additional blockdev and simply use the
> qemu block layer. This would also make it work on WIN32. And if we just
> set bit 0 in PMRWBM and disable the write cache on the blockdev we
> should be good on the durability requirements.
>
> Unfortunately, I do not see (or know, maybe Stefan has an idea?) an easy
> way of using the MemoryRegionOps nicely with async block backend i/o. so
> we either have to use blocking I/O or fire and forget aio. Or, we can
> maybe keep bit 1 set in PMRWBM and force a blocking blk_flush on PMRSTS
> read.

QEMU's block layer does not support persistent memory semantics and
doesn't support mmap.  It's fine for storing state from device emulation
code, but if the guest itself requires memory load/store access to the
data then the QEMU block layer does not provide that.

For PMR I think HostMemoryBackend is the best fit.

Stefan

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5vY8AACgkQnKSrs4Gr
c8iqYQf/bmO+fr0LpsWgbwF3qkanc/Pw0OChZLTV634K4gsmtnb2uAbRWEM+CCvS
0nMT+mpEGs6hkyb0R+5grr3hk1c8C2gWvaJakUZD13F+HXyWyOny3TwU8NySSs6X
BbzV4r61CiPmOyC2TEhk/POx8OQ+mxNlHLz3ixD7tdLiCrNit9aq0AtPmsJRloq4
YHQQCILgB+YOQfE9ox7yn/IIy2aeq7nnj4mSuISex0A+98BbFdq1I0y6AEAQlwt8
gn+Gtcwm4hWV2xKOM87Px987Kb6aQJxHGwKiQZYgl5GTv4IyBHvdNpMaqZAW/G6r
eHks8RSiFQ1v1ULWY1Cz467CPoQ8Sg==
=8cKK
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--

