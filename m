Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679C6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3270720776
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdSxOXp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3270720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnj1X-0006Wt-EZ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnj0i-0005k1-Mw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:30:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnj0g-0005aQ-DX
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:30:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id a6so18576962wrm.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=P8AvI8HbzK+L8zovyI39nsM8VepvkJa2ACLyLvmB8B8=;
 b=OdSxOXp4c+khGVuYcO0+X1mosB3NJUtkyXM0VWVJhAT89DToi7ojOurujuoRB+K/OG
 Paurwg9klX5hfrpAmTpSNuq29+NjS+vOOoXPH6hdGEqJQB2SWu42H/ANfrPO3MvdF1Lb
 WH6XStDqk4flzZT1CoUNND+iD38AFbOEXGQSaudAJUVqAaQrzLIzRpwRM++k6UITseXZ
 AG91Fhg8KeR83ADtMIx3yfw2CouLVB2J4/DlfKG4vDMK6tdFvSLrGGS42F0U0YQWpDFG
 n2fV858aTcS7O0MdgFmuhqVjir0bGsQuOzDesl9V3p3gHWVAXIkIW925IBfKftPX/N/5
 lI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=P8AvI8HbzK+L8zovyI39nsM8VepvkJa2ACLyLvmB8B8=;
 b=moZw63PN+tIvZOvIEYAgye6akPPwIogb0yiR0XAQzsgB2ncJdAAOcO9hYxPRVqTVF8
 QZxPLR7AaLLdPA7k6k5w3XDLke7x4/JZHbfbSoMgAK3oARktyqDe94QUHw+hucpQOyKX
 4oGbsqhZPj23/mHw9qEQED1nfp3ehxvEAZvg9upqOHvVosP/oNnSNKikMHdyS2word9L
 ecYH/YUmGklpulbk9n80etILJ3yZq3r/+DZHkiVI1UP4orSplUzpgor7socGo8Xdp/f8
 VVtUky8q6zPdPpYJH1pvbGe0vmgGqVTz9Ers/ez71xL6WAt9E15Xcawi0iy5Pz880ih8
 4xTw==
X-Gm-Message-State: AOAM531srHmHmm99hhS8K0z5fSUf42u20U3kxvyDbG79Lt7KVjf78LPZ
 Y8cms1iZbnFMueATVQyW8BQDhw==
X-Google-Smtp-Source: ABdhPJy+Ox3MPoJ3Rmcx4qDDjZCupPNrJAXEr+aaP8IlI6bb0fMu+DqGiCcG2SQY+Y41WU0ypMUdWA==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr24365718wrn.373.1592919044588; 
 Tue, 23 Jun 2020 06:30:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm25542692wrh.54.2020.06.23.06.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 06:30:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DA0111FF7E;
 Tue, 23 Jun 2020 14:30:42 +0100 (BST)
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <87v9ji88cj.fsf@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 00/25] risu cleanups and improvements
In-reply-to: <87v9ji88cj.fsf@linaro.org>
Date: Tue, 23 Jun 2020 14:30:42 +0100
Message-ID: <87mu4t9af1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> Version 3 changes the --dump option to --fulldump and --diffdump,
>> after an off-hand suggestion by Alex.
>>
>> These are now mode options, similar to --master.  Which means that
>> dumping is an orthogonal apprentice type, which means that we can
>> dump from a socket.  I'm not sure that will be useful as such, but
>> I think it makes main be a bit cleaner.
>
> Hmm recording traces I ran into a difference, need to track down if its
> a master or apprentice bug (both are native):
>
>   ./builds/arm64/risu aarch64-all-v8dot0/insn_LDAPR__INC.risu.bin -t aarc=
h64-all-v8dot0/insn_LDAPR__INC.risu.bin.trace
>
> fails with:
>
>   loading test image aarch64-all-v8dot0/insn_LDAPR__INC.risu.bin...
>   starting apprentice image at 0xffff8548c000
>   starting image
>   Mismatch reg after 4 checkpoints
>   master reginfo:
>   faulting insn 38bfc1f4
>   .
>   .
>   .
>   mismatch detail (master : apprentice):
>     X15    : 0000ffff9eba41dc vs 0000ffff8548c1dc

