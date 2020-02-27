Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8502FC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F841222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Np6K4+wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F841222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7F8u-0003DM-Fh
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j7F8A-0002HE-Mh
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j7F89-0005OG-ER
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:06:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49689
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j7F89-0005NL-AM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582794412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xil23CEiYqcuHbjZLErJNYGNGhWhgL0pU2jLZrD0SF8=;
 b=Np6K4+wxLHcZyX3cC0KmfKe6kJKLppEJDpznvy8NXbqpt5EYL9bBNVd0PE5DmiVVOtyyTb
 vmEOMYzZ5xWdvG1ka7jy46QH3ttNHVDVLgHskzxtRar5picrB4Bws3IS5Ojt8PZ2yp8rDK
 Oy8jrUAPoi3HfR3guhX/mRny2VbGgg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-TPeFQKw0MBSQQkIsbaxY-w-1; Thu, 27 Feb 2020 04:06:48 -0500
X-MC-Unique: TPeFQKw0MBSQQkIsbaxY-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DC7B19251A1;
 Thu, 27 Feb 2020 09:06:47 +0000 (UTC)
Received: from gondolin (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C36325D9CD;
 Thu, 27 Feb 2020 09:06:43 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:06:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 01/18] s390x: Use constant for ESA PSW address
Message-ID: <20200227100632.5292d773.cohuck@redhat.com>
In-Reply-To: <12970780-c4bd-dee3-280d-efcc15d6f162@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-2-frankja@linux.ibm.com>
 <3d6f7f88-0a77-90f0-4e26-ee826593d55f@redhat.com>
 <20200226185118.316055d5.cohuck@redhat.com>
 <7d9a3dcb-29c5-724c-70d8-9c7559ae6d64@linux.ibm.com>
 <12970780-c4bd-dee3-280d-efcc15d6f162@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/Mpw321Pe22u2205Y=WbZhMG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Mpw321Pe22u2205Y=WbZhMG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Feb 2020 09:09:47 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 2/27/20 8:53 AM, Janosch Frank wrote:
> > On 2/26/20 6:51 PM, Cornelia Huck wrote: =20
> >> On Wed, 26 Feb 2020 15:27:52 +0100
> >> David Hildenbrand <david@redhat.com> wrote:
> >> =20
> >>> On 26.02.20 13:20, Janosch Frank wrote: =20
> >>>> Lets make it a bit more clear that we're extracting the 31 bit addre=
ss =20
> >>
> >> s/Lets/Let's/ :) =20
> >=20
> > Ack
> >  =20
> >> =20
> >>>> from the short psw.
> >>>>
> >>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >>>> ---
> >>>>  hw/s390x/ipl.c     | 2 +-
> >>>>  target/s390x/cpu.c | 4 ++--
> >>>>  target/s390x/cpu.h | 1 +
> >>>>  3 files changed, 4 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> >>>> index 7773499d7f..42e21e7a6a 100644
> >>>> --- a/hw/s390x/ipl.c
> >>>> +++ b/hw/s390x/ipl.c
> >>>> @@ -179,7 +179,7 @@ static void s390_ipl_realize(DeviceState *dev, E=
rror **errp)
> >>>>                  /* if not Linux load the address of the (short) IPL=
 PSW */
