Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1689C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2919B2242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gkwj0Prd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2919B2242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcG7-00074n-75
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kXcEa-0005bH-9h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kXcEY-000855-GW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603856085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QM/wMQ33c+yYSC5HBgdFwB4aOKTAgeF+PCuLnK4+OK0=;
 b=Gkwj0PrdBVlkjVTZ9BNSnUA47Qsxi4IjSemncGhqDLj118h1DNAe3vpncsSQACZ/Ip7z1A
 hrx5Tpn3r6WiYnKESs7UkxaxGaxXVHeWSqf64Tm19LqeDrC9QxxgHoX5jeRTYPYPCGGFSo
 n97N+j6XQ3w3FKcCE8f5hhNbZV3d62o=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-I29ArHveONO05w38Cv-yPw-1; Tue, 27 Oct 2020 23:34:43 -0400
X-MC-Unique: I29ArHveONO05w38Cv-yPw-1
Received: by mail-pf1-f199.google.com with SMTP id l188so1642843pfl.23
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=wSnvwBf9fYYNGFcgRtQv7zDavLFfzAbVCpZOBvhBLc8=;
 b=M/TxLjqSMyysdZJW0ANdQW3ZiIe4AtBMyG6+7S1HIECbsCxC/U7Z9qtx+ut8xI84A8
 0hri6hChVUA2/NCPnKMmEPDr5oEzks4yVnkkU2KghB2axUYvS9aUNqywJkKn3pwMw9bv
 J507XSsSjgQe6xEis+Tjeu5f6zi1Ldw+qY9I7L9XKS1GncprzNemJOtm7UBTvs1F8PSq
 0P7iIDqmhFWSxtKS+dvJqJ0KsuCw9vCLBzT8ARSyi63jCKOqOojy8DzYjuWFCplbVF08
 BM/5u83v+2ohn2DYx/cOJzB0j2QelGqtHzcbFnzGswCtNl/xicO9BgZIxmJeS8i8lbgn
 kYmA==
X-Gm-Message-State: AOAM531c6ckMw/JKKrunyJAJXoD0N9CZ2RoMzini7J7etkXxpo8bNIOu
 D26ug6xZ0w5DOKzbR0zdMws95V1JUpUARWkDguZf/6N01MEZ9Zd0/vPyGd8JSIQA6oILVjf+aqh
 92gjIqY/l0mUPIAI=
X-Received: by 2002:a62:e112:0:b029:152:b36e:b05d with SMTP id
 q18-20020a62e1120000b0290152b36eb05dmr5441293pfh.3.1603856082190; 
 Tue, 27 Oct 2020 20:34:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEw47icfSulfuI8/VAPY5vrfvZKHtAfGLNpRyr81q+TycHrMqDG1tsQB8N4cpyZsG221dFkA==
X-Received: by 2002:a62:e112:0:b029:152:b36e:b05d with SMTP id
 q18-20020a62e1120000b0290152b36eb05dmr5441274pfh.3.1603856081875; 
 Tue, 27 Oct 2020 20:34:41 -0700 (PDT)
Received: from yekko.fritz.box ([2001:4479:e000:a00:52ee:f101:6b37:1519])
 by smtp.gmail.com with ESMTPSA id ms10sm3373016pjb.46.2020.10.27.20.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:34:41 -0700 (PDT)
Date: Wed, 28 Oct 2020 14:34:34 +1100
From: David Gibson <dgibson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201028143434.4ed25044@yekko.fritz.box>
In-Reply-To: <20201027085650-mutt-send-email-mst@kernel.org>
References: <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <CAC_L=vUgsh=08m8EEuEucRtdX73X5kw5ov4Ekg7jFjbHsU6f2w@mail.gmail.com>
 <20201026174537.128a4173@yekko.fritz.box>
 <20201027072430-mutt-send-email-mst@kernel.org>
 <20201027135426.765dd19b@redhat.com>
 <20201027085650-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgibson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/Bm6w=GLeaMGssCUl39Cu.Os";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 22:00:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Bm6w=GLeaMGssCUl39Cu.Os
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2020 09:02:06 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Oct 27, 2020 at 01:54:26PM +0100, Igor Mammedov wrote:
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> > I have more questions wrt the suggestion/workflow:
> > * at what place would you suggest buffering it? =20
>=20
> PCIESlot maybe?
>=20
> > * what would be the request in this case, i.e. create PCI device anyway=
s
> > and try to signal hotplug event later? =20
>=20
>=20
> that was my idea, yes.

Actually, I don't think that will quite work.  A whole chunk of the
problem here is that because the device is realized, the guest sees it
as part of its general scan *before* the hotplug event (ABP and PDC
interrupts) appears.  That makes the guest misinterpret the ABP as an
*unplug* request.

So delaying the interrupt without delaying the realize (or at least
filtering config space access to it based on.. something) will just
trigger the same problem AFAICT.

> > * what would baremethal do in such case? =20
>=20
> exactly the same, human would wait until blinking stops.
>=20
> > * what to do in case guest is never ready, what user should do in such =
case? =20
>=20
> As in guest is stuck? Do we care? It can't use the device.
>=20
> > * can be such device be removed? =20
>=20
> why not? device_del could complete immediately ...
>=20
>  [...] =20
>=20
> I'd say let's get expected behaviour for existing commands first.
> We can add events and stuff on top.
>=20
>  [...] =20
>  [...] =20
>  [...] =20
>=20


--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/Bm6w=GLeaMGssCUl39Cu.Os
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+Y5soACgkQbDjKyiDZ
s5IrQhAAtIpv2St5oEeNy7r1+Kjl7rWk07tWQkrNgGJ6+S2fmElaH9Q8AifIv1uX
6xcmcgyjcR87RChwp2E0oGtop4NzFzf/ac0qir1tquDX0VjR7kEXvr+FxmWg+bt5
hLWGO/cQgH+gfM9xL0pIQ8+qPksAUbI7FqyYWTXFwQ/Z84BR5qZB3ZDh77VfruqI
7VzpiyWqr3XXE7uKZ7xLJk3DeDBa1KIZLNhKNpsaH687dFQQUbyJxdLm4WGlJI0p
hipPkB+ol0xEbMkL/KVly3CFnMBI0WN7GwRwe8PpU+YyxkDU81DWwwFj0oEYbQbw
6UtJdCvyIYLpDBXHaE9oLxYxtvUbC7++IaBtZFlt69/Tfqck0wrjOFSip26evGfo
3pkXEEyuIn9SpL8iEIpIV6lcUJN25yyOOL8fKHzeHkW912ajxR+iHSFgvImESlU5
JN44xH+zAjqO/iVxhdgqky0xkpUjMyVdt34lrZveYQckkAGP5VcBdb/npI6YT9+p
L2R0/j+b3KpBgytq0wRT62L+qXpIrVZj4vN50v/p2qMXAnbqGRg6xvo4GDTxjpFy
eYUhaxaOkEnmr+8HSyR/bGUa18MAklfmB9ZPrA9+k5/qZQAOFVY8IR1sW31b9fF+
lMdKpwHsV0s+iq/BD+4npGQ3NcgfpdLfQ1TZDu57ncpNBrppJI8=
=HvfN
-----END PGP SIGNATURE-----

--Sig_/Bm6w=GLeaMGssCUl39Cu.Os--


