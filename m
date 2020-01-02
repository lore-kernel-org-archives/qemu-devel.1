Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A7DC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC9F215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnC+8mtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC9F215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imyIi-0006uB-6V
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1imyHt-0006Nu-BN
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1imyHr-00027s-Uk
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:05:09 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1imyHr-00027Y-L6
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:05:07 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so38790095wro.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=l83/c1T8nBlNrQ55eL8s0lWoociUz5gpSRjORX7QpEc=;
 b=lnC+8mtAlJ/acq3uLnDjFDaYprtvCy2FL/1xVp51Tjse76aT0yNwBuNeF/zDLiTTU7
 J+HaV3pwHkhbptF+VBeVtSJUdogJKFF4gOnyo3hXBoQ8X1cuGKOuBew4nWhBcdgEYopG
 PaKOKE/VucFHjDxicDeOBdoNmDOLqkNGD9UdL1EBpFRIfwASgipQ9qq4C/15pg1HnQXG
 BQSNL2LVZDlOuIsaAjtxoWqBvFq6mVu32l4wMymFruvbualKx1Y5V+YO33/gDL4FUStf
 fa1/+3B7GKCvZUBQPXN06qNtHRBH2WFpID1mlOp1w6HMVx2PyRqPfxmL0nVjmUdG4J+5
 ovng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l83/c1T8nBlNrQ55eL8s0lWoociUz5gpSRjORX7QpEc=;
 b=BnVIjHo968iVPzenSVkkr+MMRHVgwqL4BK/pmjwnnRLJkB5tGOWYe7Bq5QjBH8r0C8
 D52rmHYGqw3/8ij5mXi9NbvHIdi/Gn59AHtfZpcS7n2eE3VFAAVZLgjb9eCeSAiVJIQ2
 mxCbH9FICGCIiuqodwPgFUDwosPW/3XG/FWugjOHVM+IwhN7/qX6U1+WUWr68GS6cWHP
 iXq8DykVs8JdBk8cXo5GybK0MKynxqWdQbfc91RthlTBlG2AcANppJ/Dt+nDLa7D/fGk
 6Vtw3z71zyNPCS01R4rR0CRbk4y8ZiyLpp7yk+WU/0duqebTgtVa252fG6MVMhJyV56e
 Mhig==
X-Gm-Message-State: APjAAAW78Ndfg8vsBsY6cdWwNoc3e8uQQS0xVrMI1x9VOHSAtYdWDBPp
 Tzeqn/h6fXkRROvuBAfF6dw=
X-Google-Smtp-Source: APXvYqxeEMe8usCSi/9M+j+dF+vHQvusXAf5Bise4NzyL4RNbR8H2hEqNPoOASO1aJ2GXvdcdlK4fQ==
X-Received: by 2002:adf:81e3:: with SMTP id 90mr81134502wra.23.1577963106522; 
 Thu, 02 Jan 2020 03:05:06 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b10sm57741880wrt.90.2020.01.02.03.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 03:05:05 -0800 (PST)
Date: Thu, 2 Jan 2020 11:05:04 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: ASM <asm@asm.pp.ru>
Subject: Re: PCI memory sync question (kvm,dpdk,e1000,packet stalled)
Message-ID: <20200102110504.GG121208@stefanha-x1.localdomain>
References: <CAMmAVbWzrYWZBXwKxSd-f5SXmq6qP1ok8abvyKJhp3=REEaMPA@mail.gmail.com>
 <CAMmAVbXNMjk=FasuySEcUa0U8CqGkCghehsJsWbVV2VHCAPA-w@mail.gmail.com>
 <20191121140502.GX439743@stefanha-x1.localdomain>
 <CAMmAVbW5a+v_dJ6NM3erwouOqpXyTzL36_W566SL1KuPFPFSEw@mail.gmail.com>
 <20191219145817.GG1624084@stefanha-x1.localdomain>
 <CAMmAVbVoHcTiBnOVtFb5MS3V-in0u=4k4WPHcpxGtYF8Pv5bKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <CAMmAVbVoHcTiBnOVtFb5MS3V-in0u=4k4WPHcpxGtYF8Pv5bKQ@mail.gmail.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, dmitry.fleytman@gmail.com,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 01:10:15PM +0300, ASM wrote:
