Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C28C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605D520715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVRLuH6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605D520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jakMJ-0005ga-Bk
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 14:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jakL1-0005CI-EL
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:18:07 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:36050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jakKz-0007nO-5i
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:18:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id k13so10902094wrx.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FJO4qJ67f0bY76ix4YdjsV5Gxks7TV5H6cFHfg1stzs=;
 b=qVRLuH6IE04zHAyve3cjKiMU76cle5F49Kp4q5EnQKnmJ4C8c9+MbuJatDfqy8aQLP
 5qKC7DxSjagnrW4Z/J0EhGml5Z6ugcgrngE9/hv6bXqi+Wbg4ZGxXTwQZGN9MIXvUjkO
 4whugE4yI4eFMpPzcd2i90SBT63YEDYU0wTBG9XDfrWIf8F6v5knQcgCNcICjXRrV7ZA
 QcknuUyTVVPJ6IghOiCi3xD5ARQOjWoyzYZqOVHWLwMN/lwGoNelHDrJl+gF3eTz0BDX
 MjzVLqaCdKaWGm2yzTWwpqtybw9FLXl//gC9HdbUjwoHef6Sph48iJd+UUKAmc4rJ+vl
 Q/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FJO4qJ67f0bY76ix4YdjsV5Gxks7TV5H6cFHfg1stzs=;
 b=qyFmT0GB7RHiRNd3zo9ycZAE+0lTT8/cHJvhPVvOF4jz8OxVcLk5S3kyQyzRtj75Pl
 i4ctxpHdhtkb5BIcJakBy7V67Q6N1AsPgbuJdvDZYohyMczOoLihrQzzDvK3k0RpFSSg
 HdYEPcEc+Ig16ACegXJUPhPBfA6iXoeFmnl6emGdYRGOi6qh9jxw5wWFVbivVJXpzUG9
 PQBpvFqZhrk9My7VfuwkyhlIazZaPXa7qBK9JshqQKa4HgC0tf/AMpM0QbqmVW9Jb8L2
 HTxS2z+bowEfoGCHds4LsPH4Lxu1DvflR7rdl17NIQsBQs0nFO6qDKo/MHSXruOTij3D
 1GRQ==
X-Gm-Message-State: AOAM5339XCBZv0JG/RUAa1gVPEfPydK5kZIzYoEh8SVu29OaHQdWsXAU
 zWvZzPIlGSjcoMQtk071YzwiCw==
X-Google-Smtp-Source: ABdhPJxeK3PGutTNZkiv1QxzKWzQbdWJmKdt+eG3li1zxj+yw/PioGYMx5mlqybYd1feIweTAE/JWQ==
X-Received: by 2002:a05:6000:1107:: with SMTP id
 z7mr20458737wrw.93.1589825883473; 
 Mon, 18 May 2020 11:18:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t82sm491730wmf.10.2020.05.18.11.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 11:18:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B3D681FF7E;
 Mon, 18 May 2020 19:18:01 +0100 (BST)
References: <1b5c9fee-6574-ddf4-b2d0-aa12e6fc9c84@suse.de>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: sharing intention for developing per-target, dynamically
 loadable accelerator modules
In-reply-to: <1b5c9fee-6574-ddf4-b2d0-aa12e6fc9c84@suse.de>
Date: Mon, 18 May 2020 19:18:01 +0100
Message-ID: <87k119jeee.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> Hello all,
>
> my intention would be to develop per-target, dynamically loadable acceler=
ator modules.
>
> This would allow to distribute a single QEMU base binary, and then provid=
e accelerators as optional additional binary packages to install,
> with the first separate optional package being TCG.
>
> CONFIG_TCG would become 'm' as a result, but then also CONFIG_KVM, CONFIG=
_HAX, CONFIG_WHPX, CONFIG_HVF.
>
> Here are some elements that seem to be needed:
>
> 1 - The module CONFIG_MODULE part of the build system would need some ext=
ension to add per-target modules. I have some tentative results that shows =
that this is possible (but a bit clunky atm).
>     There is some existing instability in the existing Makefile infrastru=
cture of modules that shows up when trying to extend it.
>
> 2 - new "accelerator drivers" seems to be needed, either in addition or a=
s additional functionality inside the current AccelState.
>
> 3 - for target/i386 in particular, there is some refactoring work needed =
to split even more different unrelated bits and pieces.
>     dependencies of hw/i386 machine stuff with accelerator-specific
> stuff are also painful.

There are a couple of per-arch hacks in the main TCG cpu loops it would
be good to excise from the code.

>
> 4 - CPU Arch Classes could be extended with per-accelerator methods. Init=
ial fooling around shows it should probably work.
>     One alternative would be trying to play with the dynamic linker (weak=
 symbols, creative use of dlsym etc), but I have not sorted out the details=
 of this option.
>
> 5 - cputlb, in particular tlb_flush and friends is a separate problem
> since it is not part of the cpuclass. Should it be?

tlb_flush and friends are TCG implementation details for softmmu that
ensure a lookup for any address will always return to a guest specific
tlb_fill to rebuild the cache. The behaviour is not guest-specific
per-se although we do partition the table entries based on the guest
size.

Perhaps we can make it more dynamic but it would have to ensure both the
slow path and the fast path are using the same mask and shifts when
walking the table.

> 6 - a painpoint is represented by the fact that in USER mode, the accel c=
lass is not applied, which causes a lot of uncleanliness all around
>     (tcg_allowed outside of the AccelClass).

The user-mode run loops are a whole separate chunk of code. I don't know
if it is worth trying to make them plugable as you will only ever have
one per linux-user binary.

> 7 - I have not really thought about the KConfig aspects because I am not =
super-familiar
>
> 8 - cpus.c needs some good splitting

Although there are several different run loops in there I think they
share a lot of commonality which is why they are bundled together. They
all share the same backend for dealing with ioevents and generic
pause/unpause machinery. But feel free to prove me wrong ;-)

> ... more things to find out and think about ...
>
> Overall, I think that the activity has the potential to provide benefits =
overall beyond the actual goal, in the form of cleanups, leaner configurati=
ons,
> minor fixes, maybe improving the CONFIG_MODULE instabilities if any
> etc.

There are certainly some ugly bits we could shave down in such an
exercise.

> As an example, the first activity I would plan to submit as RFC is point =
8 above,
> there is the split between cpus.c and cpus-tcg.c that results in lots of =
TCG-specific code being removed from non-tcg builds (using CONFIG_TCG).
>
> One thing that should be kept in check is any performance impact of
> the changes, in particular for point 4, hot paths should probably
> avoid going through too many pointer indirections.

Maybe - certainly for TCG you have pretty much lost if you have exited
the main execution loop I doubt it would show up much. Not so sure about
the HW accelerators. Most of the performance sensitive stuff is dealt
with close to the ioctls IIRC.

> Does anybody share similar goals? Any major obstacle or blocker that woul=
d put the feasibility into question?
> Any suggestion on any of this? In particular point 4 and 5 come to
> mind, as well as some better understanding of the reasons behind 6, or
> even suggestions on how to best to 2.

For linux-user each CPU run loop is it's own special snowflake because
pretty much every architecture has it's own special set of EXCP_ exits
to deal with various bits. There are per-arch EXCP_ flags for system
emulation as well but not nearly as many.

>
> Anyway, I will continue to work on the first RFC for some smaller initial=
 steps and hopefully have something to submit soon.
>
> Ciao ciao,
>
> Claudio


--=20
Alex Benn=C3=A9e

