Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59466C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200E1206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dvOG2YH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200E1206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1kVl-0003aC-9J
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 00:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j1kV4-00032L-Ov
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 00:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j1kV2-00075y-Qc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 00:23:50 -0500
Received: from ozlabs.org ([203.11.71.1]:51933)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j1kV1-0006ze-Kk; Wed, 12 Feb 2020 00:23:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48HSjN2FrQz9sRJ; Wed, 12 Feb 2020 16:23:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581485016;
 bh=jIWnJf/P5cbNQ3HsxCS9rVqTxbvwhCynCHcBHmj60oI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dvOG2YH3Cb9dvrf248dFVUz9WsfP7rst7L4GVjXMCiDubv15oSuggvLHxftABwxSx
 JFNr+Jf1Zio+zGOiORH0RtrorPoIPZjnwVeuLQXA7n6+gqgUAKxmPCz3viKuCsWQ9o
 zi7XY5U0rk6QoWXEqgq+aM3VZYj7dSiuRhop6fT4=
Date: Wed, 12 Feb 2020 16:23:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v6 0/4] ppc: spapr: virtual NVDIMM support
Message-ID: <20200212052330.GW22584@umbus.fritz.box>
References: <158131055152.2897.1684848646085925139.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yBbBYFH0ZHvzMoI/"
Content-Disposition: inline
In-Reply-To: <158131055152.2897.1684848646085925139.stgit@lep8c.aus.stglabs.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, qemu-ppc@nongnu.org,
 xiaoguangrong.eric@gmail.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yBbBYFH0ZHvzMoI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2020 at 10:55:51PM -0600, Shivaprasad G Bhat wrote:
> The patchset attempts to implement the virtual NVDIMM for pseries.
>=20
> PAPR semantics is such that each NVDIMM device is comprising of
> multiple SCM(Storage Class Memory) blocks. The hypervisor is expected
> to prepare the FDT for the NVDIMM device and send guest a hotplug
> interrupt with new type RTAS_LOG_V6_HP_TYPE_PMEM currently handled by
> the upstream kernel. In response to that interrupt, the guest requests
> the hypervisor to bind each of the SCM blocks of the NVDIMM device
> using hcalls. There can be SCM block unbind requests in case of driver
> errors or unplug(not supported now) use cases. The NVDIMM label
> read/writes are done through hcalls.
>=20
> Since each virtual NVDIMM device is divided into multiple SCM blocks,
> the bind, unbind, and queries using hcalls on those blocks can come
> independently. This doesnt fit well into the qemu device semantics,
> where the map/unmap are done at the (whole)device/object level
> granularity. The patchset uses the existing NVDIMM class structures
> for the implementation. The bind/unbind is left to happen at the
> device_add/del phase itself instead of at hcalls on-demand.
>=20
> The guest kernel makes bind/unbind requests for the virtual NVDIMM
> device at the region level granularity. Without interleaving, each
> virtual NVDIMM device is presented as separate region. Hence it is
> safe to do bind/unbind everything during the object_add/del.
>=20
> The free device-memory region which is used for memory hotplug are
> done using multiple LMBs of size(256MiB) and are expected to be
> aligned to 256 MiB. As the SCM blocks are mapped to the same region,
> the SCM blocks also need to be aligned to this size for the subsequent
> memory hotplug to work. The minimum SCM block size is set to this size
> for that reason and can be made user configurable in future if required.
>=20
> The first patch moves around the existing static function to common
> area for using it in the subsequent patches. Second patch adds new uuid
> property to the nvdimm device. Third patch adds FDT entries and basic
> device support, the fourth patch adds the hcalls implementation.
>=20
> The patches are also available at
> https://github.com/ShivaprasadGBhat/qemu.git - pseries-nvdimm-v6 branch
> and can be used with the upstream kernel. ndctl can be used for
> configuring the nvdimms inside the guest.
> This is how it can be used ..
> Ex :
> For coldplug, the device to be added in qemu command line as shown below
> -object=20
> memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=3D/tmp/nvdimm=
0,share=3Dyes,size=3D1073872896
> -device=20
> nvdimm,label-size=3D128k,uuid=3D75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memd=
ev=3Dmemnvdimm0,id=3Dnvdimm0,slot=3D0
>=20
> For hotplug, the device to be added from monitor as below
> object_add=20
> memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=3D/tmp/nvdimm=
0,share=3Dyes,size=3D1073872896
> device_add=20
> nvdimm,label-size=3D128k,uuid=3D75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memd=
ev=3Dmemnvdimm0,id=3Dnvdimm0,slot=3D0

Applied to ppc-for-5.0, thanks.

>=20
> ---
> v5: https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg07472.html
> Changes from v5:
>      - Moved most of the nvdimm code from spapr.c to spapr_nvdimm.c
>      - Addressed all style/logic comments.
> v4: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03455.html
> Changes from v4:
>      - The nvdimm occupied GPA area is marked as available for hotplug, t=
he
>        existing code takes care of if the dimm device is actually present=
 there
