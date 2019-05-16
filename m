Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA61C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156BC20657
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKxGdn4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156BC20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRKlM-0006Pf-2V
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 14:05:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hRKjv-0005uH-GZ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hRKjt-00082X-Jy
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:04:23 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hRKjt-00082D-Ct
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:04:21 -0400
Received: by mail-ot1-x343.google.com with SMTP id c3so4309331otr.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=QdUn6KoAwD3SVbEJA9gXg7LKYzXbZUyAIBD/LJr3U9w=;
	b=TKxGdn4cyVt5boxfWlqdXv3zSqqwxV0U1jPIS+3360OWTJFGlTiWN7Bi/1A1muCFLE
	QhkGr/57ZiXed1JxIfol1Od6tG++G59y0DbycKJu09TRLjBsT1QeTmKfNQz9szP+FQZU
	Yr90fvErOGYygI/r+wQa58QRUa3XnDipD9Bw+cQDGzfsu4spgO+stWx5SEedAXM8fBUs
	Ui1LbEYcqrZ8i4m8VSVPyV10O04nQrspVn4VYuonGXi6kfhpFpSTwPbejoGMSRGyq+p6
	H1mOPDpcKyy4np5S0tkFXBSf9G4wQPP3G7hSZlF/lFxtYfd5F137ImMgM2Yt6pNbJWEX
	Cufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=QdUn6KoAwD3SVbEJA9gXg7LKYzXbZUyAIBD/LJr3U9w=;
	b=r9BgcMfw7gjc/pfg+nn2AP6UyE9WDrdZXMKuOFnDX768DvlCng0KY+0tGb/Uu1Kue0
	rb4vqroP6OXTHI4BiaN9drqrLRd0g58EreJThNVv3UQiO8p6Cweh9bnCQlwoPxmsnaeO
	RzyJuuoqffHI/EjqhIHgnNBwLyNhCRNiv440CrunYYvOWoX/IXcOJvbd6S1836paW1YT
	hBU4aath/eTGd5vWW/EccDPZd+tLhigcBDcf3bSND5mFVMlxNn4L3/odZlIzMWlrBcBP
	zo5YJGtXVMd3Dl1Mwz8s8bzdieXWeo0Sh08ewSdKXCJKvUjlPtXDgNoDpBYdkbtd/Bit
	mLIA==
X-Gm-Message-State: APjAAAU+U1262sjjRxEb3UChcyK5zJZJaIKRBrnKWZlzB2QWMZ5l8kYe
	taBScUdUVD8Eb8AJimm7rThiZdaYqmZBb40AAFA=
X-Google-Smtp-Source: APXvYqxxTDm60/ekzVm4CPfFJA2W3u2E12mO2ggLP2qsLvxP19Drqh4PrYCk//BBhnG5unYf1nAszVyC03Qr53A1xyU=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr30692otm.64.1558029860540;
	Thu, 16 May 2019 11:04:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Thu, 16 May 2019 11:04:19
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Thu, 16 May 2019 11:04:19
	-0700 (PDT)
In-Reply-To: <f9f1b930-2381-b343-854f-70e2590c9b73@redhat.com>
References: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
	<ab4b6d04-74f9-2f12-829d-9df8c1b1c4ca@redhat.com>
	<6ae8d347-149d-e7eb-bb02-90aba44c5bbd@kernkonzept.com>
	<1e9a8595-4653-4900-b747-236f9888b893@kernkonzept.com>
	<04a4fcca-0db9-46f8-ac41-0d770b0dc5d6@kernkonzept.com>
	<f9f1b930-2381-b343-854f-70e2590c9b73@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 16 May 2019 20:04:19 +0200
