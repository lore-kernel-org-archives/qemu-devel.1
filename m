Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D1C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC6920866
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqC3OTs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC6920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADHJ-0001UQ-Ke
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jADGU-000137-Dz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jADGT-00032Y-FU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:43:46 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jADGT-0002vX-6F; Fri, 06 Mar 2020 08:43:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id g134so2466788wme.3;
 Fri, 06 Mar 2020 05:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yJ308+rzXa1VGCSCN7Rc2yJBtpfHXffMiTKN0PyJBWg=;
 b=GqC3OTs+pZ4grxEfvXGLS/upACWpbd13uv/yQfvCLGu4gJHh2F/0/maj6PAcTgNEDR
 vQ4JT+tc7axrFRa5CcWgdTxrxx3wb7JITvENEYVx+oNsOFsOApiitBbMeYVolyT2eBxd
 h38kpFGindlkc/QDyNTeDGgdTNzwhnImpUXkwmco/6Un4hd/PddOCJVGOLPivo3jlvq1
 g68A3BX43uHyPrJi9HT+qyPaMKI+l3/3H2xoLQSFaojBq0XSOVV3Ij102Bw/qcMFjJfL
 9ZH0COQhmwXGLuqVQHvKTcmLTD/G10G5msHYpN19AavSxB8X6xMU8BFQ99ZKwb+ANZWV
 cSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yJ308+rzXa1VGCSCN7Rc2yJBtpfHXffMiTKN0PyJBWg=;
 b=CvbV0VWi8DI4iczKTPdYLdgKEPCB1KJfuBqRxPCYmB2A0jgCuVTpJFGz1oJE0lYOKN
 fqUXXvygSPIk2DWHBRqlK1UcIOlWJT/K/uJQcg4t71ZGH0xWaomKDdr0AANEXwrImfrx
 SNJMcW0Mir0Em6jYjJBw/qQs01psvDO8Rlu5KXosVqIyHXXIuPx5nPmJFqcZN8J94WR9
 ridRvF89t8eaRY8yKrxPO3Mt1h0s9/5Ajh1oaBYUYOxQ4qA4rVPr0g9RuODLODkTeoFI
 1mtd/B6tL4ruIFPfghC3P1ryEMZQaGrmkTpUPJK9KBibkG/iQwgwhjVjMCDSeFfQPrhy
 RLLw==
X-Gm-Message-State: ANhLgQ2HK65GHyMlGU79BIuVby/UMJW/cdXyhc7sPmfBfzmhyvb4VnBT
 X8+upMO8mAiStKF9J0RjCH8=
X-Google-Smtp-Source: ADFU+vtgmkFA7/jKksEh2ypLdLxIeLxNBhSYhHr7UjISMX0QxtNfk5zGFZdPmmstrJFDstxzYCYsdQ==
X-Received: by 2002:a05:600c:4108:: with SMTP id
 j8mr4073996wmi.188.1583502223716; 
 Fri, 06 Mar 2020 05:43:43 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z13sm18564679wrw.88.2020.03.06.05.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 05:43:42 -0800 (PST)
Date: Fri, 6 Mar 2020 13:43:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/7] aio-posix: move RCU_READ_LOCK() into
 run_poll_handlers()
Message-ID: <20200306134341.GO1335569@stefanha-x1.localdomain>
References: <20200305170806.1313245-1-stefanha@redhat.com>
 <20200305170806.1313245-3-stefanha@redhat.com>
 <7218b5ad-84cd-a111-b88f-7043ee63d486@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RHdRtM27np9fZUoh"
Content-Disposition: inline
In-Reply-To: <7218b5ad-84cd-a111-b88f-7043ee63d486@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RHdRtM27np9fZUoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 06:15:36PM +0100, Paolo Bonzini wrote:
> On 05/03/20 18:08, Stefan Hajnoczi wrote:
> > =20
> > +    /*
> > +     * Optimization: ->io_poll() handlers often contain RCU read criti=
cal
> > +     * sections and we therefore see many rcu_read_lock() -> rcu_read_=
unlock()
> > +     * -> rcu_read_lock() -> ... sequences with expensive memory
> > +     * synchronization primitives.  Make the entire polling loop an RCU
> > +     * critical section because nested rcu_read_lock()/rcu_read_unlock=
() calls
> > +     * are cheap.
> > +     */
> > +    RCU_READ_LOCK_GUARD();
> > +
>=20
> Looks good, but I suggest that you compile with --enable-membarrier as
> that makes RCU critical sections basically free.

Interesting, --enable-membarrier decreases performance from 105k to 97k
IOPS in the NVMe latency benchmark that I'm running.

Stefan

--RHdRtM27np9fZUoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5iU40ACgkQnKSrs4Gr
c8iafggApEpIPuPYD7dQv8LzqcSks75Uq4jPrvlcMXR5QK/TlsrVDfIvIJhzs1lW
2Bjzaha0kKvOUNsS8aORzV/KxLHgyrYyricXkIF2aTAn8/2V74NI5a+v8VLrw5Qp
QK2FGpHbSAVqU0lW5Od06/CW8zInHTyH4Oc+yP59dMM362lGCeD280bnFIxgaUIK
onswXHbGJ97yr/5hC96qHzK9Zhr/iCVxHSyqW0HcAmYo8aEgwr2sJbOorzzIsp3G
yIVANIw//FgvukW8iTRxvIyORFVm3wR/ZaC7XX47vh6UnQfX8wjUA5O8P0xqRjpb
BQuQg+mP1j4QlbpD3dQ7uuMyF/6cCg==
=wiFE
-----END PGP SIGNATURE-----

--RHdRtM27np9fZUoh--

