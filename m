Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050EDC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26372070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQNdIsci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26372070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k00A1-0001jp-SO
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k009E-0000Xs-9M
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:14:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41548
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k009C-0002yE-HN
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595844857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4D0FWDrKJstlq/XsZeHElwDKoN8X35sOGZ0PfymHnEM=;
 b=jQNdIsciV9jfkactBGOgWtFboMdXYv5Sllc43d20ozRqZS3/z9aVaYFUiSp/eyIqDRZisp
 dEVNz034pNy6wo6Qy6j16AaD0ddE/M6pbhXl4ZoLvb28G/RuP/BhV+cIc+rwz+qNrlqIG3
 4pm9TFNtX9tR9mu44vXWGZv9nQSm1jQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-G-pOi4wSNeeaR-wJkvC9vA-1; Mon, 27 Jul 2020 06:14:16 -0400
X-MC-Unique: G-pOi4wSNeeaR-wJkvC9vA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44F1A58;
 Mon, 27 Jul 2020 10:14:14 +0000 (UTC)
Received: from localhost (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A8195FC36;
 Mon, 27 Jul 2020 10:14:04 +0000 (UTC)
Date: Mon, 27 Jul 2020 11:14:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
Message-ID: <20200727101403.GF380177@stefanha-x1.localdomain>
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <CAJSP0QU78mAK-DiOYXvTOEa3=CAEy1rQtyTBe5rrKDs=yfptAg@mail.gmail.com>
 <874kq1w3bz.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <874kq1w3bz.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "John G. Johnson" <john.g.johnson@oracle.com>,
 Jag Raman <jag.raman@oracle.com>, Andra-Irina Paraschiv <andraprs@amazon.com>,
 kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eric Auger <eric.auger@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Nikos Dragazis <ndragazis@arrikto.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 11:49:04AM +0100, Alex Benn=E9e wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
> > 2. Alexander Graf's idea for a new Linux driver that provides an
> > enforcing software IOMMU. This would be a character device driver that
> > is mmapped by the device emulation process (either vhost-user-style on
> > the host or another VMM for inter-VM device emulation). The Driver VMM
> > can program mappings into the device and the page tables in the device
> > emulation process will be updated. This way the Driver VMM can share
> > memory specific regions of guest RAM with the device emulation process
> > and revoke those mappings later.
>=20
> I'm wondering if there is enough plumbing on the guest side so a guest
> can use the virtio-iommu to mark out exactly which bits of memory the
> virtual device can have access to? At a minimum the virtqueues need to
> be accessible and for larger transfers maybe a bounce buffer. However
> for speed you want as wide as possible mapping but no more. It would be
> nice for example if a block device could load data directly into the
> guests block cache (zero-copy) but without getting a view of the kernels
> internal data structures.

Maybe Jean-Philippe or Eric can answer that?

> Another thing that came across in the call was quite a lot of
> assumptions about QEMU and Linux w.r.t virtio. While our project will
> likely have Linux as a guest OS we are looking specifically at enabling
> virtio for Type-1 hypervisors like Xen and the various safety certified
> proprietary ones. It is unlikely that QEMU would be used as the VMM for
> these deployments. We want to work out what sort of common facilities
> hypervisors need to support to enable virtio so the daemons can be
> re-usable and maybe setup with a minimal shim for the particular
> hypervisor in question.

The vhost-user protocol together with the backend program conventions
define the wire protocol and command-line interface (see
docs/interop/vhost-user.rst).

vhost-user is already used by other VMMs today. For example,
cloud-hypervisor implements vhost-user.

I'm sure there is room for improvement, but it seems like an incremental
step given that vhost-user already tries to cater for this scenario.

Are there any specific gaps you have identified?

Stefan

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8eqOsACgkQnKSrs4Gr
c8jVuwf/dMUfwXbg5feyaXcjXesUe7kmUPUmxngBBKTNJLAhQpXl8THNOWOAr4B9
2XqUijee0eoY9I8n21RsE/wxYbNpk9NFcSINwwoC8qVAnw4nLEX53QZ9d0dHJqx+
s/3/ONnt1Wn+BOabXpqqhRIGjKCBo3UeT5HGnylNTDEphRnFCDMLg/g19Ekh8yvA
arrCWAKNICAI+LwHsjXf73RrsD6e5s4MdBfjwDARY/0rQFmgo/9Mci8Wm25f8jr6
qpepR/vh4HgZ4BirwOO/D5wPDCq6aVYY79+qRfaIsE/Sgl6tVwXAt71KtfG1Hp5e
6TedqkApkqZjK7WpdsBRDaPvRMtJAQ==
=4idR
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--


