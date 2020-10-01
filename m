Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405BEC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C313920719
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+f4CYGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C313920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0Nj-0004ST-T0
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kO0Hh-00060l-Tp
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kO0Hg-0007mx-3z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601565255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QTHdR74vCtozDIOnIU2otJrvKiJYUcSUikVSyp73LSQ=;
 b=P+f4CYGukBnsSql1d9R7w5xKQr+1rURLtE6/7UOypRvqcbFXEReyXer/8MuXAMfd4FlJfh
 fM7UQ4ZUzVnZc3XOJNim9+jIfTHfr1juvoimDKLJylgq2b+Wa8t0yR86U1PEd2NwRZd6Ny
 Cyj84XNz7xl2GZGdy0WUZ3XCB1rXbuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-e80XrKXTM-2QTYKO1DSrug-1; Thu, 01 Oct 2020 11:14:11 -0400
X-MC-Unique: e80XrKXTM-2QTYKO1DSrug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF249101FFC7;
 Thu,  1 Oct 2020 15:13:51 +0000 (UTC)
Received: from localhost (ovpn-115-144.ams2.redhat.com [10.36.115.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F0306F142;
 Thu,  1 Oct 2020 15:13:50 +0000 (UTC)
Date: Thu, 1 Oct 2020 16:13:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20201001151350.GC559957@stefanha-x1.localdomain>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
 <20200929020114-mutt-send-email-mst@kernel.org>
 <20200929085751.GA181609@stefanha-x1.localdomain>
 <20200929055110-mutt-send-email-mst@kernel.org>
 <20200929183824.GC191675@stefanha-x1.localdomain>
 <20200930034807-mutt-send-email-mst@kernel.org>
 <20200930145752.GB320669@stefanha-x1.localdomain>
 <20201001072837.xbiomrvbox6ukl2c@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20201001072837.xbiomrvbox6ukl2c@sirius.home.kraxel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: lulu@redhat.com, tiwei.bie@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, qemu-devel@nongnu.org, raphael.norwitz@nutanix.com,
 maxime.coquelin@redhat.com, Felipe Franciosi <felipe@nutanix.com>,
 marcandre.lureau@redhat.com, Nikos Dragazis <ndragazis@arrikto.com>,
 changpeng.liu@intel.com, Daniele Buono <dbuono@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 09:28:37AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > > Architecturally, I think we can have 3 processes:
> > >=20
> > > VMM -- guest device emulation -- host backend
> > >=20
> > > to me this looks like increasing our defence in depth strength,
> > > as opposed to just shifting things around ...
> >=20
> > Cool idea.
>=20
> Isn't that exactly what we can do once the multi-process qemu patches
> did land, at least for block devices?  With "VMM" being main qemu,
> "guest device emulation" being offloaded to one (or more) remote qemu
> process(es), and qemu-storage-daemon being the host backend?

Status of mpqemu: the current mpqemu patch series has limited
functionality (so that we can merge it sooner rather than later). Don't
expect to use it with arbitrary PCI devices yet, only the LSI SCSI
controller.

In mpqemu (and vfio-user) QEMU handles all MMIO/PIO accesses by
forwarding them to the device emulation process. Therefore QEMU is still
involved to an extent. This can be fixed with ioeventfd for doorbells,
the proposed ioregionfd mechanism for MMIO/PIO, and vfio-user mmap
regions for RAM-backed device memory.

However, QEMU itself still emulates the PCI controller. This means
PCI configuration space and other device operations still go to QEMU. In
order to fully move emulation out of QEMU we'd need to do something more
drastic and I think this is what we're discussion in this sub-thread.

Stefan

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl918i0ACgkQnKSrs4Gr
c8j4pwf/aG1nSnsU98xinjlwC/OUKBPM34bkhO2KhuCap3r1FDbv14CfqbUNHpWp
T+2n6Em+gF1mRTKyb5sLJJawklpxUkxvs3wSqqSTrcMdaYPPe4wZg4AP9N3fegA3
0Z+gBhvZ8XVY6NPhij0AAi5WMWwCZLawBe/emOZRvfkQFlJXfM3N50NkDuztQUvV
UNPMhC2QANIuizHOKRTsKQ9b05AH/GSIAK1lJtMtTT+k0ul4855tk4oWMipBNKUp
xA/w78g1Ly8a7o02krHEfj0K8MulxHr/qJq9VIC4hZyB59X7IC4tKuicTSJCiJg2
acLTADnKZqP5aWALhNYV/Kzo4MfVug==
=Enkb
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--


