Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775CAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432092065E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtTNDzVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432092065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyY8K-0000oP-JA
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyY7l-0000N7-HR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:06:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyY7j-0000pH-JZ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:06:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id f1so4028786wro.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eeyErrRN2ViW9iVTFlxtZWFnrr+zF83BzQsjrUgB83o=;
 b=AtTNDzVqTOKTe8J7uAPFJmR389vHFG+QJG5rzAj7n/KDleyj9yhW9TmFd/QG43Nodp
 F1AWkZ6ELbjS82gtmwS24QsEKuSYcqP6D7Az6klXQyP5KGz2wHX0DY80pu9Se7VkJimV
 rZaCPGD6DF9B7I01yrvPRiwYgwvOH3gNIY1KTa/Hfc4YVD6sjodE/wkgZnZ3Lvmg88YM
 0Niqvyo+Cm1nj775/CZsl88bT/gcOYKM4aRgXf5CUmIfnCe4/be1HfDruOhQXN9cJGgx
 V0gPl2qo6ELBeKwwTI1ljDolYsurC5397fBk20bRFJ88zIIXO6o28SFdM9EYcJd67Dkw
 z9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eeyErrRN2ViW9iVTFlxtZWFnrr+zF83BzQsjrUgB83o=;
 b=VzLeib2VbexQ4LG3JGQ0hak7B1EfM+NfMXv0lnCVjeDdPTfYp+N8PBXOjh7zzXRIsW
 ZYl+9nIEloBU+M/IuQVPu+EZFMwt1IqCBWIRa8t3em8mnWxUkScSF0oxtSZ+icpt9xdx
 pDodiZCeEQvs+Nx6YQaYygrvxwyjusHC0Zl6JpRyZscZUdXFbXSXP2LbTAI8C2cgTfpO
 uszASfuveXx9927fhbBz92roEz0vOD5eTY0qQE+nMDh7Ez2VgBaerpr3JQ4ABmPL33mH
 SwbH+s5Tfo0uFNAIKj5bcap1pk9lQD9lUGMJstfBIWrWQps8rJBaNTUr5ZTGmu2s5QQ4
 rX4A==
X-Gm-Message-State: AOAM531qV4ghLvXSQDuD9AvZMIJ3b/gYxdJf+jO8jQ/NqnVIn6+FwSMD
 pGUFs0O6DRsq+H16XIJrtEakjQ==
X-Google-Smtp-Source: ABdhPJxdtKL7kNyMw9X1DCALcVOYnu+XxDFxafxwwc5fOYLvVyNoY07UnMmE2U1WH7M0LS/5MziJAw==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr3320657wrr.259.1595498805702; 
 Thu, 23 Jul 2020 03:06:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f17sm3303122wme.14.2020.07.23.03.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 03:06:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D54DE1FF7E;
 Thu, 23 Jul 2020 11:06:43 +0100 (BST)
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-7-alex.bennee@linaro.org>
 <5d26e26f-55f7-5b74-bb9e-b97ea1040c05@linaro.org>
 <87ft9jtsw5.fsf@linaro.org> <20200722163722.GS2324845@redhat.com>
 <0efbcac2-d2f4-de96-63a1-ba7cd485a1e6@linaro.org>
 <20200723090027.GB2615312@redhat.com> <87d04mtwku.fsf@linaro.org>
 <20200723093108.GD2615312@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 06/12] accel/tcg: better handle memory constrained
 systems
In-reply-to: <20200723093108.GD2615312@redhat.com>
Date: Thu, 23 Jul 2020 11:06:43 +0100
Message-ID: <87a6zqtuj0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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

> On Thu, Jul 23, 2020 at 10:22:25AM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Wed, Jul 22, 2020 at 12:02:59PM -0700, Richard Henderson wrote:
>> >> On 7/22/20 9:44 AM, Daniel P. Berrang=C3=A9 wrote:
>> >> > OpenStack uses TCG in alot of their CI infrastructure for example
>> >> > and runs multiple VMs. If there's 4 VMs, that's another 4 GB of
>> >> > RAM usage just silently added on top of the explicit -m value.
>> >> >=20
>> >> > I wouldn't be surprised if this pushes CI into OOM, even without
>> >> > containers or cgroups being involved, as they have plenty of other
>> >> > services consuming RAM in the CI VMs.
>> >>=20
>> >> I would hope that CI would also supply a -tb_size to go along with th=
at -m
>> >> value.  Because we really can't guess on their behalf.
>> >
>> > I've never even seen mention of -tb_size argument before myself, nor
>> > seen anyone else using it and libvirt doesn't set it, so I think
>> > this is not a valid assumption.
>> >
>> >
>> >> > The commit 600e17b261555c56a048781b8dd5ba3985650013 talks about this
>> >> > minimizing codegen cache flushes, but doesn't mention the real world
>> >> > performance impact of eliminating those flushes ?
>> >>=20
>> >> Somewhere on the mailing list was this info.  It was so dreadfully sl=
ow it was
>> >> *really* noticable.  Timeouts everywhere.
>> >>=20
>> >> > Presumably this makes the guest OS boot faster, but what's the befo=
re
>> >> > and after time ?  And what's the time like for values in between the
>> >> > original 32mb and the new 1 GB ?
>> >>=20
>> >> But it wasn't "the original 32MB".
>> >> It was the original "ram_size / 4", until that broke due to argument =
parsing
>> >> ordering.
>> >
>> > Hmm, 600e17b261555c56a048781b8dd5ba3985650013 says it was 32 MB as the
>> > default in its commit message, which seems to match the code doing
>> >
>> >  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
>>=20
>> You need to look earlier in the sequence (see the tag pull-tcg-20200228):
>>=20
>>   47a2def4533a2807e48954abd50b32ecb1aaf29a
>>=20
>> so when the argument ordering broke the guest ram_size heuristic we
>> started getting reports of performance regressions because we fell back
>> to that size. Before then it was always based on guest ram size within
>> the min/max bounds set by those defines.
>
> Ah I see. That's a shame, as something based on guest RAM size feels like
> a much safer bet for a default heuristic than basing it on host RAM
> size.

It was a poor heuristic because the amount of code generation space you
need really depends on the amount of code being executed and that is
more determined by workload than RAM size. You may have 4gb of RAM
running a single program with a large block cache or 128Mb of RAM but
constantly swapping code from a block store which triggers a
re-translation every time.

Also as the translation cache is mmap'ed it doesn't all have to get
used. Having spare cache isn't too wasteful.

> I'd probably say that the original commit which changed the argument
> processing is flawed, and could/should be fixed.

I'd say not - we are not trying to replace/fix the original heuristic
but introduce a new one to finesse behaviour in relatively resource
constrained machines. Nothing we do can cope with all the potential
range of invocations of QEMU people might do. For that the user will
have to look at workload and tweak the tb-size control. The default was
chosen to make the "common" case of running a single guest on a users
desktop work at a reasonable performance level. You'll see we make that
distinction in the comments between system emulation and for example
linux-user where it's much more reasonable to expect multiple QEMU
invocations.

> The problem that commit was trying to solve was to do validation of the
> value passed to -m. In fixing that it also moving the parsing. The key
> problem here is that we need to do parsing and validating at different
> points in the startup procedure.  IOW, we need to split the logic, not
> simply moving the CLI parsing to the place that makes validation work.
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

