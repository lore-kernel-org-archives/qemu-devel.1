Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C36C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411CA2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411CA2224D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUZLB-00085K-0m
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUZH5-0006Yo-6l; Mon, 19 Oct 2020 13:48:47 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:53815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUZH2-0007c8-Tp; Mon, 19 Oct 2020 13:48:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 87A6AFA8;
 Mon, 19 Oct 2020 13:48:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 13:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=/Nyvv3LFNRygeB23Nu0zGewYC8P
 zzB2oGBJ+6Z1c0KI=; b=J8Li/ttAz202iuzK8cslp2aHZYsaqPWI1AE5Je8SOEG
 FOKnvOTCwtoBcot9uDmOG70P9NxJ/CV91fd3rMjQiBmPvvWf6kDjDRUVFe3Flyod
 nNyHpcSYqUgdbgbxeczF3jw5nwC6HnnK8dAiRT+jnUQ+qbRhdJiGpbv+cNhZhUFb
 KRfmiXRfiXWxbheaVFM3Zw6GqIA5rbKfHPHI/syl+WLjxuwih5hekizKvD8bJttl
 jfcCC/ya+4V0aS0Zu/lAZwAsIDTyeXp4UTrtT0ANjqnSXEALQ2Ex5uwM2fp9CMnE
 x+XBbtpbiCiQwiukszvnEHCbzKNITV2O+rPBYTVQcTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/Nyvv3
 LFNRygeB23Nu0zGewYC8PzzB2oGBJ+6Z1c0KI=; b=iA9WKRBn9Lw8abwTPTyKS3
 dDxiyiOPgXgvtVCpQTGlD/OALe8H1MXLJmRCa783DyorZ/wcj1DAAjwHWabsdZft
 cTrNp5F7kDmj89PZXgwyx9XOkhFO683spECHaITzQf7dwjHhBfoXYY/MA8Gb/83T
 Q34kk8NzHbPHLIYJ2CAqXtGMPDkvhMAcqrAec4KEate1x7iiQ4SUy3nNY1zEIm3b
 kmC1aO64pS3jrl/ZYSzhBAh9IjaGGR7cwf4yQIKwFsrtoxi+y8rSu4pJSGuP4vn1
 VXVAeGLqMNKkYwR5+zRjQv3SGThtBra6YUA9NiNEFzAqOPkgaNnMehPjA6AE/rXA
 ==
X-ME-Sender: <xms:eNGNXyAKK8jHazNdRqII8xtNhHOFEB202ciWBzBUMoJZ0Ru3X7M35g>
 <xme:eNGNX8gr4kLPlFe1IPsqvUQR7Bnz5WX6wyUDNdPNycqBU2xn2rKyhMQK3V1_chEDp
 BCrct3Mjych0Ps_5FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugdduudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:eNGNX1msYnGZ_mG8GbLaV3Rd_ci5ZMraKvzt99rKv_z0UR64BDawuw>
 <xmx:eNGNXwzEykIk28Nf8smRZeSdNtv2bE4u-QJ9vDyNwNo0L86oIGrJHA>
 <xmx:eNGNX3QFzPskiCqQezUeE-VmbIa2ODxwldR3gY-_EEQFL2glTWgJ5w>
 <xmx:etGNX1O8ZeMt6V1uefYrEb_s_iynjwO0iiO8o1MqoVTa9_P6jcx3qTFb3yo>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C1D7A328005D;
 Mon, 19 Oct 2020 13:48:39 -0400 (EDT)
Date: Mon, 19 Oct 2020 19:48:38 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] hw/block/nvme: fix aer logic
Message-ID: <20201019174838.GF10549@apples.localdomain>
References: <20201019065416.34638-1-its@irrelevant.dk>
 <20201019164332.GB1435260@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
In-Reply-To: <20201019164332.GB1435260@dhcp-10-100-145-180.wdc.com>
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 13:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 19 09:43, Keith Busch wrote:
> On Mon, Oct 19, 2020 at 08:54:16AM +0200, Klaus Jensen wrote:
> > @@ -844,6 +838,12 @@ static void nvme_enqueue_event(NvmeCtrl *n, uint8_=
t event_type,
> >          return;
> >      }
> > =20
> > +    /* ignore if masked (cqe posted, but event not cleared) */
> > +    if (n->aer_mask & (1 << event_type)) {
> > +        trace_pci_nvme_aer_masked(event_type, n->aer_mask);
> > +        return;
> > +    }
>=20
> The 'mask' means the host hasn't yet acknowledged the AER with the
> appropriate log. The controller should continue to internally enqueue
> subsequent events of this type, but suppress sending the notification
> for them until the host unlatches the event type.
>=20

Ugh. Looks like you are right. Again.

Notice events are definitely a good case for when we want to queue up
the events internally since the information correspond to different log
pages but use the same type.

> >      event =3D g_new(NvmeAsyncEvent, 1);
> >      event->result =3D (NvmeAerResult) {
> >          .event_type =3D event_type,
> > @@ -859,9 +859,15 @@ static void nvme_enqueue_event(NvmeCtrl *n, uint8_=
t event_type,
> > =20
> >  static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
> >  {
> > +    NvmeAsyncEvent *event, *next;
> > +
> >      n->aer_mask &=3D ~(1 << event_type);
> > -    if (!QTAILQ_EMPTY(&n->aer_queue)) {
> > -        nvme_process_aers(n);
> > +
> > +    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
> > +        if (event->result.event_type =3D=3D event_type) {
> > +            QTAILQ_REMOVE(&n->aer_queue, event, entry);
>=20
> Memory leaking the 'event'?
>=20

Thanks, good catch, but this change is also irrelevant now.

> > +            n->aer_queued--;
> > +        }
> >      }
> >  }
>=20

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl+N0XQACgkQTeGvMW1P
DemsOQf+PAmdjDk0fPIdPNmfGIiqhy4MflFtV382eo12EzA1tfXz2pWV1DrapSJP
m/ZFd0y8bMhbYuKODG2QVkKuFN0jYXBjPWyk2x9EGD+5SrrPkyCqEW8slUdpTNCJ
m9BeQb5OqMsdyzMi8+iaj4tqB5UJTzZfQC/cRzlPLvKffO6FGwIgFPb5AqxICW4V
Uqss+NV5qE6v97odw3Ja0dwXPlGeYvSzyahjfcRscFv3jfZ2CH8yVipOy8FSEgZ4
yPwzQ5Vg5WLVHtr72zicLL8j/I7ubqWBznz1eaxDgD72SLfDKtO6pnNeSVjMOhx9
8nW+uqmW66LtMTaUNChkaGCBxHfiTA==
=NBDK
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--

