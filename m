Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94288C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61867205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJXpwT3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61867205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnLv-0004yR-MK
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48358)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hgnKy-0004WM-Ie
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hgnKx-0006Nf-CB
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:38:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:36577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hgnKx-0006NH-5E
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:38:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id u8so8317159wmm.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JLkS7yWIvSDpTg21K7U1t0KGOImasGe0o8f6CpM7V8U=;
 b=sJXpwT3MMOYntTrOd+SSUO+kRlDzbAQqTp0jl3YpDfqTi6Q7gqbUIeslIe5eWK58Mo
 poHU+QxG45tocwbwaLNyNINfU5hoeQkzVinrLh1i1raGK8+a0YBi1tG8147QvCu0Xv3y
 c1mL+cBeXI9ko8nxDFgf81u8i13e7gsS36lBawypz1IG31OydG4Ox5f9+pwpEKbPQPUb
 TkWBeQ7TrHxdIbgyhVkzawQGqhFjpqb3cjfZCaz1kHBqQBuVAJU+UtPEhp1qhNBNVWv0
 1T+d4MlLLkC8FTmDDuACfL7hKAChn6yInc4kBR0edMduAKHuKx7tb2tayc2KTaYNsWWY
 KaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JLkS7yWIvSDpTg21K7U1t0KGOImasGe0o8f6CpM7V8U=;
 b=hQy2HG3bvQNhm+Caw1Chrxn9RrvCzC3ZpyONbc/LnSiIH1vlm3Kj3gV7ADaktPFY0A
 F+PYIlCC9RxLtaiicwSGc41gAXqzB3ZCJsiHe4IdmC6jhYpHM3Pup7ZZgthgEaWIdBsS
 qfT4lZvIaNhhRkm+yjc2GZF3zvwkFtWLvbUL/D0SZe5c97fJ5G94NRIbCWwQM5FrqfQs
 iWOi3g9rvtpekYRNFEYpNygBUT2rXgTFtYLZcSTUtbTpXdk4hG+QAEQbDLKR0Au6Jz9B
 AYFEJ/IvxuREVmEcP6MEWoxEXNbBj9HrFgoQf5Kftz8KN0SuxF2oM/p60hWc8HC3qFn9
 IMdg==
X-Gm-Message-State: APjAAAUT60vPTu0OCIdr92X8PpiXctnLHg1tD8NQLCGZmFmk2MZ8CjTQ
 2K6aFyZjZNIu4VtdEdW2byA=
X-Google-Smtp-Source: APXvYqwE0bHRoa98eqXklVi+uvuFsKpCcMdH8XRTpTJYS7Q22wPXd0W46VWwmb6T2Fu9EeQdSQre+g==
X-Received: by 2002:a1c:be12:: with SMTP id o18mr6530362wmf.21.1561714710032; 
 Fri, 28 Jun 2019 02:38:30 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id r2sm1385767wme.30.2019.06.28.02.38.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 02:38:29 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:38:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190628093828.GD3316@stefanha-x1.localdomain>
References: <CAMzgYoMG1ic-5yiS2ehnDLna+UKgCtMBcSVNmKQx1oxRZqT=yQ@mail.gmail.com>
 <20190624184133.GW2726@work-vm>
 <CAMzgYoOjCNYvadBT0PPorG0wOX3Ymvd5x_1NzW1SH2te1JfN-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <CAMzgYoOjCNYvadBT0PPorG0wOX3Ymvd5x_1NzW1SH2te1JfN-Q@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: Re: [Qemu-devel] [GSoC] Help needed in implementing live migration
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2019 at 05:02:33AM +0530, Sukrit Bhatnagar wrote:
> On Tue, 25 Jun 2019 at 00:11, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Sukrit Bhatnagar (skrtbhtngr@gmail.com) wrote:
> > > Hi David,
> > >
> > > I am Sukrit, GSoC participant working on PVRDMA live migration.
> > > We had a short chat about vmxnet3 migration about a week ago
> > > on the IRC channel.
> > >
> > > I am facing an issue while doing migration of the pvrdma device.
> > > While loading the device state, we need to perform a few dma
> > > mappings on the destination. But on the destination, the migration
> > > fails due a BounceBuffer being locked (in_use). This global
> > > BounceBuffer is used in address_space_map/unmap functions
> > > which the rdma_pci_dma_map/unmap calls.
> > > Essentially, we need a way to remap guest physical address on
> > > the destination after migration.
> > >
> > > I had posted an RFC a while ago on the list:
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04924.html
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04923.html
> > >
> > > My mentors (Marcel and Yuval) told me to ask you for help
> > > regarding this. It would be really great if you can guide me in
> > > finding a workaround for this.
> >
> > Hi,
> >   I'll have a look; I need to get some other things finished first.
>=20
> Adding cc: qemu-devel, sorry for the private email.

I haven't looked deeply but it's surprising that you're hitting
BounceBuffer.  My understanding is that's an old mechanism for
supporting exotic things like DMAing to/from device MMIO registers.

Modern machines and guest software usually don't do this.  I wonder why
you're hitting this case.

If you look at the BounceBuffer code there's an API to register a
callback (cpu_register_map_client()).  That's how the case of multiple
BounceBuffers is supposed to be handled.

Can you double-check your code and figure out how it got here?  I don't
think it should be taking this path.

Stefan

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0V4BQACgkQnKSrs4Gr
c8hE2QgAltAOEWnOPaSblKpNbLy28PYbyKPnVL513sw6vFzDF+lLcYdoFiJKSQe5
yHK3GwC4cwEdrqINtFu3emqx8xPS64rn4gLXi8u/A9IHqUV7a4DV2nN4yH4+FlDR
H+rg9Rg/oeAJYMf/iCVWun/uMI0y7n+qVP+a3fEgFkjR88JZSOxL8WtCrqOTJQpm
+AsQ4zXzDvW+d5/1QANBhcsTYAwLp6Cx7aa5fefNKq4qDaBtaXAsAIPxBumy5G/l
Crolq0jgd9qBKckMWqn65B0a+lwjo/cyprGWDghoW+4cNx8BgJYeJn0AEHEPq6Ky
esuS0BpqSZGgJuVA37KdS1dJKEXSjA==
=twMr
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--

