Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A3DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D86620739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0zQO17Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D86620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6jv-00062j-Gj
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw6jA-0005TD-Tm
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:27:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw6j8-0004GQ-LH
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:27:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id z15so7695473wrl.8
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vDtARsmY3niaPJAe2myiX/B5FPuP/RZKyTd5eJaDnIg=;
 b=O0zQO17Yf+Rz9lJ8pcj+NkFxNvWwPo12uDPTNqCqaUVkpHOJZMWZ3D00wPhRaZZt3Z
 1EPdzDKdReebmlIxguFnHtrelDMLYSip+sPY3mom6+Brz49wxXB8xFT2OjSSnTXFf6DO
 UzKonzMh/4HGE583RS8fzS9qep2ernwdGBfKEn9cZ4JMjHl8eFrJ4Rjp615lMp2fhx+9
 sO/s0LfbgOmMadWeXt7S0uZ0FPtA9b5fnmwjTOFrTpZvpfifeaLEWM45hNfJE4WP2FtB
 XbAnxmgfvFtpxFq96lxNEvGo9HhREzdWfjqJUW4jsV8qWH2ZFhmEo2Pn1CWeto7QJS0M
 Whyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vDtARsmY3niaPJAe2myiX/B5FPuP/RZKyTd5eJaDnIg=;
 b=alfoLn9yb+nezJTmYwEbB10NcFAQc2m/zT94IEHRGcrbGoIrUPSb+DZt42fHX0qB9R
 XrORbbRMPIUwmkozEhMIMAtVymyV3bfTjGxJWM81UvkQ+WNZHuwkAI+Qi72WcEEu4M4I
 PbmZko2KSS92JNONG259iQ3q7aICdscG+uwcjO49ZZ8VPC3HQ6GbhG8pgvDL5ZJKxzTU
 hV5voGQotY8TWU2/oaSHF3wrcPXopnug8RYpLdcl8v7YXmNLhP7/jlAF4IGqthzUxL1Q
 ZapzisWapmh/1NpLWqsiKv4sKNMmT15RE1GBuANAiihUIY/YWRqwW3h02QACaqMDfoR+
 T1Ww==
X-Gm-Message-State: AOAM533dojC79cLnxTcHj3XaKyLFdilG0ThZma/r4NkPTitFbxtNEUEn
 z48LYdXS861TJ/F29LilzumgAQ==
X-Google-Smtp-Source: ABdhPJzgQ41JkcnRH0MXmJxt96NkJ3KcCdSGLj6+yhUmXBofxDZDjrBbrg3soF/F0J/xiTz3okOv/g==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr5946610wrt.67.1594916836879;
 Thu, 16 Jul 2020 09:27:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm10857079wrh.54.2020.07.16.09.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 09:27:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E61281FF7E;
 Thu, 16 Jul 2020 17:27:14 +0100 (BST)
References: <CAATJJ0JDs78irZYRA7-wBefZhmTFK7SpCecuq79Ub-8n1jfy3A@mail.gmail.com>
 <alpine.LMD.2.03.2007151755360.31652@eik.bme.hu>
 <CAATJJ0L2V5QgPHoJW25HrT1_4_YhZJOLS=jFdCU6+JkHFG_MbA@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Re: TB Cache size grows out of control with qemu 5.0
In-reply-to: <CAATJJ0L2V5QgPHoJW25HrT1_4_YhZJOLS=jFdCU6+JkHFG_MbA@mail.gmail.com>
Date: Thu, 16 Jul 2020 17:27:14 +0100
Message-ID: <871rlbwhlp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Christian Ehrhardt <christian.ehrhardt@canonical.com> writes:

> On Wed, Jul 15, 2020 at 5:58 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
>> See commit 47a2def4533a2807e48954abd50b32ecb1aaf29a and the next two
>> following it.
>>
>
> Thank you Zoltan for pointing out this commit, I agree that this seems to=
 be
> the trigger for the issues I'm seeing. Unfortunately the common CI host s=
ize
> is 1-2G. For example on Ubuntu Autopkgtests 1.5G.
> Those of them running guests do so in 0.5-1G size in TCG mode
> (as they often can't rely on having KVM available).
>
> The 1G TB buffer + 0.5G actual guest size + lack of dynamic downsizing
> on memory pressure (never existed) makes these systems go OOM-Killing
> the qemu process.

Ooops. I admit the assumption was that most people running system
emulation would be doing it on beefier machines.

> The patches indicated that the TB flushes on a full guest boot are a
> good indicator of the TB size efficiency. From my old checks I had:
>
> - Qemu 4.2 512M guest with 32M default overwritten by ram-size/4
> TB flush count      14, 14, 16
> - Qemu 5.0 512M guest with 1G default
> TB flush count      1, 1, 1
>
> I agree that ram/4 seems odd, especially on huge guests that is a lot
> potentially wasted. And most environments have a bit of breathing
> room 1G is too big in small host systems and the common CI system falls
> into this category. So I tuned it down to 256M for a test.
>
> - Qemu 4.2 512M guest with tb-size 256M
> TB flush count      5, 5, 5
> - Qemu 5.0 512M guest with tb-size 256M
> TB flush count      5, 5, 5
> - Qemu 5.0 512M guest with 256M default in code
> TB flush count      5, 5, 5
>
> So performance wise the results are as much in-between as you'd think fro=
m a
> TB size in between. And the memory consumption which (for me) is the actu=
al
> current issue to fix would be back in line again as expected.

So I'm glad you have the workaround.=20

>
> So on one hand I'm suggesting something like:
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -944,7 +944,7 @@ static void page_lock_pair(PageDesc **re
>   * Users running large scale system emulation may want to tweak their
>   * runtime setup via the tb-size control on the command line.
>   */
> -#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (256 * MiB)

The problem we have is any number we pick here is arbitrary. And while
it did regress your use-case changing it again just pushes a performance
regression onto someone else. The most (*) 64 bit desktop PCs have 16Gb
of RAM, almost all have more than 8gb. And there is a workaround.

* random number from Steams HW survey.

>  #endif
>  #endif
>
> OTOH I understand someone else might want to get the more speedy 1G
> especially for large guests. If someone used to run a 4G guest in TCG the
> TB Size was 1G all along.
> How about picking the smaller of (1G || ram-size/4) as default?
>
> This might then look like:
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -956,7 +956,12 @@ static inline size_t size_code_gen_buffe
>  {
>      /* Size the buffer.  */
>      if (tb_size =3D=3D 0) {
> -        tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        unsigned long max_default =3D (unsigned long)(ram_size / 4);
> +        if (max_default < DEFAULT_CODE_GEN_BUFFER_SIZE) {
> +            tb_size =3D max_default;
> +        } else {
> +           tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        }
>      }
>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>          tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;
>
> This is a bit more tricky than it seems as ram_sizes is no more
> present in that context but it is enough to discuss it.
> That should serve all cases - small and large - better as a pure
> static default of 1G or always ram/4?

I'm definitely against re-introducing ram_size into the mix. The
original commit (a1b18df9a4) that broke this introduced an ordering
dependency which we don't want to bring back.

I'd be more amenable to something that took into account host memory and
limited the default if it was smaller than a threshold. Is there a way
to probe that that doesn't involve slurping /proc/meminfo?

>
> P.S. I added Alex being the Author of the offending patch and Richard/Pao=
lo
> for being listed in the Maintainers file for TCG.


--=20
Alex Benn=C3=A9e