> > It could be a bug in QEMU's e1000 emulation - maybe it's not doing
> > things in the correct order and causes a race condition with the DPDK
> > polling driver - or it could be a bug in the DPDK e1000 driver regarding
> > the order in which the descriptor ring and RX Head/Tail MMIO registers
> > are updated.
>=20
>=20
> What did I understand:
> * DPDK and Kernel drivers work like simular with ring. It don't
> analize Head, but check STATUS.
> This is a bit strange but completely correct driver behavior. If the
> driver writes to memory, it expects
> this value to be written. The problem is definitely not in the DPDK
> and in the kernel driver.
> * This problem appears on KVM, but not appears on tcg.
> * Most similar to a bug in QEMU e1000 emulation. The e1000 emulation
> read and writes to some
> memory and same times, same as dpdk driver.
>=20
>=20
> As I understand it, KVM explicitly prohibits access to shared memory.
> It is obvious that us need to
> protect (RCU) all STATUS registers of all buffers. There can be a lot
> of buffers and they can be
> scattered throughout the memory.

I don't agree with this reasoning because these descriptor rings are
designed to support simultaneous access by the driver and the device (if
done with care!).  What QEMU and the driver are attempting is typical.

The important thing for safe shared memory access is that both the
driver and the device know who is allowed to write to a memory location
at a point in time.  As long as both the driver and device don't write
to the same location it is possible to safely use the data structure.

The typical pattern that a driver or device uses to publish information
is:

  1. Fill in all fields but don't set the STATUS bit yet.
  2. Memory barrier or other memory ordering directive to ensure that
     fields have been written.  This operation might be implicit.
  3. Set the STATUS bit in a separate operation.

On the read side there should be:

  1. Load the STATUS field and check the bit.  If it's clear then try
     again.
  2. Memory barrier or other memory ordering directive to ensure that
     fields have been written.  This operation might be implicit.
  3. Load all the fields.

Can you explain why the STATUS fields need to be protected?  My
understanding is that the STATUS field is owned by the device at this
point in time.  The device writes to the STATUS field and the driver
polls it - this is safe.

I think the issue is bugs in the code.  The DPDK code looks questionable
(https://git.dpdk.org/dpdk/tree/drivers/net/e1000/em_rxtx.c#n715):

  volatile struct e1000_rx_desc *rxdp;
  ...
  rxdp =3D &rx_ring[rx_id];
  status =3D rxdp->status;
  if (! (status & E1000_RXD_STAT_DD))
      break;
  rxd =3D *rxdp;

Although there is a conditional branch on rxdp->status, the CPU may load
*rxdp before loading rxdp->status.  These pointers are volatile but
that's not enough to prevent the CPU from reordering memory accesses
(the compiler emits regular load instructions without memory ordering
directives).

This is probably not the bug that you're seeing, but it suggests there
are more problems.

Stefan

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4NzmAACgkQnKSrs4Gr
c8jwpAf8Cl090iFYon0qOiJtlU3pyArgQN1AEfrC8JS+mmjGTB8iPsNLOQX3IMWo
UMrENaOT97zJ+srTh4urO1cCuxjv9pmAv1rTLNhKSHr6Bi1UjPTWa/oyF58YdCe6
q+dc9HxaPVpaRYPyQczIlbyyngfoPxalvajjohVuHwKrsFlsLHQProyMRXg/X96p
GrYuZ+juxQESDCvvhpak0JxdCxfQ0qjMxHlR1oXSDUzumheVIlptAkZdlbO6rRV1
x7Pp1IPbwpktjisVoh6nmXROz1LLz12prsoA/ChaCgjntOyeLE7tjf1klGyqgw/t
VK/0iRRxkGzmKxm4UvcRkCH3MF3aPA==
=C7xk
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--

