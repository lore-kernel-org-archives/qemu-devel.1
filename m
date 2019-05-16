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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72654C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 21:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244C220818
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 21:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvXdEj0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244C220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37203 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRO2J-0003wb-95
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 17:35:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hRO1S-0003Yi-RF
	for qemu-devel@nongnu.org; Thu, 16 May 2019 17:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hRO1Q-00009h-QO
	for qemu-devel@nongnu.org; Thu, 16 May 2019 17:34:42 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hRO1Q-000082-Fb
	for qemu-devel@nongnu.org; Thu, 16 May 2019 17:34:40 -0400
Received: by mail-ot1-x341.google.com with SMTP id r7so4863524otn.6
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=rXA7RVdAkHyGcbNhZAEMFtEPYod8BM/nnokuw45LQag=;
	b=fvXdEj0WuqRXPf7KOMHykVC42BMMECZGQbuxSDcOvwiYITciD92U79Ez6ldDVyiFDv
	DdySp9lfqN2DTfyDwYryEL2ThaaszXTYpdQlRRROcTt5dyODOq+tFoLu6D5y86fCHpmk
	7KtmB39ljD1YQ6La4+k9IDnkYoyfWGDxUQuBE1Gg9SN+WVH49ZTTDdiGtKc5GuXNoikg
	rnZGwZuhYfnmy2xe5qBmFC0txtSSoa1U+w1duRu0aPH/LFyqJD7ZeZuLy5fUC2n/ftZW
	yhgkDiYNXJHhOK4PefHhWGs4rf2Qeedpi2E4yCVEkGlNVkGKsagaowdPomi61p1IJJS0
	YHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=rXA7RVdAkHyGcbNhZAEMFtEPYod8BM/nnokuw45LQag=;
	b=MptrRpTbI9uYrjN0x+I6QHduuL2uY/vRgQmqWuc//O/RwLga77B6zNiH42bakhXvLo
	kHPJkXM1NHLsj8tYvjwsB7aZLPLyn8CmQ4Xp4/t3fdJVBRh49SlPrwD9u9h8gyX1sSSf
	pOQvB4UfM/0BS772ttPxqmYZdRNe6GkjZIM4mEG9nB2ipRt1Il3Smw2KRbPFh+UCWWbK
	StpDoIFdG9RCCcUmFUwg5NMyiZ3VhBmap/HuzBXxsNwka31HCicBCyDbB/MVKOXJvOEq
	2zXDcD7LfhlVEj/RAOIRxKEt/gf38e12r8MTf5lD3D21fMQAeK+6D801Cab6dwITcC+a
	xM2Q==
X-Gm-Message-State: APjAAAVeoSAkLNHh9jQVMoo9wpp7/NGuQmafdMmzZBijSV7EwLR4Wbuu
	p5gq2zCSMIXpI1hTk4h8CmraL3+yoM87ASW7OAk=
X-Google-Smtp-Source: APXvYqydFvMAKaxCqSkvaGXwPkVICCXpi7v8k1RU0ZsUEb11CywG20kogt2pCiVZkV6NKyOZKMk1VptM+htRXKABx+A=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr13127193otl.341.1558042477310; 
	Thu, 16 May 2019 14:34:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Thu, 16 May 2019 14:34:36
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Thu, 16 May 2019 14:34:36
	-0700 (PDT)
In-Reply-To: <847cc518-5e38-228d-b152-4d8169ecb3ed@amsat.org>
References: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
	<ab4b6d04-74f9-2f12-829d-9df8c1b1c4ca@redhat.com>
	<6ae8d347-149d-e7eb-bb02-90aba44c5bbd@kernkonzept.com>
	<1e9a8595-4653-4900-b747-236f9888b893@kernkonzept.com>
	<04a4fcca-0db9-46f8-ac41-0d770b0dc5d6@kernkonzept.com>
	<f9f1b930-2381-b343-854f-70e2590c9b73@redhat.com>
	<CAL1e-=jFH7+cHGUJsmUKpEAkwohagfM5WVb4-rGSozsEkzFrTA@mail.gmail.com>
	<847cc518-5e38-228d-b152-4d8169ecb3ed@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 16 May 2019 23:34:36 +0200
