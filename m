Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922BCC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A12B206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Bf6J+Fdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A12B206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqugW-0003LZ-NJ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 03:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38421)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufj-0000jo-4s
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufd-0005OW-If
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42833 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hqufb-00055E-7s
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45w11J3h8Bz9sMQ; Fri, 26 Jul 2019 17:29:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564126164;
 bh=JUajiAa7S0x82VcrOnFR99fgStWmrqETSqVlkjY5W3o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bf6J+Fdn+egiGe4vfDRdgA0vtDmBPXk6Be427QaWwIv9CIT6nZR8YVDGVNpSHL1qF
 ZPqY+YPBJwIAlJ5Lw9Nq5KQqTSgoMHC6kgXUxMPlW9w4sGE4VrL1Rqc5S56fYy7Z6N
 1EjV8krXF2srwROE9Gic0xEFOesOMhSlqViqj2ro=
Date: Thu, 25 Jul 2019 13:40:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190725034017.GF28601@umbus>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
 <20190715025519.GE3440@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A00D8BB@SHSMSX104.ccr.corp.intel.com>
 <20190717030640.GG9123@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A0140E0@SHSMSX104.ccr.corp.intel.com>
 <20190723035741.GR25073@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A0160C9@SHSMSX104.ccr.corp.intel.com>
 <abf336b6-4c51-7742-44aa-5b51c8ea4af7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Content-Disposition: inline
In-Reply-To: <abf336b6-4c51-7742-44aa-5b51c8ea4af7@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [RFC v1 05/18] vfio/pci: add pasid alloc/free
 implementation
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 11:33:06AM +0200, Auger Eric wrote:
> Hi Yi, David,
>=20
> On 7/24/19 6:57 AM, Liu, Yi L wrote:
> >> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On =
Behalf
> >> Of David Gibson
> >> Sent: Tuesday, July 23, 2019 11:58 AM
> >> To: Liu, Yi L <yi.l.liu@intel.com>
> >> Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementat=
ion
> >>
> >> On Mon, Jul 22, 2019 at 07:02:51AM +0000, Liu, Yi L wrote:
> >>>> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
> >>>> On Behalf Of David Gibson
> >>>> Sent: Wednesday, July 17, 2019 11:07 AM
> >>>> To: Liu, Yi L <yi.l.liu@intel.com>
> >>>> Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free
> >>>> implementation
> >>>>
> >>>> On Tue, Jul 16, 2019 at 10:25:55AM +0000, Liu, Yi L wrote:
> >>>>>> From: kvm-owner@vger.kernel.org
> >>>>>> [mailto:kvm-owner@vger.kernel.org] On
> >>>> Behalf
> >>>>>> Of David Gibson
> >>>>>> Sent: Monday, July 15, 2019 10:55 AM
> >>>>>> To: Liu, Yi L <yi.l.liu@intel.com>
> >>>>>> Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free
> >>>>>> implementation
> >>>>>>
> >>>>>> On Fri, Jul 05, 2019 at 07:01:38PM +0800, Liu Yi L wrote:
> >>>>>>> This patch adds vfio implementation PCIPASIDOps.alloc_pasid/free_=
pasid().
> >>>>>>> These two functions are used to propagate guest pasid
> >>>>>>> allocation and free requests to host via vfio container ioctl.
> >>>>>>
> >>>>>> As I said in an earlier comment, I think doing this on the
> >>>>>> device is conceptually incorrect.  I think we need an explcit
> >>>>>> notion of an SVM context (i.e. the namespace in which all the
> >>>>>> PASIDs live) - which will IIUC usually be shared amongst
> >>>>>> multiple devices.  The create and free PASID requests should be on=
 that object.