Message-ID: <CAL1e-=jFH7+cHGUJsmUKpEAkwohagfM5WVb4-rGSozsEkzFrTA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] mips: Decide to map PAGE_EXEC in
 map_address
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Jakub Jermar <jakub.jermar@kernkonzept.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 16, 2019 6:31 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =
wrote:
>
> Hi Jakub,
>
> On 5/16/19 3:10 PM, Jakub Jermar wrote:
> > Hi,
> >
> > On 5/3/19 12:02 PM, Jakub Jermar wrote:
> >> Hi,
> >>
> >> On 4/23/19 4:58 PM, Jakub Jermar wrote:
> >>> Hi Philippe!
> >>>
> >>> On 4/23/19 3:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>> Hi Jakub,
> >>>>
> >>>> On 4/23/19 1:00 PM, Jakub Jerm=C3=A1=C5=99 wrote:
> >>>>> This commit addresses QEMU Bug #1825311:
> >>>>>
> >>>>>   mips_cpu_handle_mmu_fault renders all accessed pages executable
> >>>>>
> >>>>> It allows finer-grained control over whether the accessed page
should be
> >>>>> executable by moving the decision to the underlying map_address
> >>>>> function, which has more information for this.
> >>>>>
> >>>>> As a result, pages that have the XI bit set in the TLB and are
accessed
> >>>>> for read/write, don't suddenly end up being executable.
> >>>>>
> >>>>
> >>>> Fixes: https://bugs.launchpad.net/qemu/+bug/1825311
> >>>>
> >>>>> Signed-off-by: Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.com=
>
> >>>>> ---
> >>>>>  target/mips/helper.c | 17 ++++++++++-------
> >>>>>  1 file changed, 10 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/target/mips/helper.c b/target/mips/helper.c
> >>>>> index c44cdca3b5..132d073fbe 100644
> >>>>> --- a/target/mips/helper.c
> >>>>> +++ b/target/mips/helper.c
> >>>>> @@ -43,7 +43,7 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr
*physical, int *prot,
> >>>>>                          target_ulong address, int rw, int
access_type)
> >>>>>  {
> >>>>>      *physical =3D address;
> >>>>> -    *prot =3D PAGE_READ | PAGE_WRITE;
> >>>>> +    *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >>>>>      return TLBRET_MATCH;
> >>>>>  }
> >>>>>
> >>>>> @@ -61,7 +61,7 @@ int fixed_mmu_map_address (CPUMIPSState *env,
hwaddr *physical, int *prot,
> >>>>>      else
> >>>>>          *physical =3D address;
> >>>>>
> >>>>> -    *prot =3D PAGE_READ | PAGE_WRITE;
> >>>>> +    *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >>>>>      return TLBRET_MATCH;
> >>>>>  }
> >>>>>
> >>>>> @@ -101,6 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr
*physical, int *prot,
> >>>>>                  *prot =3D PAGE_READ;
> >>>>>                  if (n ? tlb->D1 : tlb->D0)
> >>>>>                      *prot |=3D PAGE_WRITE;
> >>>>> +                if (!(n ? tlb->XI1 : tlb->XI0)) {
> >>>>> +                    *prot |=3D PAGE_EXEC;
> >>>>> +                }
> >>>>
> >>>> This was indeed missed in commit 2fb58b73746e.
>
> Aleksandar, if this patch is OK with you, can you amend this comment,
> and add the "Fixes:" tag too when applying? Thanks!

Yes, definitely, Philippe, that is not a problem.

Thanks for helping out!

I tested Jakub's scenario too, it works as expected, but I am not concerned
about it as much as about regression tests. Knowing that you have many MIPS
test kernels and images, may I ask you to test some of them WITH Jakub's
fix (so indepenently of myself anf Jakub), just to confirm that there are
no regressions?

C=E2=80=99est vraiment gentil de votre part.

Aleksandar

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> >>>>
> >>>>>                  return TLBRET_MATCH;
> >>>>>              }
> >>>>>              return TLBRET_DIRTY;
> >>>>> @@ -182,7 +185,7 @@ static int
get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
> >>>>>      } else {
> >>>>>          /* The segment is unmapped */
> >>>>>          *physical =3D physical_base | (real_address & segmask);
> >>>>> -        *prot =3D PAGE_READ | PAGE_WRITE;
> >>>>> +        *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >>>>>          return TLBRET_MATCH;
> >>>>>      }
> >>>>>  }
> >>>>> @@ -913,8 +916,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs,
vaddr address, int size, int rw,
> >>>>>      }
> >>>>>      if (ret =3D=3D TLBRET_MATCH) {
> >>>>>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
> >>>>> -                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC=
,
> >>>>> -                     mmu_idx, TARGET_PAGE_SIZE);
> >>>>> +                     physical & TARGET_PAGE_MASK, prot, mmu_idx,
> >>>>> +                     TARGET_PAGE_SIZE);
> >>>>>          ret =3D 0;
> >>>>>      } else if (ret < 0)
> >>>>>  #endif
> >>>>> @@ -936,8 +939,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs,
vaddr address, int size, int rw,
> >>>>>                                             address, rw,
access_type, mmu_idx);
> >>>>>                  if (ret =3D=3D TLBRET_MATCH) {
> >>>>>                      tlb_set_page(cs, address & TARGET_PAGE_MASK,
> >>>>> -                            physical & TARGET_PAGE_MASK, prot |
PAGE_EXEC,
> >>>>> -                            mmu_idx, TARGET_PAGE_SIZE);
> >>>>> +                            physical & TARGET_PAGE_MASK, prot,
mmu_idx,
> >>>>> +                            TARGET_PAGE_SIZE);
> >>>>>                      ret =3D 0;
> >>>>>                      return ret;
> >>>>>                  }
> >>>>>
> >>>>
> >>>> Your patch looks correct, but I'd like to test it.
> >>>> Do you have a reproducer?
> >>>> Can you describe the command line you used?
> >>>
> >>> I've just attached a reproducer image and script to the bug. It's a
> >>> 32-bit little-endian test binary running on top of the L4Re
microkernel.
>
> I can't get the "TAP" output you described on launchpad.
>
> >>> Let me know if you also need a 64-bit version.
>
> 64-bit version is welcomed.
>
> >>> I tested both 32 and 64-bit versions of the reproducer and also
checked
> >>> to see that the the other images I have lying around here (Linux
2.6.32
> >>> big endian and HelenOS master little-endian, both 32-bit for 4Kc)
> >>> continue to run without regressions.
>
> Yes, definitively an improvement:
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Regards,
>
> Phil.
>
