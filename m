Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD4EC4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1E52193E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1E52193E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRtC-0007WY-LE
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKRmw-0004cy-M5; Mon, 21 Sep 2020 15:47:55 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:45691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKRmt-0000Zu-9E; Mon, 21 Sep 2020 15:47:50 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id C4C9A3A4;
 Mon, 21 Sep 2020 15:47:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 21 Sep 2020 15:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=yzFMldKwHwB+9tLjP4X/ejLu/V9
 sqqPPQTkWH6tiChc=; b=eqa5F9CRnCU6jI8h7xhSOXh0AyNGEBL3oSKM9kdSguM
 nfgWJxUv+Rr01AI29V+xqWHOF2SBHDHIrAlNdH6U+w2+3bGqTKPKJwzRV3U21lNk
 kbCSGSuNrhn5S0hPbpQiw3FI624J6nNC4t/ZZMCwYQgRk0P38tAK8ktcaTvh0BcG
 71p35oo6AmRxKK3UqOP/L8ok7JsnRcKwsaeQ4R5zORF2NEEkUYgUZ3cIXDukw+TU
 LnKyyqsrK7UdJUyo5fSZoZxMgH19oQ6bgj8hqzlNjXBDJhJfupyJCijylHn6kAHX
 9hmwxTJ6VZp5Qz5Ggvxire7MZZ8EsWSzojscNR19kfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yzFMld
 KwHwB+9tLjP4X/ejLu/V9sqqPPQTkWH6tiChc=; b=mwJfkzgp5G+Wf2wskWa6Jd
 33dWO4uSFN7I7osr9bvpHtXRcO8jPUS5vPCFmVktqGk6t9jRA3G3qMEbx3ipjd0Q
 wQwNhaHVXRK+ei9jfro9IJ+VteWmv0uXgqGlR/El0NkLbTfsMRC0ca+P1q537kgf
 qY+kUHhR57eUfj5dTA15Rm56XhdWjvjKTgkZ+tPs/0/ZySQp8O8OP6/03a9BX6E0
 kKu2xB/LyNvje4LDMg2WwQB7S6lEJ3tCGbLrlQHLgOUfWTe92A4u+MXkwj3eltOL
 0yVPl9N/K+BxoAShy+kfE/adKrItOC5HDHr/14QUO4BXp+EiCXdCRrxfAC5Yh5oA
 ==
X-ME-Sender: <xms:XANpX5J4UNDrbIjKqoLdx5I6bv8JJO9mmUerFnTQC7Pc9kIW8IMP8g>
 <xme:XANpX1KeJAlKacauPk7wrucxORTld37P-xHCnzAZOivBXA1XaUDfDsUFBbTfLnoEi
 v70N4ZosuVYI6Lym88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgddugeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgeduffeuieetkeeileekvdeuleetveejudeileduffefjeegfffhuddvudff
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:XANpXxttzdENPB-WcciX9pSHOwG-GJyPO9FXo92AYUc7v4Fvdi8zrg>
 <xmx:XANpX6YiRSjl0cjr0aJTQRH6k1ophKND0f6mzVHwVU_I5BiQm8TNxw>
 <xmx:XANpXwap3GMYGPGeCqAXJ2V1yy6qsPWRX5uf3jkrOT2zy44hHshwxA>
 <xmx:XQNpXw5hGgvYwAYQSpNIOY8WyfZzZ58cX2--4qA9GTWeArGQx5yqfnWn5lk>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 60CD63064610;
 Mon, 21 Sep 2020 15:47:39 -0400 (EDT)
Date: Mon, 21 Sep 2020 21:47:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 03/17] hw/block/nvme: handle dma errors
Message-ID: <20200921194737.GB999349@apples.localdomain>
References: <20200918203621.602915-1-its@irrelevant.dk>
 <20200918203621.602915-4-its@irrelevant.dk>
 <20200921165006.GB4034241@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20200921165006.GB4034241@dhcp-10-100-145-180.wdl.wdc.com>
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 15:47:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 21 09:50, Keith Busch wrote:
> On Fri, Sep 18, 2020 at 10:36:07PM +0200, Klaus Jensen wrote:
> > @@ -466,15 +476,21 @@ static void nvme_post_cqes(void *opaque)
> >              break;
> >          }
> > =20
> > -        QTAILQ_REMOVE(&cq->req_list, req, entry);
> >          sq =3D req->sq;
> >          req->cqe.status =3D cpu_to_le16((req->status << 1) | cq->phase=
);
> >          req->cqe.sq_id =3D cpu_to_le16(sq->sqid);
> >          req->cqe.sq_head =3D cpu_to_le16(sq->head);
> >          addr =3D cq->dma_addr + cq->tail * n->cqe_size;
> > +        ret =3D pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
> > +                            sizeof(req->cqe));
> > +        if (ret) {
> > +            trace_pci_nvme_err_addr_write(addr);
> > +            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
> > +                      500 * SCALE_MS);
> > +            break;
> > +        }
> > +        QTAILQ_REMOVE(&cq->req_list, req, entry);
>=20
> Is this error really ever transient such that a retry later may be
> successful? I didn't find a way that appeared that it could be. If not,
> this probably deserves a CFS condition rather than a retry.
>=20

I'll admit that I did this patch with the blktests test case in mind,
and that retrying causes the test to pass.

But I think you are right that retrying might not be the right way to
"pass the test".

I tested and setting CFS also passes the test and now actually exercises
the reset path in the kernel. So wins all around.

I am thinking we do the same for a failed read in nvme_process_sq then?

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9pA1YACgkQTeGvMW1P
DemH4Qf9HGKl6JqCKOK1i/D5yorYpNutVtKZoB2B4n9Nan2wGEyfRZIBaYl14vwQ
WL4+PMry4K2wBHFhRl7sqi1qksj/q8H2dgANHIs7z05c8k9zd/1a5GhaNszq21f0
eRvYqV0QLnzX+6D6ywdeRz/sbnmPGk2k8F7RwRpaBEUd3LuscUQ00mTW8HfJgXxZ
VtTs04Ykw1Ku/dKB0YER6PhA+dOH7a7C2o0pDk4BQSGXmEeQKYZOmXKQHD85nSP6
AG1p++NCSUfvrKXp93vTKbimjQM4j2b21GkAIqs5LKkNnegsOz2vFAKdPfM9z91T
W5ahrP1FWhmmKQGOVsTYf7e5FE1rHw==
=bWCQ
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--

