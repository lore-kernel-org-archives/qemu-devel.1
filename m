Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF550C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5139A2224D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGyrdX3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5139A2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGiaA-0007uE-DG
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGiZW-0007Qn-Hh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGiZU-0004CR-QD
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599828871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAXkZF+SMVhxruDhqRYtQ9eRcaGQuy136bNW2EJdttk=;
 b=HGyrdX3aI5lnu9wlw+NthDM8RTmPpuYhh2qoq9DsD0BAN0KKe4gSMnPxUDOWgUGgRH/1v5
 uycP5izOChKAQpEpG8cuApouhh4Pdd8hdnaxdbEYVCghFy34DgM6Mq3M8t0xzycBr2XMv9
 Fw9l5EV9cgCcx+2nG2btWFDdCARLYPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-Q7d567GoNBe-5kuNxYUN7w-1; Fri, 11 Sep 2020 08:54:17 -0400
X-MC-Unique: Q7d567GoNBe-5kuNxYUN7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 672548015A4;
 Fri, 11 Sep 2020 12:54:16 +0000 (UTC)
Received: from localhost (ovpn-113-177.ams2.redhat.com [10.36.113.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60C865C1BD;
 Fri, 11 Sep 2020 12:54:04 +0000 (UTC)
Date: Fri, 11 Sep 2020 13:54:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com
Subject: Re: VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200911125403.GL94280@stefanha-x1.localdomain>
References: <20200821110822.GA205318@stefanha-x1.localdomain>
 <ea150955-fc89-147f-0fdc-1ff60b35a6e6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ea150955-fc89-147f-0fdc-1ff60b35a6e6@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.326
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
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
Cc: Chenbo Xia <chenbo.xia@intel.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, kraxel@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Changpeng Liu <changpeng.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2020 at 10:55:00AM +0200, Maxime Coquelin wrote:
> I understand the need and like the idea.

If no one plans to work on this within the next 6 months it could be an
internship project since the Outreachy December-March round is coming
up.

The time requirement is typically ~5 hours per week from the mentor.

Jason, Maxime, Cindy, Michael: Are you interested in mentoring this
project idea?

Internships focus mostly implementing existing designs since the intern
doesn't have enough background knowledge or time to design some of this
complexity from scratch.

As a starting point, the vhost-user protocol can be extended with all
the vDPA messages. Redundant vhost-user messages from the existing
protocol can be dropped/deprecated (i.e. device-specific messages that
were introduced to work around the lack of the VIRTIO device lifecycle).

Fully embracing the vDPA/VIRTIO lifecycle eliminates the need for
per-type QEMU devices (vhost-user-net, vhost-user-blk, etc). Instead
per-transport devices are needed (-device vdpa-user-{pci,ccw,mmio}).
This means new device types can be added later without writing all the
boilerplate -device vhost-user-foo-{pci,ccw,mmio} code!

The internship could focus on implementing -device vdpa-user-pci and a
libvdpa-user test/example. The vhost-user spec changes should probably
be agreed by the community beforehand so the intern doesn't need to
worry about the protocol design (there's plenty of implementation work
to do!).

This is one way to break this down into an internship project, but there
are other approaches. Maybe you prefer to extend vhost-user more
gradually (e.g. no -device vdpa-user-pci and the existing per-type
device approach is continued) while still adding the vDPA protocol
messages...

Anyway, if you'd like to mentor this project in Outreachy December-March
please add a project idea to the QEMU wiki:
https://wiki.qemu.org/Outreachy_2020_DecemberMarch

Stefan

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9bc2sACgkQnKSrs4Gr
c8gwrAf+KRZ+0DYK/lvPS8flDuMZG8JnLPFbn4TQjetpWw1Ct6rz0a1kRCheq38L
6uiBxgZ4fM9xXUzkz3L+UMLJyEEZziuAPdCb5z1kMR0R8DFaMKU+qxB3bClTkcUs
CIY+Kk6/brn8gx2tV2L/4bNESTOCknBV9qdNRUVNAChbauGps0pHImiL8ByWtH+K
YU+8k9bkF97U8JHRVMn+DH3X3W7z34dsST8ixnk9iyyCcxSv0OXEGL+YB3vNCaO+
A5OZ22vS8NLQoFky8ce3sjZ36Q79RrfsRdI3wQ9VWN9EknMDX31qA1W7YenbsaiF
8Yf7300nkY0dUKqqA67SdF5XIWnCDw==
=kvXD
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--


