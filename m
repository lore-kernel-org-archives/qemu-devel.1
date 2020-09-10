Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD262C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 23:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870622076D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 23:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MUIwa4jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870622076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGWL7-0001SA-Ki
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 19:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kGWJa-0008Ux-VA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 19:49:18 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42507 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kGWJY-0004oF-0h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 19:49:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BnbFd51crz9sTH; Fri, 11 Sep 2020 09:49:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599781749;
 bh=CwosWA/BB/OFrbCWXMJTkh+p4v/xbqwBf8+vRc4xL+E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MUIwa4jf3XtjetRSlTK6zAE8NbkUjC4dFbk8IIagLDgolYU5t5xMafksjodEqhWdB
 f0NbjiYWOqNQdNbxHRfrfTrQ3T1J8gqRQQOqTR8EggfYlih/n1tw2LLLnD2DlaIftg
 cQ94t6DsDXg7CUVn9DEVEN89+yih2yiVRf181HzU=
Date: Fri, 11 Sep 2020 09:42:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
Message-ID: <20200910234209.GE66834@yekko.fritz.box>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <cefca93c-37d5-63b7-aff3-e6966d771892@redhat.com>
 <BY5PR02MB6772B6F211489F7E2A9D5CCDCA290@BY5PR02MB6772.namprd02.prod.outlook.com>
 <2330f661-2ef0-cfb5-4a05-8a2d43ab53e4@redhat.com>
 <79ff4a95-d276-6681-6a06-9b8dc66de93f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <79ff4a95-d276-6681-6a06-9b8dc66de93f@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?'Marc-Andr=E9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 12:34:59PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/8/20 12:30 PM, Philippe Mathieu-Daud=E9 wrote:
> >>> On 8/28/20 9:19 PM, Sai Pavan Boddu wrote:
> >>>> This patch starts making the hcd-xhci.c pci free, as part of this
> >>>> restructuring dma read/writes are handled without passing pci object.
> >>>>
> >>>> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> >>>> ---
> >>>>  hw/usb/hcd-xhci.c | 24 +++++++++++-------------  hw/usb/hcd-xhci.h |
> >>>> 3 +++
> >>>>  2 files changed, 14 insertions(+), 13 deletions(-)
> >>>>
> > [...]
> >>>> --- a/hw/usb/hcd-xhci.h
> >>>> +++ b/hw/usb/hcd-xhci.h
> >>>> @@ -22,6 +22,8 @@
> >>>>  #ifndef HW_USB_HCD_XHCI_H
> >>>>  #define HW_USB_HCD_XHCI_H
> >>>>
> >>>> +#include "sysemu/dma.h"
> >>>
> >>> AddressSpace is forward-declared in "qemu/typedefs.h", so no need to
> >>> include it here (yes in the sources including hcd-xhci.h).
> >> [Sai Pavan Boddu] Yes you are right!, but without this " dma_addr_t " =
is undefined.=20
> >> At this point of the patch, hcd-xhci.h is compiled along with pci.h wh=
ich would provide 'dma_addr_t', but when we strip the pci wrapper around hc=
d-xhci we would miss it. Let me know, if its good to add later in the patch=
 series when the split happens.
> >=20
> > OK :( I'd prefer to only include "sysemu/dma.h" in hw/usb/hcd-xhci.c.
> >=20
> > Cc'ing David who added dma_addr_t in commit e5332e6334f
> > ("iommu: Introduce IOMMU emulation infrastructure"), it
> > might be simpler to move its declaration to "qemu/typedefs.h"
> > too.
>=20
> Btw this type should be poisoned for user-mode.

Yes, yes it should.


>=20
> >=20
> > So no change needed for this patch.
> >=20
> >>
> >> Regards,
> >> Sai Pavan
> >>>
> >>> With that fixed:
> >>> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >>>
> >>>> +
> >>>>  #define TYPE_XHCI "base-xhci"
> >>>>  #define TYPE_NEC_XHCI "nec-usb-xhci"
> >>>>  #define TYPE_QEMU_XHCI "qemu-xhci"
> >>>> @@ -189,6 +191,7 @@ struct XHCIState {
> >>>>
> >>>>      USBBus bus;
> >>>>      MemoryRegion mem;
> >>>> +    AddressSpace *as;
> >>>>      MemoryRegion mem_cap;
> >>>>      MemoryRegion mem_oper;
> >>>>      MemoryRegion mem_runtime;
> >>>>
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9audEACgkQbDjKyiDZ
s5Jd7Q//YFMKBtr+CZD56fwoGe4C8fsKB9/g4Q8FKklrudttQp3oETjp/m++DmPn
Ur1Y98+nBxzAxLURUyzc3vzkLZVLSBQdhtdTRESJ9XOhnbAzI/zi4LQRbOgcEpHu
eMmLnGHDywgBkAPZp4CIYl1p4/ptQVtogpKYwyvKO8rPE3DuRu4g64bclbwrpSGX
4TvNF/veTIX8cJaeJcMNY4gHWDcs650oWxL40T89QFE/qH7zJ3WS4jYX19n/lSOl
90fuEA8zm3X7hW5Y92YWoyCVxhUJMzFL0F5Dxb9UCDuaFO7igPunOrjmIpim/0rR
AwbW8C2O8wcH0bEjjD3oJY4PrkUrLId7PYwx/O6YUNyuhOMU9Xi5EGja51PvQF0T
29e6dWcn3Kp7F/It0HqFiM7HVilE0IuEGdQyT9EytpYSTWX/ucEia8jqbTA6DVkS
xLewglll9bPOLwffqcDJNuzJ9kkT9O4UJXV9Cvvp0lU69T7MQ5Rr5EJfjRctywlX
q0vdBp18EaQwO7IzakUQRBJGRU1BhyVGsJfRwoSgdOAH7T/SGw/ye/sVgBLvAG8R
4EjGlJnhK8D7rUMEISY/6ew+EFdlA18bwNJel2GSuEsU3jxhvo94dNsfzVRiWAOj
LxBiBDF+vSW6W/EKTWUY0/zxfv0RyFyJnFCgrnVvQ669TrQI5/k=
=vGqu
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--

