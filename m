Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83703C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D242076A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjGQ8gFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D242076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVnok-0003i4-Jz
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 23:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kVnmt-00037e-Q2
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 23:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kVnml-0002jj-8s
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 23:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603423833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3AuevVAMDzcOgfo+A7j7lRJ0/oU9OugMwoQabXwa/Es=;
 b=RjGQ8gFfPcE8t4WtCeIrSR1IpmgmGbdla93qcxPt0buYh1y6Je+lhSJhhs2LsK4AXngWCn
 O10xAfJy41PeOx3T8pu29CkdyNFzIk9oFI9api/dRRM6xzNzVWGx9LUs/FzTWUbmA3HDea
 Fy2MaDV4RgPNiyG/vPjkRz6FURuUlqs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-TgyijZByPOmZJKcO62vFMg-1; Thu, 22 Oct 2020 23:30:28 -0400
X-MC-Unique: TgyijZByPOmZJKcO62vFMg-1
Received: by mail-pf1-f197.google.com with SMTP id 9so2594712pfj.22
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 20:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=3AuevVAMDzcOgfo+A7j7lRJ0/oU9OugMwoQabXwa/Es=;
 b=tgh0bb92Sj/+DcgcTQMw71ZbqsGLcxZ0oJ6HokkwbsdCQDuB3RRL32LHW/n84mL4C4
 2kxkx8QLvSGiI2Zx7Xnh4TwqvsGO+Ah1qIfIFW2Ve+++RjSlPFw2LuSqu1GJQYgf9ykC
 9NaIOK6zZRreYIH1gPxa0yRCyJkGXlSnDBkO3FI9dZh2HJlvOkE8xFBOBByPoD9147or
 p70mXWayYH2e/03s0N3eQ8GyWysdA7akQp92pyTzFN/+Job7sklLeSMMdLv9hwIvDjF5
 99HvnyyfhxTX5AZo1vKONemE/gL2GgLIuNgPJBWvYMTfX70eEKZFPE4IQEdziMIApkVT
 ybDA==
X-Gm-Message-State: AOAM533smzjESTRY7MWM92IhuVa/4G81XPbIxIpZQTcTZoOs25+DZl2r
 HHdKSMgufJvSCTD/TQj3afvQaNDDaqEFV6yDAV0NolYOtLb+ItCbpGuveNAgyQuHLWwf+57cvTa
 LRhGcp35i6yHgNlY=
X-Received: by 2002:a17:90a:2e03:: with SMTP id
 q3mr215621pjd.180.1603423827177; 
 Thu, 22 Oct 2020 20:30:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRD6VFO6O9YJFlNkxZXRm6uhEodFdEenZMVtpNPJURFljpmDmS634MuoN/BEkE09odVlLv4Q==
X-Received: by 2002:a17:90a:2e03:: with SMTP id
 q3mr215601pjd.180.1603423826930; 
 Thu, 22 Oct 2020 20:30:26 -0700 (PDT)
Received: from yekko.fritz.box ([2001:4479:e000:a00:52ee:f101:6b37:1519])
 by smtp.gmail.com with ESMTPSA id u21sm179836pfk.89.2020.10.22.20.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 20:30:26 -0700 (PDT)
Date: Fri, 23 Oct 2020 14:30:16 +1100
From: David Gibson <dgibson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201023143016.3f80e51e@yekko.fritz.box>
In-Reply-To: <20201022091500-mutt-send-email-mst@kernel.org>
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <20201022091500-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgibson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/WdabjhRry4rFQ5lMT3M.sK9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 23:30:33
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
Cc: jusual@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/WdabjhRry4rFQ5lMT3M.sK9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Oct 2020 09:15:28 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Oct 22, 2020 at 11:56:32PM +1100, David Gibson wrote:
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > Probably the only way to handle for existing machine types.
> > > For new ones, can't we queue it in host memory somewhere? =20
> >=20
> > I'm not actually convinced we can't do that even for existing machine
> > types. =20
>=20
> The difficulty would be in migrating the extra "reuested but defferred"
> state.

Ah, true.  Although we could block migration for the duration instead.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/WdabjhRry4rFQ5lMT3M.sK9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+STkgACgkQbDjKyiDZ
s5Id3RAAgJEQBl3PdTcGfa/PottP9Gu9FnoJYztbk3r/jcEerO31gLGi3NSWjO41
fFE9vPpZoqc4wkegWDq+QwLuF2S4n+fuuKiDRuImctROCDt1yG9wWWtjbCl0khsw
DnJ+XcCvZEt2oTV5gyHR8EuaL31mvpz19rTToopiiveRRuettIfq+2idBt6eGg5g
rrwAyoqbUxiHaw4tzsMsgAFe2EgoLOjzW/HgbmriOgMIohucrHXsnX/U/ea+BDV2
FCNKsU9e95bmnFG/fByyvZqaqngTztWfsN+Sn3eNx4sqou99G+4oefoSii4IQJDi
btiBCNmnzrk+48mCpuO6vKo6IOiUuw/qpKZwKOdlhG6FqzR0yzI05+6VPNwVL6Wk
GLG0nc5RjKcPkHe39HwVUbJ9co/7gM15QmZb0a57uBOF0aZbcJj7WJhH8aeNTT7b
n3ChegqoxegY26LEaEthWVrdaxpw2rTXmI96yVTPyswbR+icqK+HAv2IzLjbnsXX
Od/N4D4vQZD2APH8N29aDdHsgI/mpC/mPJKmMkZaJZmwz4ZpSzNIITA8wk8cD1IJ
LwNA/BhU//I/tN1YMxV2HBfdKnYSs9a9V/qUkcaQ53tA8+W+2i3QN6phki4nJmPt
jMByU81TxZfPc4vv2DCKsgkvbHh3ovpxf6CYRo6Q13IeahD4kEc=
=7ZWE
-----END PGP SIGNATURE-----

--Sig_/WdabjhRry4rFQ5lMT3M.sK9--


