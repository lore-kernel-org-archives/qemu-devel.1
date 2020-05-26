Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238B7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAFC20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bimOXRqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAFC20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcoo-000322-2D
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdciG-0001dL-Gd
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:46:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdciF-00058g-66
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:46:00 -0400
Received: by mail-wm1-x344.google.com with SMTP id y5so199190wmj.4
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0gRajJpZ1ewwCX0SexN33O83wF8F+CqSXxmSxisAFD4=;
 b=bimOXRqm18yR/GSz0jgZd9tgBlJmxkMi1UbGTc9oF1hCn31KTmCm6+hMLFD1qs6V+j
 3Kh2CUuQ4j+C/URge393It+vFv4i8J9bH2TDp1aNFHHejmLh8CYXglOiystx0FB3ujqb
 +VJANzXxixLKu6k7AVw869WBrxhBzK2odrBGhQ6W7W86ZsTLSGJwR7K4zikrZ2QS6Uyw
 1farXCOxJcjEoY4WJ2TN6u+5iJG6Ci9yuT9l3AELUcCGoaAeApxln7oL39m6GQ04eeW5
 NVx6UE/EI9UKrhXzZhCwTi8JJkC/tnXHr+hrkL/r2ncU+MD7PmRMkBR4SXkN8SL0nttI
 MdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0gRajJpZ1ewwCX0SexN33O83wF8F+CqSXxmSxisAFD4=;
 b=mJp/hvNmhlvzdCafQEF+WFqHV4pQDSOSosiRrLyseI9U/91fdTvhZ2xYrPB05desSM
 BCT1K+ZyulUt9JdrxzPVSvXG/omutA+6HibjVuQE2k7hPNUzkbzOX4OOuxKJbKxio6a1
 H6DyFLBrN+SYxX7VM+aLk6qd9tW4/rUEdya6lTISIw9YPpp/ftXE/WD7S1mIgQhmm221
 v/QRE8ErFQctnaVXcOh09dbMxmfrxiihXdfLkHYteVUcCMjd8kzKJgRC538VTaWK2iBh
 CYLytcDS84Ei2WdHTr0YoDvsPDXGX9IG39cg6KtWFZVafPdGnTjkOFIUnh5shgzvrCbS
 p2hQ==
X-Gm-Message-State: AOAM530MHWNJ7HEtgXdchhKZk5Qk+pofi6fq/HwjLJiOQQXZ9fl+7uhz
 l5jvp/AXGqbBMpe+ZYT/vbCilx+1VPRxS95m9iE=
X-Google-Smtp-Source: ABdhPJyZjm1VNW6+18mX01U/K75Tn44wY/dQodMWKJnzBjgTV/MQVthoQLA4KOsTFFRtFDl1u4pJCHocW/7N7NvZSX4=
X-Received: by 2002:a1c:18e:: with SMTP id 136mr76847wmb.159.1590511557242;
 Tue, 26 May 2020 09:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
 <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
 <CALTWKrVGqVb1mjsaoxYm4Y1iQoXYwz7ToC7T6r2EDPp-_LO=LQ@mail.gmail.com>
 <4e78400c-42be-08c6-492d-dc5596551efd@linaro.org>
 <CAHiYmc6zKmxgyKHzT4gazvJvPsX3SQYLjSXwK50_2eURkR3_NA@mail.gmail.com>
 <CAHiYmc7z+OfvE7nN1j14n2O8seVtqem_hsBwq=WyFgeo=WfybA@mail.gmail.com>
 <CALTWKrXv6NQUEzKFvPN4TmDGCKxY-Zaa+Dt-z0+sTgndco+EMA@mail.gmail.com>
 <CAHiYmc6289cQZEptA=KjpMDLx3S94Au7W79DXH9KTM-MLi3ADA@mail.gmail.com>
In-Reply-To: <CAHiYmc6289cQZEptA=KjpMDLx3S94Au7W79DXH9KTM-MLi3ADA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 18:45:42 +0200
Message-ID: <CAHiYmc7r0GBLytokN=cyonrQAC6S8J=SpPf9KroPgG+ACJPV5Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mr. Ahmed,

The title "Changing executable page permissions with mmap causes
user-mode failures", I know you paraphrased one of Richard's
responses, but you picked up those pieces that don't convey the
complete, larger, picture. So, the better, more inclusive, and much
clearer title would be "Problems related to checking page crossing in
use_goto_tb()"

Yours,
Mr. Aleksandar

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 18:29 Aleksandar Ma=
rkovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 18:08 Ahmed Karam=
an
> <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > On Tue, May 26, 2020 at 4:14 PM Aleksandar Markovic
> > <aleksandar.qemu.devel@gmail.com> wrote:
> > > Ahmed, please follow the instructions on this page: How to report a Q=
EMU bug and file the bug related to the discussion, to the best of your abi=
lities, if possible, today.
> >
> > Please find the link to the bug below:
> > https://bugs.launchpad.net/qemu/+bug/1880722
>
> I think your last sentence in the bug report is not entirely correct.
> It is not known what would be performance results in case of
> correcting mmap.c. So, if possible, and unless Richard or someone else
> disagrees, please change that last sentence to: "By doing so, a better
> performance results could be achieved, compared to the case of the
> workaround described above."
>
> Also, please add the tag "linux-user".
>
> Yours,
> Aleksandar

