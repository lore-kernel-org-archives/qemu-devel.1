Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4E3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538FE20657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaKS71yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538FE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jag7F-0004kJ-Hr
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jag6Q-0003fv-Tm
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:46:46 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jag6P-0006DK-JF
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:46:46 -0400
Received: by mail-lf1-x144.google.com with SMTP id h188so8115976lfd.7
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yFyeMy1YWnwRHAtgZ2mxIvyae7L2onl/HWWmYGkd5CM=;
 b=GaKS71ySL4IBHHKLZ7kip+N5+p2e6uzzAXPX7vuwsLyFxfU9yPu7iJTBG7bm97v5RW
 vvQUOaQQQ16iufwXB190Wf0vJYfdiD2trchzPEEeH6DHXA9oD62wI6wESt6I0Zq/MIGt
 84ZSQ9hVj2xFnxCNIDhcEjR25Z9qcunZkD4ZIhFIgsUKPdGqug3qkKshTQCt7LCRDJuS
 Fl+Mkng5piDdLhdxWZH+OJz3WBWbqxMz70DnUP2DCB3Zqjds5uRZrbs9ue7qsOpllmJs
 4o+8P7Tw1sdK1qqlODePRAJcqWmZWGUzhyl7OBKmcQUJ/QOjA8LYDmJXkI+BB9xbfw0z
 DmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yFyeMy1YWnwRHAtgZ2mxIvyae7L2onl/HWWmYGkd5CM=;
 b=Cp0HhRGRU8fxMgHPqb2i5aTECIixv8Z+Y08TiBwc56xElROMYlWgddCRqbzyXtDvY3
 phD8u4+awMX7Sk7tuGrXt+1qjM2uNHTfY8Ps/Ccf1mxr2zGuIIJdwhDLW4vYlpq06N38
 i9JAplvvxvjgpXg8ftlcS+bzjKl5ZOO+XB/JmX4nVIkg5A6q5yYheuJ4UAtaoGXf99o0
 NNWTJYpHbUhZaXl6O8Pnuq00SC/IJg7vnEpaLyfdzbpqMLsLRSz/2xs2hKNjNF5lyt1v
 t/5K8ZH/Qi+K1W9SRnh2Pqpb3qEBUVnosm3VGIdy8bAswt0b+1Tkugm1tjFPaZddOj5c
 3rEQ==
X-Gm-Message-State: AOAM5321oH24x8for2VVmDR07P3lXSvhnV133aLRnEc8p9O07jlk43Tm
 9M3u4Ut8Ocp64DQYboa23uQhW73UxnxtFxLQGScbHA==
X-Google-Smtp-Source: ABdhPJz/m7B67XGoBA8GHb/7lCBIfWzGjaB5qqSwXD3dAXJC9mxsjn2z7rczvk4KLFYR2/dsSKBp7IfZ8eTki9xRN/o=
X-Received: by 2002:a19:550e:: with SMTP id n14mr3204705lfe.81.1589809602468; 
 Mon, 18 May 2020 06:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-75-robert.foley@linaro.org> <87imh1f79b.fsf@linaro.org>
 <CAEyhzFt1=xDMN5KdQvVx8QyS5n35THa2vY9D3rV8S9emyTYpSw@mail.gmail.com>
In-Reply-To: <CAEyhzFt1=xDMN5KdQvVx8QyS5n35THa2vY9D3rV8S9emyTYpSw@mail.gmail.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 18 May 2020 09:46:36 -0400
Message-ID: <CAEyhzFuiDWYvu3FZNYy5M0FQ91Cs=-4=kV80xQZHEWX+ejhyTw@mail.gmail.com>
Subject: Re: [PATCH v8 74/74] cputlb: queue async flush jobs without the BQL
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Puhov <peter.puhov@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We re-ran the numbers with the latest re-based series.

We used an aarch64 ubuntu VM image with a host CPU:
Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz, 2 CPUs, 10 cores/CPU,
20 Threads/CPU.  40 cores total.

For the bare hardware and kvm tests (first chart) the host CPU was:
HiSilicon 1620 CPU 2600 Mhz,  2 CPUs, 64 Cores per CPU, 128 CPUs total.

First, we ran a test of building the kernel in the VM.
We did not see any major improvements nor major regressions.
We show the results of the Speedup of building the kernel
on bare hardware compared with kvm and QEMU (both the baseline and cpu lock=
s).


                   Speedup vs a single thread for kernel build

  40 +---------------------------------------------------------------------=
-+
     |         +         +         +          +         +         +  **    =
 |
     |                                                bare hardwar*********=
 |
     |                                                          kvm #######=
 |
  35 |-+                                                   baseline $$$$$$$=
-|
     |                                                    *cpu lock %%%%%%%=
 |
     |                                                 ***                 =
 |
     |                                               **                    =
 |
  30 |-+                                          ***                     +=
-|
     |                                         ***                         =
 |
     |                                      ***                            =
 |
     |                                    **                               =
 |
  25 |-+                               ***                                +=
-|
     |                              ***                                    =
 |
     |                            **                                       =
 |
     |                          **                                         =
 |
  20 |-+                      **                                          +=
-|
     |                      **                                #########    =
 |
     |                    **                  ################             =
 |
     |                  **          ##########                             =
 |
     |                **         ###                                       =
 |
  15 |-+             *       ####                                         +=
-|
     |             **     ###                                              =
 |
     |            *    ###                                                 =
 |
     |           *  ###                                                    =
 |
  10 |-+       **###                                                      +=
