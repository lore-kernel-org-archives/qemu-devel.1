Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80100C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9822224E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz5O8yDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9822224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnnV-0004yi-Ja
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1kSnmP-0004NC-A7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:53:50 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:44301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1kSnmN-0004em-Ak
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:53:48 -0400
Received: by mail-qk1-x744.google.com with SMTP id s14so640266qkg.11
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OOffP6WU53cSRYprPaYe+4MOzYl6rNreJvFTR/B9x8c=;
 b=kz5O8yDEu9puy5XiS2hqQJMXKgSQEQM/An5kR8p4s+xUAIfMQWgRjnGyC0AyEMMOyX
 wW2zxlVLbAXwvho7gWv1zm/uLS3YIfID7FX+TnjDD8df7QGMUvLQ908tPG4GmcLtEUdr
 KKUinhOIlxRP1EbZBsYQuT4yNrtqyBT2rRG8s1hqy1kyf/GkDfK8Cb94dBja2hYVZTDk
 NsJ04ZFVVNIVm5qN63LGKveqfZ2gLyKP0pNmDnD4Zbgkc6UOICqG0KZ1OmrFLcAGW/2l
 PCrzbliqSd5v3vLdOpoJZy4qcLO033LyhLOXq8fe1gRA9kUVKgJG79Rh2pg01JkUTCRr
 rUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OOffP6WU53cSRYprPaYe+4MOzYl6rNreJvFTR/B9x8c=;
 b=dEgRvnxC4VqHg3C7A9tVqA2vAMZiUimphBPGTCkUDeGnHZST4io3jnG7/oA5A6zg5Y
 CrMfK3O16xIBWoO4cKX2NXxLhTmkCXTM51CA5gJFaP/EnpXO6lOfiRLbKFp4PmzZMmYO
 sko0EMjjipgNhs9Ste5cKEx1I0pghzRqO9mdUKZvhmGmxbFVz+IUps5IGGDOg05WdDc0
 wuv9BX3oGvXZSC/qMgI602SzHTLUW483QrnEEpX5tDa1POGdivmoCWEtj+hxmjuwwV7R
 UdjPzlrYY1Ad1DgNaVwuRW+76/EUYcUv8nY0vFpJzz+/OgfGO7iGGIaIml33b3/3jLVn
 Qujg==
X-Gm-Message-State: AOAM532bYKHICTFVeDEUepcP/iUkZCbeuMrpi+IutN47PXTnBXeYvQ8A
 OmX8AjtynMuNnDHNx11LZKbQJpk50FdsNcItsjs=
X-Google-Smtp-Source: ABdhPJwFCMtz6Pj58JsLT1gJRvbAWXj9txdrWzINralBG0s8BNUDHBFHl461pD7HgQX6OAdTMpZs0o1y459pQw0cRZo=
X-Received: by 2002:a05:620a:c07:: with SMTP id l7mr965484qki.9.1602708824736; 
 Wed, 14 Oct 2020 13:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <BYAPR11MB30479E5264D94EF903E9FD92CD040@BYAPR11MB3047.namprd11.prod.outlook.com>
 <515ec755fd8d7219040283f0c27346d762ee3c29.camel@linuxfoundation.org>
 <ea0ed6c7-1e3a-f7ee-a962-b471555e362d@amsat.org>
 <BYAPR11MB30471BC8B9D3B5F3E678F547CD050@BYAPR11MB3047.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB30471BC8B9D3B5F3E678F547CD050@BYAPR11MB3047.namprd11.prod.outlook.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 14 Oct 2020 13:53:18 -0700
Message-ID: <CAMKF1sokbfu1ox+nnZe0nJLid5_GnzZUeQEfWDmqmS4LY-RqNg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
To: "Victor Kamensky (kamensky)" <kamensky@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=raj.khem@gmail.com; helo=mail-qk1-x744.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 1:20 PM Victor Kamensky (kamensky)
<kamensky@cisco.com> wrote:
>
> In order just to keep on the same thread, here is piece of information
> I found:
>
> I looked at "MIPS32=C2=AE 34Kf=E2=84=A2 Processor Core Datasheet" [1]
>
> Page 8 in "Joint TLB (JTLB)" section says:
>
> "The JTLB is a fully associative TLB cache containing 16, 32,
> or 64-dual-entries mapping up to 128 virtual pages to their
> corresponding physical addresses."
>
> So "34Kf-64tlb" cpu model I proposed turns out not to be "fictitious"
> after all. Having 64 TLBs is all within this CPU spec. It is not clear
> why original 34Kf model choose worst case scenario wrt
> TLB numbers. Commit log where 34Kf was introduced does not
> have much details.

thanks for digging this information from CPU specs. It seems using 64
TLB as default might be a good option for 34Kf then

>
> So IMO on 34Kf route we have the following choices:
>
> 1) I can rephrase commit message and resubmit commit for
> "34Kf-64tlb" cpu model, if it could be merged
>
> 2) We can bump up number of TLBs to 64 in existing 34Kf model
> since it is within the spec.

this looks a good option since it is with in specs and is backward compatib=
le.

>
> 3) Use Phil's series and tlb-entries cpu parameter would cover all

I agree.

> 3 variants of 16,32,64 TLBs allowed by 34Kf data sheet spec.
>
> Please see inline wrt asked '-cpu P5600' testing. Look for 'victor2>'
>
> [1] https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00419-2=
B-34Kf-DTS-01.20.pdf
>
> ________________________________________
> From: Philippe Mathieu-Daud=C3=A9 <philippe.mathieu.daude@gmail.com> on b=
ehalf of Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Sent: Wednesday, October 14, 2020 7:53 AM
> To: Richard Purdie; Victor Kamensky (kamensky); qemu-devel@nongnu.org
> Cc: Aleksandar Rikalo; Khem Raj; Aleksandar Markovic; Aurelien Jarno; Ric=
hard Henderson
> Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries =
a CPU property
>
> On 10/14/20 9:14 AM, Richard Purdie wrote:
> > On Wed, 2020-10-14 at 01:36 +0000, Victor Kamensky (kamensky) wrote:
> >> Thank you very much for looking at this. I gave a spin to
> >> your 3 patch series in original setup, and as expected with
> >> '-cpu 34Kf,tlb-entries=3D64' option it works great.
> >>
> >> If nobody objects, and your patches could be merged, we
> >> would greatly appreciate it.
> >
> > Speaking as one of the Yocto Project maintainers, this is really
> > helpful for us, thanks!
> >
> > qemumips is one of our slowest platforms for automated testing so this
> > performance improvement helps a lot.
>
> Could you try Richard's suggestion? Using '-cpu P5600' instead?
> It is available in Linux since v5.8.
>
> victor2> I've tried exact image that works on 34Kf and 34Kf-64tlb models
> victor2> image with '-cpu P5600'. it does not boot: it dies in init (syst=
emd).
> victor2> I can look under gdb with qemu -s -S options, what is going on t=
here
> victor2> but it will take time.
> victor2> If someone have some clues what might cause it please let
> victor2> me know. Here is high level information about setup:
> victor2>    - qemu version is 5.1.0
> victor2>    - kernel base version is 5.8.9
> victor2>    - systemd version is 1_246.6
> victor2>    - user land CPU related build options "-meb -meb -mabi=3D32 -=
mhard-float -march=3Dmips32r2 -mllsc -mips32r2"
>
> Thanks,
> Victor
>
> >
> > Cheers,
> >
> > Richard
> >
> >

