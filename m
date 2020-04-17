Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FA3C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647F920857
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 14:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrJ1x7Fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647F920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPRr5-0001by-Dh
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 10:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jPRqK-00016m-6I
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jPRqI-0003dV-Hy
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:19:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54269
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jPRqI-0003dA-9h
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 10:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587133181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4r74DZJi9yFkPK/p+/NY16Ui+26N7oMG9UwwN8a5z2Q=;
 b=WrJ1x7FqLvDTafDtpXb1bnG+yoiioKs0HbQ1ZAJzdKXJN6qyAUoNgLR1VMERRLMFnI0+1t
 tCCF2Lilz8mVm9JoHOniTeipZ7ZWwekrNhEuNqLxisZECYQHi1y4/Y5sID/UHaAbtn2ZWK
 LxvZFsmJc7ubbuIT6kkDwzOdOYPXkUY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-jzXThnGSNXCsQ26Nfvm-ig-1; Fri, 17 Apr 2020 10:19:40 -0400
X-MC-Unique: jzXThnGSNXCsQ26Nfvm-ig-1
Received: by mail-ej1-f69.google.com with SMTP id b21so1090615eje.7
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 07:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DAdieQ2sXt/NeBUDGNTNawrWk821Y/E983QoU7SMcFs=;
 b=q46IMv/REgLJ7eVrpRXLVvsrFMA6/teWELqNFwsNf8xWddJ2NDIGi/ZanMuxv7Q5KQ
 bOMUtlsNbV62nj6NQp6RhRQ9oi5bGtIKmuhHdgpVeCdShq/ibLmpwJNTvv0WiC2QcvgK
 DDO1WLbC1lDs8GrfYkqFYPl3BWFP1AQcGz91LTBQCTP3OraBRSXh8Ut8+sBQ9CsTeTk4
 Aa5hfvBw6WDI0R1CWoJAav2BLa29cT2zOwO7c+N/uyux89fh9ClHLL3IrCYvNp51Z58s
 IhoaEpuYs/1KJobAs7NPggt3IMH/6G1uppLI6WzoI941Op2WYKy5RS+wlXVy3l+kHSig
 7ACA==
X-Gm-Message-State: AGi0PuZmy3cbX1TQVWNoQZ8E9IQwzDIQWj+ZVZaF+iKcDae4NG7T0m/R
 4LVRzdASHoy3oLc5ZPSRuqp5ESn2U952SO7XUngzw1IgtkTX+P4IDW5ErJlfcRZEPj9i7YgFiGW
 k4DPd8omD44dtBPI=
X-Received: by 2002:a50:9dc9:: with SMTP id l9mr2672162edk.39.1587133178728;
 Fri, 17 Apr 2020 07:19:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypLSNonCa7KPxn9j8grfL9YTWfd/4UpcKCI2QJ3npNEUbmnpJku3CrPOj8XqHh7la5HhfBBELQ==
X-Received: by 2002:a50:9dc9:: with SMTP id l9mr2672131edk.39.1587133178375;
 Fri, 17 Apr 2020 07:19:38 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l91sm2911342ede.64.2020.04.17.07.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 07:19:37 -0700 (PDT)
Subject: Re: [PATCH v3 03/19] target/arm: Restrict DC-CVAP instruction to TCG
 accel
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-4-philmd@redhat.com>
 <f570579b-da9c-e89a-3430-08e82d9052c1@linaro.org>
 <CAFEAcA8K-njh=TyjS_4deD4wTjhqnc=t6SQB1DbKgWWS5rixSQ@mail.gmail.com>
 <5d9606c9-f812-f629-e03f-d72ddbce05ee@redhat.com>
 <CAFEAcA-4+Jcfxc5dax8exV+kBJKYEnWZ2d-V1A6sm6uJafZdPg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <16bd73d1-ec39-7da6-77c3-a18eea5992e0@redhat.com>
Date: Fri, 17 Apr 2020 16:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-4+Jcfxc5dax8exV+kBJKYEnWZ2d-V1A6sm6uJafZdPg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 3:54 PM, Peter Maydell wrote:
> On Fri, 17 Apr 2020 at 14:49, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> On 3/16/20 9:11 PM, Peter Maydell wrote:
>>> On Mon, 16 Mar 2020 at 19:36, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>> I'm not 100% sure how the system regs function under kvm.
>>>>
>>>> If they are not used at all, then we should avoid them all en masse an=
 not
>>>> piecemeal like this.
>>>>
>>>> If they are used for something, then we should keep them registered an=
d change
>>>> the writefn like so:
>>>>
>>>> #ifdef CONFIG_TCG
>>>>       /* existing stuff */
>>>> #else
>>>>       /* Handled by hardware accelerator. */
>>>>       g_assert_not_reached();
>>>> #endif
>>
>> I ended with that patch because dccvap_writefn() calls probe_read()
>> which is an inlined call to probe_access(), which itself is only defined
>> when using TCG. So with KVM either linking fails or I get:
>>
>> target/arm/helper.c: In function =E2=80=98dccvap_writefn=E2=80=99:
>> target/arm/helper.c:6898:13: error: implicit declaration of function
>> =E2=80=98probe_read=E2=80=99;
>>        haddr =3D probe_read(env, vaddr, dline_size, mem_idx, GETPC());
>>                ^~~~~~~~~~
>=20
> IN this particular case, DC CVAP is really a system insn rather
> than a 'register'; our register struct for it is marked up as
> ARM_CP_NO_RAW, which means we'll effectively ignore it when
> running KVM (it will not be migrated, have its state synced
> against the kernel, or be visible in gdb). If dccvap_writefn()
> ever gets called somehow that's a bug, so having it end up
> with an assert is the right thing.
>=20
>> I'll use your suggestion which works for me:
>=20
> Your suggested patch isn't quite the same as RTH's suggestion,
> because it puts the assert inside a stub probe_read()
> implementation rather than having the ifdef at the level
> of the writefn body. I have no opinion on whether one or
> the other of these is preferable.

I'll let Richard modify the writefn() bodies if required, as he=20
understand what they do :)

Btw since we have this rule:

obj-$(call lnot,$(CONFIG_TCG))  +=3D tcg-stub.o

I'll use the following patch which is less intrusive:

-- >8 --
index 677191a69c..e4bbf997aa 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -22,3 +22,10 @@ void tb_flush(CPUState *cpu)
  void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
  {
  }
+
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t=20
retaddr)
+{
+     /* Handled by hardware accelerator. */
+     g_assert_not_reached();
+}
---

>=20
> thanks
> -- PMM
>=20


