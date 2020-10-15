Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5820DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8916C22250
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIkdCc0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8916C22250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSxtV-0001Qu-9s
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 03:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kSxrP-0000TK-P7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:39:39 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:36327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kSxrO-00040G-4t
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:39:39 -0400
Received: by mail-oo1-xc43.google.com with SMTP id z1so496552ooj.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oJbmpeDMclPuFj4ud4vO5I+Ow9vG09eppgR38HjEDD4=;
 b=EIkdCc0Qjei+ONghaqK8kdUZ31tQ7cDrghoryTB4RGA6uLtnA2jp9IKnIKV2F6SDp9
 pw/GC5zT8G9p8B51gBgI3V4esrXqfFHR5SyYofG8pjXnxv/d+ZjlE71bCR0hxhzSKyC9
 uCiB08inLJR2mG288ZOhe+6vU8FT+e3ogubSsFB3ZnT37cPR4zTV6FfYmtm9V2fJrP7/
 7UKyu/it+/qEB1IYzpW/moJjS7B65a/fqgPSYPDb5VIdot8MXyMOBAv4GLRE1+KgIM0+
 cUF6941rDlbLLgr+VrJHp5eE4exYgb1wLaMNTo2RBjKTb/nmwnQkHhIKt56dbySZG+Hh
 X5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oJbmpeDMclPuFj4ud4vO5I+Ow9vG09eppgR38HjEDD4=;
 b=G2gzOeW2cX81tbfdi2R8tb+99N5eI5AbEzVsEyKGINh753d6D3bFMxDPP9TCe/eJfA
 lBwVu0Cv88OSBY6cHDfbpkHHYPdU56xaTSe0Zluvg8p4ON2Cqf8x0gep6+ekXFLCntgI
 ulCclUdQMqhBtYcbH+4kQNzbGfmzVnxU2BJrjlUgkYuroywnp+yCA775aEqSZiFyG76y
 u2H5vOcfLRDE7liWPhEU5OATPwF24eAOKr/Vh/2h55spcCgcTcDjlE7UrmO2HwYWC7dk
 PM1EHOUemfadn76v0iZwTDlM9saBei4lShK9dUHz100/1AbFZbJsAExOuvL83iVcR9u+
 uLjA==
X-Gm-Message-State: AOAM533XkpMO9BBApP/Bd6w6QA3byD4I3QrmO4YpV49aJGI2qU72btSc
 tuMFIoTiN4fU6BP95pntfdnTud8XwjCooGScwWc=
X-Google-Smtp-Source: ABdhPJwoAmuohbv6APA9uCtoBI/kz4YljbnHAuaAoPPJnqtqMTrbnJL7iOBIrlDDlyVVxkkoKur6pRpHPdJapU0OF64=
X-Received: by 2002:a4a:751a:: with SMTP id j26mr1454294ooc.14.1602747576883; 
 Thu, 15 Oct 2020 00:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <CABLmASGJOFbYUhSAbKhc9s1G00Jh0vN--WaFPtaoHqsL2WuvbQ@mail.gmail.com>
 <44d3eccf-3c64-82cd-b5b2-641de6960ab5@redhat.com>
In-Reply-To: <44d3eccf-3c64-82cd-b5b2-641de6960ab5@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 15 Oct 2020 09:39:24 +0200
Message-ID: <CABLmASE55n6h=fr8UrKOHdu1Z_P-46a9t4L0KaRxvvf0hob01w@mail.gmail.com>
Subject: Re: [PATCH 0/7] build: replace ninjatool with ninja
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fc1f1e05b1b0bf0b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=hsp.cat7@gmail.com; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fc1f1e05b1b0bf0b
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 15, 2020 at 8:34 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 15/10/20 08:15, Howard Spoelstra wrote:
> > ERROR: meson setup failed
> >
> > When I set --ninja=ninja explicitly, this error does not occur:
> > Found ninja.EXE-1.10.1 at C:\msys64\mingw64\bin/ninja.EXE
>
> That is fixed by Meson 0.55.2, I'll add a submodule update.  Thanks for
> the reminder!
>
> Paolo
>
>
Thanks Paolo,

Then only the issue regarding the pcbios/optionrom stuff remains ;-)

make[1]: *** No rule to make target 'multiboot.bin', needed by 'all'.  Stop.
make: *** [Makefile:171: pc-bios/optionrom/all] Error 2
make: *** Waiting for unfinished jobs....

Best,
Howard

--000000000000fc1f1e05b1b0bf0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 15, 2020 at 8:34 AM Paolo=
 Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonz=
ini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 15/10/20 08:15, Howard Spoelstra wrote:<br>
&gt; ERROR: meson setup failed<br>
&gt; <br>
&gt; When I set --ninja=3Dninja explicitly, this error does not occur:<br>
&gt; Found ninja.EXE-1.10.1 at C:\msys64\mingw64\bin/ninja.EXE<br>
<br>
That is fixed by Meson 0.55.2, I&#39;ll add a submodule update.=C2=A0 Thank=
s for<br>
the reminder!<br>
<br>
Paolo<br>
<br></blockquote><div><br></div><div>Thanks Paolo,<br></div><div><br></div>=
<div>Then only the issue regarding the pcbios/optionrom stuff remains ;-)</=
div><div><br></div><div>
make[1]: *** No rule to make target &#39;multiboot.bin&#39;, needed by &#39=
;all&#39;.=C2=A0 Stop.<br>make: *** [Makefile:171: pc-bios/optionrom/all] E=
rror 2<br>make: *** Waiting for unfinished jobs....

</div><div><br></div><div>Best,</div><div>Howard<br></div><div> <br></div><=
/div></div>

--000000000000fc1f1e05b1b0bf0b--

