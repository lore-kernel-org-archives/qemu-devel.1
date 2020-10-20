Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C289C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 01:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2525022244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 01:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7mqDmUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2525022244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUgcU-00025d-2c
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 21:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kUgbm-0001fH-Nk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 21:38:38 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:34611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kUgbk-00024w-NI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 21:38:38 -0400
Received: by mail-io1-xd43.google.com with SMTP id z5so579213iob.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 18:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WQ+zWkOTSia8+hOtCzfR94LCldPx7U8qnc/EYzzhllA=;
 b=A7mqDmUVL5V49q68VsY2kNWLfmIZx+IRPXcNMn4TgbbYkiNPclSVFYphSa+gEmVyCe
 qHbLDfmMTFYxEfy/e+jKvfIE8JfcuLoUU2LSuAGDAjT57725naPa9iGKNHij7bSmED1U
 wPyDkhu6fE5Uo7mBzVk+qZ9wgsADyk9ptEKFTlOj5bMUeqkb4I3wdWnJ3TCkQorunDqd
 /ZoXBKuW0KKvZ7nNxM/KY6iGZHcw+EFTCkvi63dQpA+YoSeEVBpQAba+GDI/js3cjMhX
 tjJ1AFROv4FjavpZJrtIMgkps4g7WKhLhkIVds/M3XXg1EyES4lBypdLT/Cw/hBiGXdO
 xV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WQ+zWkOTSia8+hOtCzfR94LCldPx7U8qnc/EYzzhllA=;
 b=WSPd54Is/6iaqyspRk5C9Q5ShVCP4Fl5pCn2rnk83IMPq2O6bmvMy9aeuCO2glV3wv
 /Eg9ZetHwN/5TJ4az5CzPcCAaUajK+FXu18+A5g0ZqPmgI2ScVs6ZL8YJeheuMTkbASs
 eq6ZViu2SoQWG+rKVYU6mFtY/ktNbtmacB5ZGU0SGFEd2NtOpyv6UrIjARisNqUcxQBa
 Lhe7aYIbZF0CH9omDyFhqsWDEF8+ZoBMQEx14oJBO1ryilVpiMyoQ0YsEnbHHW/4ev6e
 dyhhDB5YBNQcVzwOM6MOqVCxXz7Q6tv3U5hHe9+YUWmMxCYkJlVSRlTG3TdEVTM9kHGU
 dp2g==
X-Gm-Message-State: AOAM532NQSpqvpUoVJaGXIDQXW3M4pgG+NrWeTKGKAkWqaoStY0bg57s
 u4Obc1dBw8AVJP7GrFHvX7x3ZdMNkLVmGOPZMT0=
X-Google-Smtp-Source: ABdhPJxNWXN6utvnZ8eztI5RbYaglKAr/Ix/nRJjyLLeMJ5bVynHn1yzGIgV0WmVhHVgkd/0/QXCeNgfyxBjWPZlPlw=
X-Received: by 2002:a6b:8bd7:: with SMTP id n206mr457388iod.13.1603157914985; 
 Mon, 19 Oct 2020 18:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
 <1602831120-3377-2-git-send-email-chenhc@lemote.com>
 <bfb682a3-0e1f-926c-66a9-976a1659d534@amsat.org>