-|
     |        *##                                                          =
 |
     |       ##  $$$$$$$$$$$$$$$$                                          =
 |
     |     #$$$$$%%%%%%%%%%%%%%%%%%%%                                      =
 |
   5 |-+  $%%%%%%                    %%%$%$%$%$%$%$%$%$%$%$%$%$%$%$%$%    +=
-|
     |   %%                                                           %    =
 |
     | %%                                                                  =
 |
     |%        +         +         +          +         +         +        =
 |
   0 +---------------------------------------------------------------------=
-+
     0         10        20        30         40        50        60       =
 70
                                   Guest vCPUs


After seeing these results and the scaling limits inherent in the build its=
elf,
we decided to run a test which might show the scaling improvements clearer.
So we chose unix bench.

               Unix bench result (higher is better) vs number vCPUs.

  3000 +-------------------------------------------------------------------=
-+
       |      +      +      +      +      +     +      +      +      +     =
 |
       |                                                   baseline *******=
 |
       |             #                                     cpu lock #######=
 |
       |           ##*#                                                    =
 |
  2500 |-+        #** *#                                                  +=
-|
       |          #    *#                                                  =
 |
       |         #*    *#                                                  =
 |
       |         #      *#                                                 =
 |
       |        #*       #                                                 =
 |
       |        #        *#                                                =
 |
  2000 |-+     #*         #                                               +=
-|
       |       #          *#                                               =
 |
       |      #*           *#                                              =
 |
       |      #             *####                                          =
 |
       |     #*             *    ###                                       =
 |
  1500 |-+   #               ***    ##                                    +=
-|
       |     #                  *     ##                                   =
 |
       |    #                    *      ###                                =
 |
       |    #                     **       ##                              =
 |
       |    #                       *        ###                           =
 |
       |   #                         *          ##                         =
 |
  1000 |-+ #                          **          #                       +=
-|
       |  #                             *          ###                     =
 |
       |  #                              **           #                    =
 |
       |  #                                *           #                   =
 |
       | #*                                 *           ##                 =
 |
   500 |-#                                   **           #         #     +=
-|
       | #                                     *           #      ## #     =
 |
       |#*                                      *           ##   #    #    =
 |
       |#*                                       **            ##      #   =
 |
       |*                                                     #         #  =
 |
       |*     +      +      +      +      +     +  **********************# =
 |
     0 +-------------------------------------------------------------------=
-+
       0      10     20     30     40     50    60     70     80     90    =
100
                                    Guest vCPUs

We also ran tests to compare the boot times.  This test showed the most
improvements compared to the baseline.

              Boot time in seconds (lower is better) vs number vCPUs.

  550 +--------------------------------------------------------------------=
-+
      |      +      +      +      +      +      +      +      +      +   * =
 |
      |                                                    baseline *******=
 |
  500 |-+                                                  cpu lock #######=
-|
      |                                                              *     =
 |
      |                                                             *      =
 |
      |                                                            *       =
 |
  450 |-+                                                        **      #+=
-|
      |                                                         *       #  =
 |
      |                                            **          *      ##   =
 |
  400 |-+                                         *  **      **      #    +=
-|
      |                                           *    *   **       #      =
 |
      |                                          *       **       ##       =
 |
  350 |-+                                       *       *        #        +=
-|
      |                                         *              ##          =
 |
      |                                        *              #            =
 |
  300 |-+                                     *             ##            +=
-|
      |                                       *            #               =
 |
      |                                      *           ##                =
 |
      |                                     *           #                  =
 |
  250 |-+                                 **           #                  +=
-|
      |                                  *           ##                    =
 |
      |                                **           #                      =
 |
  200 |-+                           ***           ##                      +=
-|
      |                           **           ###                         =
 |
      |                          *         ####                            =
 |
  150 |-+                       *    ######                               +=
-|
      |                     ****  ###                                      =
 |
      |*                   *    ##                                         =
 |
      |#*                #######                                           =
 |
  100 |-#          ***###                                                 +=
-|
      | #*     #######                                                     =
 |
      |  ######     +      +      +      +      +      +      +      +     =
 |
   50 +--------------------------------------------------------------------=
-+
      0      10     20     30     40     50     60     70     80     90    =
100
                                    Guest vCPUs

Pictures are also here:
https://drive.google.com/file/d/1ASg5XyP9hNfN9VysXC3qe5s9QSJlwFAt/view?usp=
=3Dsharing

We will plan to update this commit in the series with the final two results
(unix bench and boot times).

Regards,
-Rob


On Tue, 12 May 2020 at 15:26, Robert Foley <robert.foley@linaro.org> wrote:
>
> On Tue, 12 May 2020 at 12:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> > Robert Foley <robert.foley@linaro.org> writes:
> >
> > > From: "Emilio G. Cota" <cota@braap.org>
> > >
> > > This yields sizable scalability improvements, as the below results sh=
ow.
> > >
> > > Host: Two Intel E5-2683 v3 14-core CPUs at 2.00 GHz (Haswell)
> > >
> > > Workload: Ubuntu 18.04 ppc64 compiling the linux kernel with
> > > "make -j N", where N is the number of cores in the guest.
> > >
> > >                       Speedup vs a single thread (higher is better):
> snip
> > >   png: https://imgur.com/zZRvS7q
> >
> > Can we re-run these numbers on the re-based series?
>
> Sure, we will re-run the numbers.
>
> Regards,
> -Rob