Message-ID: <CAL1e-=iQN=6YkmMedZ6r1vgWBbPaLfnkU81D581=iR+hoFyCuA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Leon Alrae <leon.alrae@imgtec.com>, qemu-devel@nongnu.org,
	Jakub Jermar <jakub.jermar@kernkonzept.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 16, 2019 10:05 PM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> On 5/16/19 8:04 PM, Aleksandar Markovic wrote:
> > On May 16, 2019 6:31 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.c=
om>
wrote:
> >>
> >> Hi Jakub,
> >>
> >> On 5/16/19 3:10 PM, Jakub Jermar wrote:
> >>> Hi,
> >>>
> >>> On 5/3/19 12:02 PM, Jakub Jermar wrote:
> >>>> Hi,
> >>>>
> >>>> On 4/23/19 4:58 PM, Jakub Jermar wrote:
> >>>>> Hi Philippe!
> >>>>>
> >>>>> On 4/23/19 3:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>>> Hi Jakub,
> >>>>>>
> >>>>>> On 4/23/19 1:00 PM, Jakub Jerm=C3=A1=C5=99 wrote:
> >>>>>>> This commit addresses QEMU Bug #1825311:
> >>>>>>>
> >>>>>>>   mips_cpu_handle_mmu_fault renders all accessed pages executable
> >>>>>>>
> >>>>>>> It allows finer-grained control over whether the accessed page
> > should be
> >>>>>>> executable by moving the decision to the underlying map_address
> >>>>>>> function, which has more information for this.
> >>>>>>>
> >>>>>>> As a result, pages that have the XI bit set in the TLB and are
> > accessed
> >>>>>>> for read/write, don't suddenly end up being executable.
> >>>>>>>
> >>>>>>
> >>>>>> Fixes: https://bugs.launchpad.net/qemu/+bug/1825311
> >>>>>>
> >>>>>>> Signed-off-by: Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.c=
om>
> >>>>>>> ---
> >>>>>>>  target/mips/helper.c | 17 ++++++++++-------
> >>>>>>>  1 file changed, 10 insertions(+), 7 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/target/mips/helper.c b/target/mips/helper.c
> >>>>>>> index c44cdca3b5..132d073fbe 100644
> >>>>>>> --- a/target/mips/helper.c
> >>>>>>> +++ b/target/mips/helper.c
> >>>>>>> @@ -43,7 +43,7 @@ int no_mmu_map_address (CPUMIPSState *env,
hwaddr
> > *physical, int *prot,
> >>>>>>>                          target_ulong address, int rw, int
> > access_type)
> >>>>>>>  {
> >>>>>>>      *physical =3D address;
> >>>>>>> -    *prot =3D PAGE_READ | PAGE_WRITE;
> >>>>>>> +    *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >>>>>>>      return TLBRET_MATCH;
> >>>>>>>  }
> >>>>>>>
> >>>>>>> @@ -61,7 +61,7 @@ int fixed_mmu_map_address (CPUMIPSState *env,
> > hwaddr *physical, int *prot,
> >>>>>>>      else
> >>>>>>>          *physical =3D address;
> >>>>>>>
> >>>>>>> -    *prot =3D PAGE_READ | PAGE_WRITE;
> >>>>>>> +    *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >>>>>>>      return TLBRET_MATCH;
> >>>>>>>  }
> >>>>>>>
> >>>>>>> @@ -101,6 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwadd=
r
> > *physical, int *prot,
> >>>>>>>                  *prot =3D PAGE_READ;
> >>>>>>>                  if (n ? tlb->D1 : tlb->D0)
> >>>>>>>                      *prot |=3D PAGE_WRITE;
> >>>>>>> +                if (!(n ? tlb->XI1 : tlb->XI0)) {
> >>>>>>> +                    *prot |=3D PAGE_EXEC;
> >>>>>>> +                }
> >>>>>>
> >>>>>> This was indeed missed in commit 2fb58b73746e.
> >>
> >> Aleksandar, if this patch is OK with you, can you amend this comment,
> >> and add the "Fixes:" tag too when applying? Thanks!
> >
> > Yes, definitely, Philippe, that is not a problem.
> >
> > Thanks for helping out!
> >
> > I tested Jakub's scenario too, it works as expected, but I am not
concerned
> > about it as much as about regression tests. Knowing that you have many
MIPS
> > test kernels and images, may I ask you to test some of them WITH Jakub'=
s
> > fix (so indepenently of myself anf Jakub), just to confirm that there
are
> > no regressions?
>
> Yes, I can do that (during next WE).
>
> FYI I try to test all QEMU MIPS boards at least once a month (except the
> Jazz board, I don't have handy setup and think Herv=C3=A9 does test it).
> It is time consuming so I'm investing time to offload that testing with
> Avocado slowly. This will take me some months (at least 2 QEMU releases).
>

Avocado MIPS testing was one of the best news for QEMU for MIPS in years.
Even my bosses nodded with approval and interest, which doesn't happen too
often. In other words, it was received very well, excellent.

> I'm also regularly testing embedded firmwares on boards not yet
> upstreamed (which are of my interest) and am working on a Avocado test
> setup too. I wish I can upstream the whole work this year...
>
> > C=E2=80=99est vraiment gentil de votre part.
>
> ;)
>
> >
> > Aleksandar
> >
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>
> >>>>>>
> >>>>>>>                  return TLBRET_MATCH;
> >>>>>>>              }
> >>>>>>>              return TLBRET_DIRTY;
> >>>>>>> @@ -182,7 +185,7 @@ static int
> > get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
> >>>>>>>      } else {
> >>>>>>>          /* The segment is unmapped */
> >>>>>>>          *physical =3D physical_base | (real_address & segmask);
> >>>>>>> -        *prot =3D PAGE_READ | PAGE_WRITE;
> >>>>>>> +        *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >>>>>>>          return TLBRET_MATCH;
> >>>>>>>      }
> >>>>>>>  }
> >>>>>>> @@ -913,8 +916,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs,
> > vaddr address, int size, int rw,
> >>>>>>>      }
> >>>>>>>      if (ret =3D=3D TLBRET_MATCH) {
> >>>>>>>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
> >>>>>>> -                     physical & TARGET_PAGE_MASK, prot |
PAGE_EXEC,
> >>>>>>> -                     mmu_idx, TARGET_PAGE_SIZE);
> >>>>>>> +                     physical & TARGET_PAGE_MASK, prot, mmu_idx,
> >>>>>>> +                     TARGET_PAGE_SIZE);
> >>>>>>>          ret =3D 0;
> >>>>>>>      } else if (ret < 0)
> >>>>>>>  #endif
> >>>>>>> @@ -936,8 +939,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs,
> > vaddr address, int size, int rw,
> >>>>>>>                                             address, rw,
> > access_type, mmu_idx);
> >>>>>>>                  if (ret =3D=3D TLBRET_MATCH) {
> >>>>>>>                      tlb_set_page(cs, address & TARGET_PAGE_MASK,
> >>>>>>> -                            physical & TARGET_PAGE_MASK, prot |
> > PAGE_EXEC,
> >>>>>>> -                            mmu_idx, TARGET_PAGE_SIZE);
> >>>>>>> +                            physical & TARGET_PAGE_MASK, prot,
> > mmu_idx,
> >>>>>>> +                            TARGET_PAGE_SIZE);
> >>>>>>>                      ret =3D 0;
> >>>>>>>                      return ret;
> >>>>>>>                  }
> >>>>>>>
> >>>>>>
> >>>>>> Your patch looks correct, but I'd like to test it.
> >>>>>> Do you have a reproducer?
> >>>>>> Can you describe the command line you used?
> >>>>>
> >>>>> I've just attached a reproducer image and script to the bug. It's a
> >>>>> 32-bit little-endian test binary running on top of the L4Re
> > microkernel.
> >>
> >> I can't get the "TAP" output you described on launchpad.
> >>
> >>>>> Let me know if you also need a 64-bit version.
> >>
> >> 64-bit version is welcomed.
> >>
> >>>>> I tested both 32 and 64-bit versions of the reproducer and also
> > checked
> >>>>> to see that the the other images I have lying around here (Linux
> > 2.6.32
> >>>>> big endian and HelenOS master little-endian, both 32-bit for 4Kc)
> >>>>> continue to run without regressions.
> >>
> >> Yes, definitively an improvement:
> >> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>
> >> Regards,
> >>
> >> Phil.
> >>