>        or used by nvdimm.
>      - fixed all comments for hcall implementation code on style/logic is=
sues.
> v3: https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03452.html
> Changes from v3:
>      - Moved NVDIMM uuid property addition to new patch.
>      - Moved the SCM hcalls to new file
>      - Changed the metadata read/write hcalls to use st/ldX_be_p macros.
>      - Fixed all comments on v3
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02785.html
> Changes from v2:
>      - Creating the drc indices for the nvdimm devices in advance as
>        suggested based on the number of user specified max slots property.
>      - Removed the hard dependency on -machine nvdimm=3Don, enabled by
>        default on the current latest pseries machine version.
>      - Renamed the functions to spapr_dt_X as suggested.
>      - Metadata is byteswapped before read/write to take care of endianne=
ss
>        semantics during the hcall.
> v1 : http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg01545.html
> Changes from v1:
>      - Rebased to upstream, this required required dt_populate implementa=
tion
>        for nvdimm hotplug support
>      - Added uuid option to nvdimm device
>      - Removed the memory region sizing down code as suggested by Igor,
>        now erroring out if NVDIMM size excluding the label area is not
>        aligned to 256MB, so patch 2 from previous series no longer needed.
>      - Removed un-implemented hcalls
>      - Changed the hcalls to different kinds of checks and return
>        different values.
>      - Addressed comments for v1
> ---
>=20
> Shivaprasad G Bhat (4):
>       mem: move nvdimm_device_list to utilities
>       nvdimm: add uuid property to nvdimm
>       spapr: Add NVDIMM device support
>       spapr: Add Hcalls to support PAPR NVDIMM device
>=20
>=20
>  default-configs/ppc64-softmmu.mak |    1=20
>  hw/acpi/nvdimm.c                  |   28 --
>  hw/mem/Kconfig                    |    2=20
>  hw/mem/nvdimm.c                   |   40 +++
>  hw/ppc/Makefile.objs              |    2=20
>  hw/ppc/spapr.c                    |   69 +++++
>  hw/ppc/spapr_drc.c                |   19 +
>  hw/ppc/spapr_events.c             |    4=20
>  hw/ppc/spapr_nvdimm.c             |  475 +++++++++++++++++++++++++++++++=
++++++
>  include/hw/mem/nvdimm.h           |    7 +
>  include/hw/ppc/spapr.h            |    8 +
>  include/hw/ppc/spapr_drc.h        |    9 +
>  include/hw/ppc/spapr_nvdimm.h     |   37 +++
>  include/qemu/nvdimm-utils.h       |    7 +
>  util/Makefile.objs                |    1=20
>  util/nvdimm-utils.c               |   29 ++
>  16 files changed, 699 insertions(+), 39 deletions(-)
>  create mode 100644 hw/ppc/spapr_nvdimm.c
>  create mode 100644 include/hw/ppc/spapr_nvdimm.h
>  create mode 100644 include/qemu/nvdimm-utils.h
>  create mode 100644 util/nvdimm-utils.c
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yBbBYFH0ZHvzMoI/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5Di9AACgkQbDjKyiDZ
s5L3+A//V3nYz6dU4FccF1U225GXbcyNYmhW1fkmIxFLnPbe96APFHoHzQT1I2Fe
DsxMLHK4YlZONSd8Yr5vLh1iJijES0+YTn1sKGKM/pBUaKsB4ItDtxmvMHdSYPsu
/mBTycBRuuHf/KtAUqJlCW1b51ii5keEz6Ew/s87nhY2iRB++HYWbFSUNAGiuWEL
j6ZFHA86q5ZlCzpjJzTmaiMlTur5GJ35Q3TcfRFp7GQ6ZNjEKw2QVN9zC3gDqo1B
Z6423nlLNQ3Q4gBKqyec1IS+9dHQMQ8px9I50H2C4YkJsUOmIi+q99N/4v9hm815
r9zhfmYW8WXNFhYof8DFvj9oXXQaKw354GS5+IzuCinI5Hxs9DiCnU3DtUrjkVvl
25AnZufIrmD52FDVS225WNhwbgW6/we1Z8XLz792mM5tVjItLJhb7KspsJbZcvfS
E3gv7BODaWVpgZEEMGhrwdnX3Q9fMW8yzH9x6qzJo+Xat/d4CRBSIU8xNqru801m
zCdIis/8uAaQLMECFydtodr2wq536PFv0yvp/eWjp74vvyexpbWrifYqdePGNNdh
KJPMnAt3nihxEWt4u2f34IvvFIULSxOwCEJa3swGyTrYWsIDfrrqZ+Pvg49epH3z
vWld3NAqm7QmH/kUCx06JesgzYpKhdH64Du1UNncfULJQzLYR6w=
=uXYy
-----END PGP SIGNATURE-----

--yBbBYFH0ZHvzMoI/--

