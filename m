Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD983C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 22:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1785223A51
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 22:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1785223A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN1wY-0000B6-6g
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 18:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1kN1vY-00088T-3A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 18:47:25 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:39417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1kN1vU-00033x-S7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 18:47:23 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 310C1EAD;
 Mon, 28 Sep 2020 18:47:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 28 Sep 2020 18:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dQn+ZL
 rb/tD+FJFEsWzjYlApsJJk+Oj2SAzOurPFeiA=; b=rwqdBVeZtNgKGX9jhYX7+I
 Sltt8eEpWnSXjj3nQTCqrTuSTcPRubJIQtMEbGJEf7uYGXGq9RuuiLhk/e4IuyO2
 LmA0ivm2qzUAv6Jf6c4UxDI4CDdIKWexKRUdjQV1dcwUcL+u4fzfAjxf2YxaQq7a
 qy5Mki7/Ng/VDh3QzU5/h/a3I4uTiXs8hfRmUnDqU4NSuO/B3O42BBoZbgncBE5j
 LHvyJA6M3dCgEHx4fkGKjLXEkGV7m/WwqINPywrTj7k5X3//RfIvLKAsZj1XZQKc
 P4K6BeQy6viSUPvYioQivm/WzmBPgcxH6kak5gMkGSuNcPC88fN2F8qih1N5iu0A
 ==
X-ME-Sender: <xms:9GdyXz4jzo7Cq-rAHP2BAg2RqgMg9OCUFe4UYBI_hel5E-tNU6dSWg>
 <xme:9GdyX47RjIrKFPoJJ-YZPT9WG3-1Wh23LdBYQZwgAcIDavtW74InjwrDFXKl7sjOh
 iPUBcdwU2W3Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdejgddugecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcu
 ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
 hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepteevffei
 gffhkefhgfegfeffhfegveeikeettdfhheevieehieeitddugeefteffnecukfhppeelud
 drieegrddujedtrdekleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrd
 gtohhm
X-ME-Proxy: <xmx:9GdyX6clg8xal_iB2NGUO_A7dlpTuK50vhL8p1eazdeil1xaHyyu5g>
 <xmx:9GdyX0J-grTMKEKSnQsukiBYXvX4fk2wVYGM5dGsyyyKEVljsy5QJA>
 <xmx:9GdyX3LSGvZHUrTaenWF7ZoshURhB5pMzvlYk92o1F-X1nrP9l6eWQ>
 <xmx:9GdyX_0HrMxUTVJ8F95YnHaqhbjTDb2jtF7LQMtiWOxi8G_d64zp2w>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de
 [91.64.170.89])
 by mail.messagingengine.com (Postfix) with ESMTPA id 305023280060;
 Mon, 28 Sep 2020 18:47:15 -0400 (EDT)
Date: Tue, 29 Sep 2020 00:47:11 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH] migration: Truncate state file in xen-save-devices-state
Message-ID: <20200928224711.GY1482@mail-itl>
References: <20200921094830.114028-1-dovmurik@linux.vnet.ibm.com>
 <20200921111723.GF3221@work-vm>
 <20200928164618.GK2024@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QNuYedFeXxEqrKRj"
Content-Disposition: inline
In-Reply-To: <20200928164618.GK2024@perard.uk.xensource.com>
Received-SPF: none client-ip=64.147.123.24;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wout1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 18:47:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: sstabellini@kernel.org, Paul Durrant <paul@xen.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--QNuYedFeXxEqrKRj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] migration: Truncate state file in xen-save-devices-state

On Mon, Sep 28, 2020 at 05:46:18PM +0100, Anthony PERARD wrote:
> On Mon, Sep 21, 2020 at 12:17:23PM +0100, Dr. David Alan Gilbert wrote:
> > * Dov Murik (dovmurik@linux.vnet.ibm.com) wrote:
> > > When running the xen-save-devices-state QMP command, if the filename
> > > already exists it will be truncated before dumping the devices' state
> > > into it.
> > >=20
> > > Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> > > ---
> > >  migration/savevm.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 304d98ff78..e1b26672cc 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -2803,7 +2803,8 @@ void qmp_xen_save_devices_state(const char *fil=
ename, bool has_live, bool live,
> > >      vm_stop(RUN_STATE_SAVE_VM);
> > >      global_state_store_running();
> > > =20
> > > -    ioc =3D qio_channel_file_new_path(filename, O_WRONLY | O_CREAT, =
0660, errp);
> > > +    ioc =3D qio_channel_file_new_path(filename, O_WRONLY | O_CREAT |=
 O_TRUNC,
> > > +                                    0660, errp);
> > >      if (!ioc) {
> > >          goto the_end;
> > >      }
>=20
> Hi Marek,
>=20
> Do you know if the above patch is going to work in a linux stubdomain?
> Can we truncate the "save file" which seems to be stubdomain's console 1?

No, truncate won't work on the stubdomain's console. I mean, the
operation won't fail, but the actual file connected to the console on
the other end won't get truncated. But I think in case of stubdomain,
toolstack should connect the console to an empty file, so it shouldn't
be a problem.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--QNuYedFeXxEqrKRj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl9yZ/AACgkQ24/THMrX
1ywJegf9FdbbxZyKqbkAXWV6OoTHTgNwoA7SawiM+w3NfM77AFY+lXtCbtICtOjC
EWSTAK3BnIOjV3cDxFIArO3u7i+WaYRe3YNCGEMIqQn5JdRiLGjEY8goLzlk1TKm
tnqA9vTJZ+cWodo/9XL1grejdBe+rMYRVMYfrR2F7NgSYiKDz83PUGUDd/pe39ss
I0T30mmTaOkuEByxxTA5nbYAy7g30Yt5BAtdZT1eU6qsd5qOw3gR4FxwEXtc1tcD
xmr5KlCf4Yd1XxPsaVboXJJSFcKX8TmUjmz04hz2NpYILI26C+qgLgFOjfANaWYV
wLW8cvdf6/fwj2EgJRjCQai53RpHGg==
=ySPE
-----END PGP SIGNATURE-----

--QNuYedFeXxEqrKRj--