> >>>>                  ipl_psw =3D rom_ptr(4, 4);
> >>>>                  if (ipl_psw) {
> >>>> -                    pentry =3D be32_to_cpu(*ipl_psw) & 0x7fffffffUL=
;
> >>>> +                    pentry =3D be32_to_cpu(*ipl_psw) & PSW_MASK_ESA=
_ADDR;
> >>>>                  } else {
> >>>>                      error_setg(&err, "Could not get IPL PSW");
> >>>>                      goto error;
> >>>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> >>>> index 8da1905485..43360912a0 100644
> >>>> --- a/target/s390x/cpu.c
> >>>> +++ b/target/s390x/cpu.c
> >>>> @@ -78,13 +78,13 @@ static void s390_cpu_load_normal(CPUState *s)
> >>>>      S390CPU *cpu =3D S390_CPU(s);
> >>>>      uint64_t spsw =3D ldq_phys(s->as, 0);
> >>>> =20
> >>>> -    cpu->env.psw.mask =3D spsw & 0xffffffff80000000ULL;
> >>>> +    cpu->env.psw.mask =3D spsw & PSW_MASK_ESA_MASK;
> >>>>      /*
> >>>>       * Invert short psw indication, so SIE will report a specificat=
ion
> >>>>       * exception if it was not set.
> >>>>       */
> >>>>      cpu->env.psw.mask ^=3D PSW_MASK_SHORTPSW;
> >>>> -    cpu->env.psw.addr =3D spsw & 0x7fffffffULL;
> >>>> +    cpu->env.psw.addr =3D spsw & PSW_MASK_ESA_ADDR;
> >>>> =20
> >>>>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> >>>>  }
> >>>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> >>>> index 8a557fd8d1..74e66fe0c2 100644
> >>>> --- a/target/s390x/cpu.h
> >>>> +++ b/target/s390x/cpu.h
> >>>> @@ -277,6 +277,7 @@ extern const VMStateDescription vmstate_s390_cpu=
;
> >>>>  #define PSW_MASK_64             0x0000000100000000ULL
> >>>>  #define PSW_MASK_32             0x0000000080000000ULL
> >>>>  #define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
> >>>> +#define PSW_MASK_ESA_MASK       0xffffffff80000000ULL   =20
> >>>
> >>> ..._MASK_..._MASK
> >>>
> >>> Isn't there a better name for all the bits in the PSW that are not an
> >>> address?
> >>>
> >>> PSW_MASK_ESA_BITS
> >>> PSW_MASK_ESA_FLAGS
> >>> ... =20
> >>
> >> Hm, the PoP says that the PSW "includes the instruction address,
> >> condition code, and other control fields"; it also talks about the
> >> 'short' PSW as being distinct from the 'ESA' PSW (bit 31 may be 0 or 1
> >> in the short PSW). Maybe
> >>
> >> PSW_MASK_SHORT_ADDR
> >> PSW_MASK_SHORT_CTRL =20
> >=20
> > Sure, why not
> >  =20
> >>
> >> (Or keep _ESA_ if renaming creates too much churn.)
> >> =20
> >>> =20
> >>>> =20
> >>>>  #undef PSW_ASC_PRIMARY
> >>>>  #undef PSW_ASC_ACCREG
> >>>>    =20
> >>>
> >>> =20
> >>
> >> This patch is also independent of the protected virtualization
> >> support... I plan to send a pull request tomorrow, so I can include
> >> this patch, if we agree on a name for the constant :) =20
> >=20
> > Well, you would also need to rename all users of PSW_MASK_ESA_ADDR
> > Let me split that up into two patches, the rename for the ADDR and this
> > one. I'll send it out once I'm more or less awake. =20
>=20
> Seems like the ADDR constant has never been used anyway...
> Ok, I renounce everything I said before, if you want to fix this up
> yourself that would be wonderful, if not I'd be happy to provide you
> with a patch.

A quick respin of this patch would be easiest for me.

--Sig_/Mpw321Pe22u2205Y=WbZhMG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5XhpgACgkQ3s9rk8bw
L6/5rBAArCxdHOtyyUnP6cvugyUuRDGOhPm7/PPoRZf1RnAEbMjIOfZ5qBCwJUk9
YWyASvnp08ZkrxcpyK4klTRgMajJEz3SuInmkSFlDAJ8taZdaoiliGjMb2h6ra2W
vDiccF92ho5kQISYyY/eD1iJpAmqsGorOWSY6aExgdA5thY78ePx4pQBboQN/Qdt
CzXBeEWmOQUUdOlhJCP1olPzm8qIH/33TMojdRD3XSvzyJ3/NZFTdPQKKpEAtqqT
USyC75zNTnJXeY0bQQ6zl9qjB1XF89P7BRyAwKPF4nXygZ2dknw8hcgLR8WN9Lt5
Luw2ftWqiF60yzaBjJD1P8M/tKKkAOUKRAVjhVTNUBNM5Z0QRJAb7yrrem4Np4LA
RiolFxkvAjAq0ltDdxbwuZPdYuLJj0Mg+WXXRqeJNtWTKPwfi7RAvdxQZOL3P201
TxCzy9wENb16pVIz6NiCxzWkatvy4YuBEz7MlXCQuYPFcB1R9JgwpVgM8HX09Vz6
wIGuSLMuUc3zZouEPmaaT1kJyY0AvDcnh4kwr72g1ucLtNQPsjQfENaAtstmNwvk
Cp77R1g5xI6G7whTv64+OXwbLV0/MbXMpuvo25KeLYqGsTh0vKpXFDxRaqHgBYkV
eoPKMhY7kLl4EDMvbGwFXEEUSx9exQW2POoY99DymmvbjEocIwY=
=o0TT
-----END PGP SIGNATURE-----

--Sig_/Mpw321Pe22u2205Y=WbZhMG--


