Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A36BC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210F7206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6fKofYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210F7206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyXRS-0003w1-C0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 05:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyXQt-0003S6-9V
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:22:31 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyXQr-0001gj-En
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:22:30 -0400
Received: by mail-wm1-x341.google.com with SMTP id y24so340707wma.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tT7yrqYh0nkAPmoKJGoXqbnkenT3BD0OrcYRyLMpxFM=;
 b=B6fKofYHkeaOz/FSRfdNsfChN4n0rqmrj+UqkYjnz6il/0aWPWmyWzMv4K1ID8fivJ
 7e8/ffGLhG00HdomE8CTStejbOs69YOnX7SLJKAwOPNKSk+G3Fz38LN3oUf3Uzu6VwqU
 898veoEj5moyHRr7VcEFOonltvqxarp8jRNuYx1Q845hoIIU+EGY+eQoIf44uwgv/pV4
 nMCzVPcs9Ggv49sxP3FNOehzROI9SsIwmj+ZUP5Z+VvEcoDygfdddBB3tDX3+HbZpRl/
 HDqE0EvjOGKcOsrd5ZeI8d8LOP+baO717coWTj78nbyfpyjuSpq7hnxn7UKxjiSz2/Ye
 Iw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tT7yrqYh0nkAPmoKJGoXqbnkenT3BD0OrcYRyLMpxFM=;
 b=kOoHx+wuxwmoE+iVKxsQ0KVsQVoRDPlpC2N0FtTnawB+uZU6Uq6S9tIltxWh5PQpEy
 a4Zr+36ik2h4uR0vVSlWV5MI8SQOdoxeH+D/CELXH257VB8k1yMaNvGNh8gY98KnY3Yc
 xzWc19AJ9kE0j61yUH4TKhGhJ79YxKNUOcFqMx358Q++DNiCskRpqbx56N+fodmb1LJ/
 MmCB7M81ohayv8spJeSz0aIvFvpjel16zMYTdmCn+JJIsfjwd5uIROQPJLnyqtM4Vfoq
 8X8bcS80MOGb9mXnRilPSLExh9cTRd5FVQkKIRiqxuV1JLnMO+ddjc1oGsJR6TDdFllw
 1cug==
X-Gm-Message-State: AOAM530aTNNxHAhQeecYoLOf4PGKMx7IwJnC4qIJcjrWsed64T5mO6gD
 Z0Jj+ibg2MkbzVGCfgEVSBaEIQ==
X-Google-Smtp-Source: ABdhPJxyqX/wqRHGmrKnGEimrj4yfuU4D3Q2h+a1HhS6gad09js7Eig/0dCMWV5R62pb8TSjHf7yrQ==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr3476727wmg.39.1595496147355;
 Thu, 23 Jul 2020 02:22:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm2794608wmf.3.2020.07.23.02.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 02:22:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 432541FF7E;
 Thu, 23 Jul 2020 10:22:25 +0100 (BST)
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-7-alex.bennee@linaro.org>
 <5d26e26f-55f7-5b74-bb9e-b97ea1040c05@linaro.org>
 <87ft9jtsw5.fsf@linaro.org> <20200722163722.GS2324845@redhat.com>
 <0efbcac2-d2f4-de96-63a1-ba7cd485a1e6@linaro.org>
 <20200723090027.GB2615312@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 06/12] accel/tcg: better handle memory constrained
 systems
In-reply-to: <20200723090027.GB2615312@redhat.com>
Date: Thu, 23 Jul 2020 10:22:25 +0100
Message-ID: <87d04mtwku.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: fam@euphon.net, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 f4bug@amsat.org, cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jul 22, 2020 at 12:02:59PM -0700, Richard Henderson wrote:
>> On 7/22/20 9:44 AM, Daniel P. Berrang=C3=A9 wrote:
>> > OpenStack uses TCG in alot of their CI infrastructure for example
>> > and runs multiple VMs. If there's 4 VMs, that's another 4 GB of
>> > RAM usage just silently added on top of the explicit -m value.
>> >=20
>> > I wouldn't be surprised if this pushes CI into OOM, even without
>> > containers or cgroups being involved, as they have plenty of other
>> > services consuming RAM in the CI VMs.
>>=20
>> I would hope that CI would also supply a -tb_size to go along with that =
-m
>> value.  Because we really can't guess on their behalf.
>
> I've never even seen mention of -tb_size argument before myself, nor
> seen anyone else using it and libvirt doesn't set it, so I think
> this is not a valid assumption.
>
>
>> > The commit 600e17b261555c56a048781b8dd5ba3985650013 talks about this
>> > minimizing codegen cache flushes, but doesn't mention the real world
>> > performance impact of eliminating those flushes ?
>>=20
>> Somewhere on the mailing list was this info.  It was so dreadfully slow =
it was
>> *really* noticable.  Timeouts everywhere.
>>=20
>> > Presumably this makes the guest OS boot faster, but what's the before
>> > and after time ?  And what's the time like for values in between the
>> > original 32mb and the new 1 GB ?
>>=20
>> But it wasn't "the original 32MB".
>> It was the original "ram_size / 4", until that broke due to argument par=
sing
>> ordering.
>
> Hmm, 600e17b261555c56a048781b8dd5ba3985650013 says it was 32 MB as the
> default in its commit message, which seems to match the code doing
>
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)

You need to look earlier in the sequence (see the tag pull-tcg-20200228):

  47a2def4533a2807e48954abd50b32ecb1aaf29a

so when the argument ordering broke the guest ram_size heuristic we
started getting reports of performance regressions because we fell back
to that size. Before then it was always based on guest ram size within
the min/max bounds set by those defines.

>> I don't know what CI usually uses, but I usually use at least -m 4G, som=
etimes
>> more.  What's the libvirt default?
>
> There's no default memory size - its up to whomever/whatever creates the
> VMs to choose how much RAM is given.
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

