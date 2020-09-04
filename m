Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC85C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921C220665
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="CsJPh9t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921C220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFMI-0001kH-86
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kEFLk-0001Ge-6j; Fri, 04 Sep 2020 13:18:08 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kEFLh-0004VC-5x; Fri, 04 Sep 2020 13:18:07 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 2732FBF7D3;
 Fri,  4 Sep 2020 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599239882;
 bh=E579wGZx7XEvccA1emNNVA2p75ag4h0P8tr/8HsnL4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CsJPh9t5FB6JRGuh7q1zhVmrUdEr569h982OUYkum917Sv4DJCxJrSrAZ3IDvdkBa
 /dxltuRIjX1eF/eYzNmiH87ZCnaaKuhJTbnOWgk2Uy5go9kyDPF1cMeKNRr3K9gmqQ
 SwiBYF3krEkrrvQeeDW0nvLf9M3H+03Gc1mfB2aTUfr0kn9vdjV1aZqhpxnvOV9cJp
 3VsY3pUmdBN6hyC2sHJHMTF4kk0Jz2PgPBYmjjA6Yw3JJ74vqjWVQpterbahhw7Cn3
 I0Nvg2+DQFnZp64PammdpSLT7g10T5Rs/HbpxsLVgCR80G8YjIIlfCBg86QFfmBY+S
 dsD4P525Bh/ZQ==
Date: Fri, 4 Sep 2020 19:17:59 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 00/17] hw/block/nvme: multiple namespaces support
Message-ID: <20200904171759.GB584438@apples.localdomain>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <b44b738e-db6f-e820-11ef-ad9c7615f9a3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <b44b738e-db6f-e820-11ef-ad9c7615f9a3@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  4 18:12, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Klaus,
>=20
> On 9/4/20 4:19 PM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > This is the next round of my patches for the nvme device.
> >=20
> > This includes a bit of cleanup and three new features:
> >=20
> >   * refactored aio submission
> >     This also adds support for multiple parallel AIOs per request which=
 is in
> >     preparation for DULBE, ZNS and metadata support. If it is found
> >     controversial, it can easily be dropped from this series.
> >=20
> >   * support for scatter/gather lists
> >=20
> >   * multiple namespaces support through a new nvme-ns device
> >=20
> > Finally, the series ends with changing the PCI vendor and device ID to =
get rid
> > of the internal Intel id and as a side-effect get rid of some Linux ker=
nel
> > quirks that no longer applies.
> >=20
> > "pci: pass along the return value of dma_memory_rw" has already been po=
sted by
> > Philippe in another series, but since it is not applied yet, I am inclu=
ding it
> > here.
> >=20
> > Gollu Appalanaidu (1):
> >   hw/block/nvme: add support for sgl bit bucket descriptor
> >=20
> > Klaus Jensen (16):
> >   pci: pass along the return value of dma_memory_rw
> >   hw/block/nvme: handle dma errors
> >   hw/block/nvme: commonize nvme_rw error handling
> >   hw/block/nvme: alignment style fixes
> >   hw/block/nvme: add a lba to bytes helper
> >   hw/block/nvme: fix endian conversion
> >   hw/block/nvme: add symbolic command name to trace events
> >   hw/block/nvme: refactor aio submission
> >   hw/block/nvme: default request status to success
> >   hw/block/nvme: support multiple parallel aios per request
> >   hw/block/nvme: harden cmb access
> >   hw/block/nvme: add support for scatter gather lists
> >   hw/block/nvme: refactor identify active namespace id list
> >   hw/block/nvme: support multiple namespaces
> >   pci: allocate pci id for nvme
> >   hw/block/nvme: change controller pci id
> >=20
> >  MAINTAINERS            |   1 +
> >  docs/specs/nvme.txt    |  23 +
> >  docs/specs/pci-ids.txt |   1 +
> >  hw/block/meson.build   |   2 +-
> >  hw/block/nvme-ns.c     | 185 +++++++++
> >  hw/block/nvme-ns.h     |  74 ++++
> >  hw/block/nvme.c        | 923 +++++++++++++++++++++++++++++++----------
> >  hw/block/nvme.h        | 126 +++++-
> >  hw/block/trace-events  |  21 +-
> >  hw/core/machine.c      |   1 +
> >  include/block/nvme.h   |   8 +-
> >  include/hw/pci/pci.h   |   4 +-
>=20
> To ease the review, consider setup'ing scripts/git.orderfile,
> as it avoid reviewers to scroll patches in their email client.
>=20

Oh wow. You learn something new everyday. That's really neat!

Thanks!

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9SdsQACgkQTeGvMW1P
DekkKwf/dQT7zgJ1xQauyXzPxSf+NX4yo+7+ZLhVVyk0tqWS8u3Foy5s9ken27V3
jbph7qiJ4GvS76j9ogQ9V1yoKdPXIbJbTa7ICukMJV2fSYzYcHEGoWmvMrXybeBl
KRgByUmXu8wv0jnfZ2pWWiFpJjBZC6NWWieZRlQy9d921FDAZ4HCiU4mHdr9avvQ
GqzjBFvPYvPXOkqcJybr75t/sw/x2qvpCDbKUF0NzVMUBnhL83CFXoKyDv7PZQl/
zjLAf5SAEpyuRE4W8LjV3Xic7D7yeJDd2eCkwcM3JdTfkhbyHpfETXxfwXHUEzSV
RPQguR9O/oCTmt0vsFZIWfqL+FJ4Xw==
=Qv0Q
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--