In-Reply-To: <bfb682a3-0e1f-926c-66a9-976a1659d534@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 20 Oct 2020 09:38:23 +0800
Message-ID: <CAAhV-H5Gaaxi5vY_u=MsoEqJ4i1zhLQYgk4iL8_rHxsG-rv6ww@mail.gmail.com>
Subject: Re: [PATCH V14 1/8] target/mips: Fix PageMask with variable page size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Fri, Oct 16, 2020 at 11:15 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 10/16/20 8:51 AM, Huacai Chen wrote:
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >
> > Our current code assumed the target page size is always 4k
> > when handling PageMask and VPN2, however, variable page size
> > was just added to mips target and that's no longer true.
> >
> > Fixes: ee3863b9d414 ("target/mips: Support variable page size")
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >   target/mips/cp0_helper.c | 36 +++++++++++++++++++++++++++++-------
> >   target/mips/cpu.h        |  1 +
> >   2 files changed, 30 insertions(+), 7 deletions(-)
> >
> > diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> > index de64add038..f3478d826b 100644
> > --- a/target/mips/cp0_helper.c
> > +++ b/target/mips/cp0_helper.c
> > @@ -867,13 +867,35 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, t=
arget_ulong arg1)
> >
> >   void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *p=
agemask)
> >   {
> > -    uint64_t mask =3D arg1 >> (TARGET_PAGE_BITS + 1);
> > -    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 =3D=3D ~0) ||
> > -        (mask =3D=3D 0x0000 || mask =3D=3D 0x0003 || mask =3D=3D 0x000=
F ||
> > -         mask =3D=3D 0x003F || mask =3D=3D 0x00FF || mask =3D=3D 0x03F=
F ||
> > -         mask =3D=3D 0x0FFF || mask =3D=3D 0x3FFF || mask =3D=3D 0xFFF=
F)) {
> > -        env->CP0_PageMask =3D arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK <=
< 1));
> > +    unsigned long mask;
> > +    int maskbits;
> > +
> > +    if (env->insn_flags & ISA_MIPS32R6) {
> > +        return;
> > +    }
> > +    /* Don't care MASKX as we don't support 1KB page */
> > +    mask =3D extract32((uint32_t)arg1, CP0PM_MASK, 16);
> > +    maskbits =3D find_first_zero_bit(&mask, 32);
> > +
> > +    /* Ensure no more set bit after first zero */
> > +    if (mask >> maskbits) {
> > +        goto invalid;
> > +    }
> > +    /* We don't support VTLB entry smaller than target page */
> > +    if ((maskbits + 12) < TARGET_PAGE_BITS) {
> > +        goto invalid;
> >       }
> > +    env->CP0_PageMask =3D mask << CP0PM_MASK;
> > +
> > +    return;
> > +
> > +invalid:
> > +    /*
> > +     * When invalid, ensure the value is bigger than or equal to
> > +     * the minimal but smaller than or equal to the maxium.
> > +     */
> > +    maskbits =3D MIN(16, MAX(maskbits, TARGET_PAGE_BITS - 12));
> > +    env->CP0_PageMask =3D ((1 << (16 + 1)) - 1) << CP0PM_MASK;
> >   }
> >
> >   void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
> > @@ -1104,7 +1126,7 @@ void helper_mthc0_saar(CPUMIPSState *env, target_=
ulong arg1)
> >   void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
> >   {
> >       target_ulong old, val, mask;
> > -    mask =3D (TARGET_PAGE_MASK << 1) | env->CP0_EntryHi_ASID_mask;
> > +    mask =3D ~((1 << 14) - 1) | env->CP0_EntryHi_ASID_mask;
> >       if (((env->CP0_Config4 >> CP0C4_IE) & 0x3) >=3D 2) {
> >           mask |=3D 1 << CP0EnHi_EHINV;
> >       }
> > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> > index 7cf7f5239f..9c8bb23807 100644
> > --- a/target/mips/cpu.h
> > +++ b/target/mips/cpu.h
> > @@ -618,6 +618,7 @@ struct CPUMIPSState {
> >    * CP0 Register 5
> >    */
> >       int32_t CP0_PageMask;
> > +#define CP0PM_MASK 13
> >       int32_t CP0_PageGrain_rw_bitmask;
> >       int32_t CP0_PageGrain;
> >   #define CP0PG_RIE 31
> >
>
> Malta test failing:
>
> [    0.000000] Linux version 4.5.0-2-4kc-malta
> (debian-kernel@lists.debian.org) (gcc version 5.3.1 20160519 (Debian
> 5.3.1-20) ) #1 Debian 4.5.5-1 (2016-05-29)
> [    0.000000] earlycon: Early serial console at I/O port 0x3f8 (options
> '38400n8')
> [    0.000000] bootconsole [uart0] enabled
> [    0.000000] CPU0 revision is: 00019300 (MIPS 24Kc)
> [    0.000000] FPU revision is: 00739300
> [    0.000000] MIPS: machine is mti,malta
> [...]
> Freeing unused kernel memory: 412K (80979000 - 809e0000)
> do_page_fault(): sending SIGSEGV to mount for invalid write access to
> 0018a000
> epc =3D 77848a54 in libc-2.27.so[7782f000+177000]
> ra  =3D 779d0618 in ld-2.27.so[779bf000+24000]
> do_page_fault(): sending SIGSEGV to ln for invalid write access to 0018a0=
00
> epc =3D 778d4a54 in libc-2.27.so[778bb000+177000]
> ra  =3D 77a5c618 in ld-2.27.so[77a4b000+24000]
> do_page_fault(): sending SIGSEGV to S01logging for invalid write access
> to 0018a000
> epc =3D 77d08a54 in libc-2.27.so[77cef000+177000]
> ra  =3D 77e90618 in ld-2.27.so[77e7f000+24000]
> do_page_fault(): sending SIGSEGV to S20urandom for invalid write access
> to 0018a000
> epc =3D 76ee4a54 in libc-2.27.so[76ecb000+177000]
> ra  =3D 7706c618 in ld-2.27.so[7705b000+24000]
> do_page_fault(): sending SIGSEGV to ifup for invalid write access to
> 0018a000
> epc =3D 77974a54 in libc-2.27.so[7795b000+177000]
> ra  =3D 77afc618 in ld-2.27.so[77aeb000+24000]
> do_page_fault(): sending SIGSEGV to awk for invalid read access from
> 00000000
> epc =3D 00000000 in busybox[400000+d8000]
> ra  =3D 77248110 in libc-2.27.so[770fb000+177000]
> do_page_fault(): sending SIGSEGV to cat for invalid write access to 0018a=
000
> epc =3D 77484a54 in libc-2.27.so[7746b000+177000]
> ra  =3D 7760c618 in ld-2.27.so[775fb000+24000]
> do_page_fault(): sending SIGSEGV to run.sh for invalid write access to
> 0018a000
> epc =3D 76e88a54 in libc-2.27.so[76e6f000+177000]
> ra  =3D 77010618 in ld-2.27.so[76fff000+24000]
> qemu-system-mips: terminating on signal 2
>
> Please run the QEMU tests.
OK, we are investigating.

>
> The easiest way is to push your series on GitLab.
>
> Regards,
>
> Phil.