> >>>>>
> >>>>> Actually, the allocation is not doing on this device. System wide,
> >>>>> it is done on a container. So not sure if it is the API interface
> >>>>> gives you a sense that this is done on device.
> >>>>
> >>>> Sorry, I should have been clearer.  I can see that at the VFIO level
> >>>> it is done on the container.  However the function here takes a bus
> >>>> and devfn, so this qemu internal interface is per-device, which
> >>>> doesn't really make sense.
> >>>
> >>> Got it. The reason here is to pass the bus and devfn info, so that
> >>> VFIO can figure out a container for the operation. So far in QEMU,
> >>> there is no good way to connect the vIOMMU emulator and VFIO regards
> >>> to SVM.
> >>
> >> Right, and I think that's an indication that we're not modelling somet=
hing in qemu
> >> that we should be.
> >>
> >>> hw/pci layer is a choice based on some previous discussion. But yes, I
> >>> agree with you that we may need to have an explicit notion for SVM. Do
> >>> you think it is good to introduce a new abstract layer for SVM (may
> >>> name as SVMContext).
> >>
> >> I think so, yes.
> >>
> >> If nothing else, I expect we'll need this concept if we ever want to b=
e able to
> >> implement SVM for emulated devices (which could be useful for debuggin=
g, even if
> >> it's not something you'd do in production).
> >>
> >>> The idea would be that vIOMMU maintain the SVMContext instances and
> >>> expose explicit interface for VFIO to get it. Then VFIO register
> >>> notifiers on to the SVMContext. When vIOMMU emulator wants to do PASID
> >>> alloc/free, it fires the corresponding notifier. After call into VFIO,
> >>> the notifier function itself figure out the container it is bound. In
> >>> this way, it's the duty of vIOMMU emulator to figure out a proper
> >>> notifier to fire. From interface point of view, it is no longer
> >>> per-device.
> >>
> >> Exactly.
> >=20
> > Cool, let me prepare another version with the ideas. Thanks for your
> > review. :-)
> >=20
> > Regards,
> > Yi Liu
> >=20
> >>> Also, it leaves the PASID management details to vIOMMU emulator as it
> >>> can be vendor specific. Does it make sense?
> >>> Also, I'd like to know if you have any other idea on it. That would
> >>> surely be helpful. :-)
> >>>
> >>>>> Also, curious on the SVM context
> >>>>> concept, do you mean it a per-VM context or a per-SVM usage context?
> >>>>> May you elaborate a little more. :-)
> >>>>
> >>>> Sorry, I'm struggling to find a good term for this.  By "context" I
> >>>> mean a namespace containing a bunch of PASID address spaces, those
> >>>> PASIDs are then visible to some group of devices.
> >>>
> >>> I see. May be the SVMContext instance above can include multiple PASID
> >>> address spaces. And again, I think this relationship should be
> >>> maintained in vIOMMU emulator.
> >=20
> So if I understand we now head towards introducing new notifiers taking
> a "SVMContext" as argument instead of an IOMMUMemoryRegion.
>=20
> I think we need to be clear about how both abstractions (SVMContext and
> IOMMUMemoryRegion) differ. I would also need "SVMContext" abstraction
> for 2stage SMMU integration (to notify stage 1 config changes and MSI
> bindings) so I would need this new object to be not too much tied to SVM
> use case.

That's my suggestion.  I don't really have any authority to decide..

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl05JKEACgkQbDjKyiDZ
s5IkYhAAoznqVKTCH97gCdU8czSGIHARTNoEIR17+nghgcI4+g4aRuRNrPAblwUy
6etxeHBmTwINL00BUmohJAFEoKdtTfWl72JAhI/uBZkj4OCpCVsTzXvIRR5LTs3u
EGyXJoCCBvMujEludyperNNprI5Nrw/CsUKdsqtf/yH4hlwsi+9jV5ZmIijVzWCn
KacveNOmSye4VCXUL/6urXa5JAqq/OOwUpBXLstMrunndayl9zfA311MyBH4U2hn
jmRq3v7HbFadt7W7mXd4dlqF0uiwWZhSKZkTDXB06VYZ6hRx6hSFDXzTIEMUHdso
/1AaeEE47y6vI7vdKuv5Eew4fKVU7pN3YbPuRv9cJ/P+z+GF921ez/RCTR6LV1Fl
guC9ZzaRRCG/V3F+MNP5ZpFcp/hIsN7t/FdBhG3LZD3r/x6GtRtf3i+xQIDH7emn
ZJMwBK5PuX9N4ixy6zgDefqONthiUHDxoq057TTRBtvDiQCtXpwTLjN53HKTuDeX
SL4ZIV++E700dWCMh7Xa3n40KLIJ0dqqBL8ogXg+7hsl00rjMy3h6zsSkccyKrRy
F0g49hmPI9whC1xg2MgzJKNO27cXapvsHtSCb/387AxCp3N0Y9QCtkYDFkkHD4UY
V9pxNBTML7/v+gDbvQIiYcagJt5B/z0ODidLuch2eqhxF15/FoU=
=G3BS
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--

