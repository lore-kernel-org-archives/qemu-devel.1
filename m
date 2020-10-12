Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A07C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B1D20797
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKXc1HlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B1D20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Mr-0001kr-So
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kRzvs-0006Fk-5s
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kRzvp-0007y0-PX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602517212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DVixEqqeVflPHK11GmgrAi8rnouQH4p1O5TKpM7BIUs=;
 b=PKXc1HlCIvpGT1yOphgFX9bt+m0zr7igvvDoTrdzBMvkozgD5+O8bl9ibr1gRA9gcfRv9H
 vLskeU97zVzRmBUw3UOT43++VGJzGQzFGQnddPXZtIqzn37vBjSoHYxyj4UomlJrJgjTAY
 fWIk95e0i5hmNJdIl8dsauJuTAbEbnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-6awFRsR1N4C7aMZlm4e4VA-1; Mon, 12 Oct 2020 11:40:08 -0400
X-MC-Unique: 6awFRsR1N4C7aMZlm4e4VA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DD3A107464F;
 Mon, 12 Oct 2020 15:40:07 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2835D5D9CD;
 Mon, 12 Oct 2020 15:39:53 +0000 (UTC)
Date: Mon, 12 Oct 2020 16:39:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Requirements for out-of-process device emulation
Message-ID: <20201012153953.GC145304@stefanha-x1.localdomain>
References: <20201009161815.GA321402@stefanha-x1.localdomain>
 <20201009134449.041b5e71@x1.home>
MIME-Version: 1.0
In-Reply-To: <20201009134449.041b5e71@x1.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Daniele Buono <dbuono@us.ibm.com>, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Hubertus Franke <frankeh@us.ibm.com>, rust-vmm@lists.opendev.org,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2020 at 01:44:49PM -0600, Alex Williamson wrote:
> On Fri, 9 Oct 2020 17:18:15 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > Extensibility for new bus types
> > ```````````````````````````````
> > It should be possible to support multiple bus types. vhost-user only
> > supports vhost devices. VFIO is more extensible but currently focussed
> > on PCI devices.
>=20
> Wait a sec, the vfio API essentially deconstructs devices into exactly
> the resources you've outlined above.  We not only have a vfio-pci
> device convention within vfio, but we've defined vfio-platform,
> vfio-amba, vfio-ccw, vfio-ap, and we'll likely be adding vfio-fsl-mc in
> the next kernel.  The core device, group, and container model within
> vfio is completely device/bus agnostic.  So while it's true that
> vfio-pci is the most mature and featureful convention, that's largely a
> reflection that PCI is the most ubiquitous device interface currently
> available.  Thanks,

Hi Alex,
Yes, I don't mean to say that VFIO cannot support new bus types.

The most likely new bus type I can foresee is QEMU's SysBus, which would
allow moving ISA, System-on-Chip, etc devices into a separate process.

We'll need to figure out whether vfio-user evolves independently from
the kernel VFIO ioctl interface or whether efforts are made to keep the
two in sync. The kernel may not need SysBus, but as the vfio-user
protocol diverges from the kernel VFIO ioctl interface it becomes harder
to share the commands and avoid duplication.

Stefan

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+EeMgACgkQnKSrs4Gr
c8h1Ywf/eIQr/18sJt/dqjy25EKLxXHJiTklYCicP6hnMsnZJcy27Zyu9o0C5kRv
Etf22l7GvKPWcz/cc5ZE0LoS6qXlqEBiuhdzBLohcQtqhLdarWZMZZGaO5ImcYah
vk6gn3mg6tD0nrZi8YYQXqmoKRdu0e71DCvM+2zn6QoRczt1sIvWSju5mIy0vlyc
kKY837yCLaHTAoJthswXIvqb4zKATBoN8fNy4muexP1lKBvUxXDT4gCn/A04qPbf
PSrR3Ya33r0KwCznAeiTBuaBfDtVxW1cnLplUwJpBkE27z58VT/i5PfRK85cSB0r
hMDMLDggZ0dNESZrxUfejBSbfRZJPg==
=zVFf
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--