This is sort of bogus due to LDAPR being a v8.3 instruction so we fault
and x15 is a pointer into the memblock which isn't stable. If it had
executed we would have nixed the absolution address to and offset before
the OP_COMPARE.

I think for OP_SIGILL the only thing that can be truly valid would be to
compare PCs so we can check the apprentice also faults on the same SIGILL?

>
>>
>> If using old trace files with the new risu, you get
>>
>>   Unexpected magic number: 0x000078
>>
>> If for somehow you use different risu for master and apprentice on
>> sockets, the apprentice will hang waiting for data that the master
>> will never write.  This is less than helpful, but should be trivial
>> to avoid.
>>
>> While cleaning up the interface for reginfo_dump_mismatch(), I
>> noticed some bugs on the ppc64 side.
>>
>> The patches without reviews are:
>>
>> 0014-Merge-reginfo.c-into-risu.c.patch
>> 0015-Rearrange-reginfo-and-memblock-buffers.patch
>> 0016-Split-out-recv_register_info.patch
>> 0017-Add-magic-and-size-to-the-trace-header.patch
>> 0018-Compute-reginfo_size-based-on-the-reginfo.patch
>> 0019-aarch64-Reorg-sve-reginfo-to-save-space.patch
>> 0020-aarch64-Use-arch_init-to-configure-sve.patch
>> 0021-ppc64-Use-uint64_t-to-represent-double.patch
>> 0022-Standardize-reginfo_dump_mismatch-printing.patch
>> 0023-Add-fulldump-and-diffdup-options.patch
>> 0024-Remove-return-value-from-reginfo_dump.patch
>> 0025-ppc64-Clean-up-reginfo-handling.patch
>>
>> most of which are new, and those that aren't new have had
>> significant modifications.
>>
>>
>> r~
>>
>>
>> Richard Henderson (25):
>>   Use bool for tracing variables
>>   Unify master_fd and apprentice_fd to comm_fd
>>   Hoist trace file and socket opening
>>   Adjust tracefile open for write
>>   Use EXIT_FAILURE, EXIT_SUCCESS
>>   Make some risu.c symbols static
>>   Add enum RisuOp
>>   Add enum RisuResult
>>   Unify i/o functions and use RisuResult
>>   Pass non-OK result back through siglongjmp
>>   Always write for --master
>>   Simplify syncing with master
>>   Split RES_MISMATCH for registers and memory
>>   Merge reginfo.c into risu.c
>>   Rearrange reginfo and memblock buffers
>>   Split out recv_register_info
>>   Add magic and size to the trace header
>>   Compute reginfo_size based on the reginfo
>>   aarch64: Reorg sve reginfo to save space
>>   aarch64: Use arch_init to configure sve
>>   ppc64: Use uint64_t to represent double
>>   Standardize reginfo_dump_mismatch printing
>>   Add --fulldump and --diffdup options
>>   Remove return value from reginfo_dump
>>   ppc64: Clean up reginfo handling
>>
>>  Makefile               |   2 +-
>>  risu.h                 | 103 +++----
>>  risu_reginfo_aarch64.h |  16 +-
>>  risu_reginfo_ppc64.h   |   3 +-
>>  comms.c                |  34 +--
>>  reginfo.c              | 183 -----------
>>  risu.c                 | 676 ++++++++++++++++++++++++++++++-----------
>>  risu_aarch64.c         |   6 +-
>>  risu_arm.c             |   6 +-
>>  risu_i386.c            |   4 +-
>>  risu_m68k.c            |   4 +-
>>  risu_ppc64.c           |   4 +-
>>  risu_reginfo_aarch64.c | 212 +++++++------
>>  risu_reginfo_arm.c     |  32 +-
>>  risu_reginfo_i386.c    |  22 +-
>>  risu_reginfo_m68k.c    |  37 +--
>>  risu_reginfo_ppc64.c   | 183 +++++------
>>  17 files changed, 803 insertions(+), 724 deletions(-)
>>  delete mode 100644 reginfo.c


--=20
Alex Benn=C3=A9e

