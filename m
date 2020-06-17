Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B2FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21C0214DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkQX5sSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21C0214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlXZp-0000JQ-Tw
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlXYV-0007Fz-7i; Wed, 17 Jun 2020 08:52:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlXYS-0006Ix-LZ; Wed, 17 Jun 2020 08:52:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so2195913wrr.10;
 Wed, 17 Jun 2020 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7EIvx47leX1M9Fb9+Q5Hyqk4UskVfaxMuDj7xlBl2Hg=;
 b=pkQX5sSlFMw2FRuWRr1IOdX7TUkTHU0nTAWLi+wwPD1pvLKN9U+boTDxeRudexuiCc
 I+kZ7H0OOPJFS36gX0Ujzgdf4A/GdcMLAGphr4TRzgvSS+p035zJA7mthVbwvwf2mj0R
 5syIHoThGnKC/IpYofaf7W0YTzkDGDMbMitYrjHy13Qf9Txo0G1lwlQ37lSI/WpIgDpK
 2kUglF+RBtZoUQQ0xo3bJ00GeiwTQC9OX0rETu7bFc1bdB5qg/f77mTx1+g9gIQK3itu
 x3yOgchEJE9GnYldjQtSpRyHXOJGHjPmgGHwYESjZtakiulYZ51Badqcd2N6+fZnjcU1
 Yrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7EIvx47leX1M9Fb9+Q5Hyqk4UskVfaxMuDj7xlBl2Hg=;
 b=Ug5k78Sa/n1J7kBv+mFQ+LalIOIj2Tpp4qyjCJRIK5KIN4fmXpdqOFm03Gz02/Ro0o
 hlCvQICWcLC8Xq8Lq1JTkbzZ4X6L3viWP0qjJqBsySL5k/jhpeQGVNUuh4fb/b4DxQql
 Xonrlk9S3+TFTcHNmMBQmt/Q3pLJOC9PbYGRx3RSFVbvJPq/PfyK5B6NsWKUyJmcb4Bz
 y+4v6Mee1oV/HmFxWh7OV7PedLmwG6HDzzxL5U7d3SNrMUVmU4Zmxdu1A8yoO8/2Tve3
 K/oEB7ZFmDh0pis+FzkQBj+k5Ee2wx/UvSIHTOdDCyjZwEMwcarQr4jSXuc5Y/Cw9HF4
 9T7w==
X-Gm-Message-State: AOAM5313UuQLDfTgqzKW3voM0oHv22aDo5REOWm/WjMaBCcAKehj2R92
 hmz+hVzmep8bMmWNXWSbFHtcyW1QA2U=
X-Google-Smtp-Source: ABdhPJzyHb0b9+2F8PeG6bFo72QdtEu6t+F3DVr1ppSASYFVSEZy8krwv8LbpNDxfxFTTvfpCbn3pg==
X-Received: by 2002:adf:f5c6:: with SMTP id k6mr482627wrp.358.1592398354807;
 Wed, 17 Jun 2020 05:52:34 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 23sm311417wmo.18.2020.06.17.05.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 05:52:33 -0700 (PDT)
Date: Wed, 17 Jun 2020 13:52:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 1/7] block/nvme: poll queues without q->lock
Message-ID: <20200617125232.GD1728005@stefanha-x1.localdomain>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-2-stefanha@redhat.com>
 <20200525080713.7kvgnlzvdbhfbowt@dritchie>
 <20200528152350.GI158218@stefanha-x1.localdomain>
 <20200529074858.6kxtojzbg4ysqadf@dritchie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <20200529074858.6kxtojzbg4ysqadf@dritchie>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 09:49:31AM +0200, Sergio Lopez wrote:
> On Thu, May 28, 2020 at 04:23:50PM +0100, Stefan Hajnoczi wrote:
> > On Mon, May 25, 2020 at 10:07:13AM +0200, Sergio Lopez wrote:
> > > On Tue, May 19, 2020 at 06:11:32PM +0100, Stefan Hajnoczi wrote:
> > > > A lot of CPU time is spent simply locking/unlocking q->lock during
> > > > polling. Check for completion outside the lock to make q->lock disa=
ppear
> > > > from the profile.
> > > >
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  block/nvme.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/block/nvme.c b/block/nvme.c
> > > > index eb2f54dd9d..7eb4512666 100644
> > > > --- a/block/nvme.c
> > > > +++ b/block/nvme.c
> > > > @@ -512,6 +512,18 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
> > > >
> > > >      for (i =3D 0; i < s->nr_queues; i++) {
> > > >          NVMeQueuePair *q =3D s->queues[i];
> > > > +        const size_t cqe_offset =3D q->cq.head * NVME_CQ_ENTRY_BYT=
ES;
> > > > +        NvmeCqe *cqe =3D (NvmeCqe *)&q->cq.queue[cqe_offset];
> > > > +
> > > > +        /*
> > > > +         * q->lock isn't needed for checking completion because
> > > > +         * nvme_process_completion() only runs in the event loop t=
hread and
> > > > +         * cannot race with itself.
> > > > +         */
> > > > +        if ((le16_to_cpu(cqe->status) & 0x1) =3D=3D q->cq_phase) {
> > > > +            continue;
> > > > +        }
> > > > +
> > >
> > > IIUC, this is introducing an early check of the phase bit to determine
> > > if there is something new in the queue.
> > >
> > > I'm fine with this optimization, but I have the feeling that the
> > > comment doesn't properly describe it.
> >
> > I'm not sure I understand. The comment explains why it's safe not to
> > take q->lock. Normally it would be taken. Without the comment readers
> > could be confused why we ignore the locking rules here.
> >
> > As for documenting the cqe->status expression itself, I didn't think of
> > explaining it since it's part of the theory of operation of this device.
> > Any polling driver will do this, there's nothing QEMU-specific or
> > unusual going on here.
> >
> > Would you like me to expand the comment explaining that NVMe polling
> > consists of checking the phase bit of the latest cqe to check for
> > readiness?
> >
> > Or maybe I misunderstood? :)
>=20
> I was thinking of something like "Do an early check for
> completions. We don't need q->lock here because
> nvme_process_completion() only runs (...)"

Sure, will fix.

Stefan

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qEhAACgkQnKSrs4Gr
c8gTLQf/dkhJ94siO4mxmMuBE8TXrRFW/DYUtn1pRXvf7E6ZL7u4nSJZCkU1GAbO
1RxOhS4L3sR/4fEjwrJRu3czv+V++H93xp0QvYgW82tquMfD9F+4nMcKiUwiju7A
drnfpPOpCWMaNuZEpEn7iZpJqf92E6F4Xejm0j9r7ru2Or3mAjpAC3Riqk877lwH
xBnz/qjQx4BXpL1I4wQprsb6qdUPKV3vkqTplU6QctK8iBcYsqENbQimbWS3V3AM
XlMy+Tb+4LRuRYXxC5pP2jvcJ0Lj3fNXVSxzJYEp1i2pJy4ibyLjXvAewQ6j8VbZ
oSJLHSTC70HVI76gT3Ooz1CCbGD02g==
=iEzi
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--

