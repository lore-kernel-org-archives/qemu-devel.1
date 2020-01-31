Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URI_WP_DIRINDEX autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0425CC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 04:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EA020702
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 04:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OhPkwtwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EA020702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixNna-0004kr-0F
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 23:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ixNlv-0003Kr-0Y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 23:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ixNlt-00027x-EM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 23:19:10 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56291 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ixNls-00023c-Vx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 23:19:09 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4883rR4R0jz9sRQ; Fri, 31 Jan 2020 15:19:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580444343;
 bh=S8HBFAr+JEPEt6RudSE2u2FRnvTK1cgTyXZx/iPTRdU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OhPkwtwZM+eUMobCQtW4UNn1sRRPuk4Ul6MdQXX3oLy3SY58Z2wldCSIRs6reItaU
 nja5hiA6LgM/70Rcm/u69f+eBIaen+w5Let/iSr+4BfZGJ0Gcp60Im2Mhvm1ExI8oq
 jY+3WwXgVRhzQqEFvLZQtcxlxCkf43oQVIT0/cS0=
Date: Fri, 31 Jan 2020 14:59:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 02/25] hw/iommu: introduce DualStageIOMMUObject
Message-ID: <20200131035914.GF15210@umbus.fritz.box>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-3-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline
In-Reply-To: <1580300216-86172-3-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com,
 yi.y.sun@intel.com, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 04:16:33AM -0800, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
>=20
> Currently, many platform vendors provide the capability of dual stage
> DMA address translation in hardware. For example, nested translation
> on Intel VT-d scalable mode, nested stage translation on ARM SMMUv3,
> and etc. In dual stage DMA address translation, there are two stages
> address translation, stage-1 (a.k.a first-level) and stage-2 (a.k.a
> second-level) translation structures. Stage-1 translation results are
> also subjected to stage-2 translation structures. Take vSVA (Virtual
> Shared Virtual Addressing) as an example, guest IOMMU driver owns
> stage-1 translation structures (covers GVA->GPA translation), and host
> IOMMU driver owns stage-2 translation structures (covers GPA->HPA
> translation). VMM is responsible to bind stage-1 translation structures
> to host, thus hardware could achieve GVA->GPA and then GPA->HPA
> translation. For more background on SVA, refer the below links.
>  - https://www.youtube.com/watch?v=3DKq_nfGK5MwQ
>  - https://events19.lfasiallc.com/wp-content/uploads/2017/11/\
> Shared-Virtual-Memory-in-KVM_Yi-Liu.pdf
>=20
> As above, dual stage DMA translation offers two stage address mappings,
> which could have better DMA address translation support for passthru
> devices. This is also what vIOMMU developers are doing so far. Efforts
> includes vSVA enabling from Yi Liu and SMMUv3 Nested Stage Setup from
> Eric Auger.
> https://www.spinics.net/lists/kvm/msg198556.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg02842.html
>=20
> Both efforts are aiming to expose a vIOMMU with dual stage hardware
> backed. As so, QEMU needs to have an explicit object to stand for
> the dual stage capability from hardware. Such object offers abstract
> for the dual stage DMA translation related operations, like:
>=20
>  1) PASID allocation (allow host to intercept in PASID allocation)
>  2) bind stage-1 translation structures to host
>  3) propagate stage-1 cache invalidation to host
>  4) DMA address translation fault (I/O page fault) servicing etc.
>=20
> This patch introduces DualStageIOMMUObject to stand for the hardware
> dual stage DMA translation capability. PASID allocation/free are the
> first operation included in it, in future, there will be more operations
> like bind_stage1_pgtbl and invalidate_stage1_cache and etc.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

Several overall queries about this:

1) Since it's explicitly handling PASIDs, this seems a lot more
   specific to SVM than the name suggests.  I'd suggest a rename.

2) Why are you hand rolling structures of pointers, rather than making
   this a QOM class or interface and putting those things into methods?

3) It's not really clear to me if this is for the case where both
   stages of translation are visible to the guest, or only one of
   them.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4zphIACgkQbDjKyiDZ
s5IQYg/+LAuO22iNHumMZpGs30DHJ8l/gPm+BizzzE4S4QHRwO5Pe8etzEUWfcRw
ZlVfNTPtgKLOmgfJFk3kZt53UCuogwq4bodiNhTZ6ykCuq5LlADFMVhiaUJoUr8l
vfcOfD7QhQw0zCG8vPoMh+hn1eBd6KfcoyW9TW8vK0/OzNBYhj8mg0vVcjrDOSQS
Lzs/x8Pl8gnppwxgKqYBP8PATVeMOgnFPEfUaejvxW6/Dqg0Bwe55KF4ze/flAyA
PQbdHeX/c/9tGjqjJ2bVDTGylgCyFIIqaXgdSR3xUniSWf7ttwRM9b7VJrHT86wQ
D9NXjKIHQnhbgYOnsz3iI809oX3JFo8DKj2WvCvwWtLZO+ZyG1qR/SOEQZlGCe1S
w5ItoN1T5Bdq21OVDifi3iVsr20RJsMgwzwbG3YJu2jW9w3iH7tvjAsjT4sVuS62
YvhonQBiLpKr0FJsic9bgbTVnDDfQE9Nsm/cfnXrKIp505ELTFhl7BpLeit3TyCy
PNqf2r0ICn5ZoxsZ1sK2MbBAm8K+rYKXmINk3R4vBfw8Cve1K5HZZWpoCqkCF1tb
CUcwU/3B1Nem2hOGfI7JJIDXOf2BQuKnLVrTKuPOSO+ibYGWQO+BGmgoTG7ofZcf
gfkkOAWSvkaOHu1w2GM/DudhRC/rRPdOcEPldvhE9V8dVn8c8HU=
=YSYx
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--

