Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83078C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8F62075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tg5TkvMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8F62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRyE-00084Y-Gc
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 15:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnRx2-0006jw-H9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:17:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnRx0-0006aC-JE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:17:52 -0400
Received: by mail-ot1-x344.google.com with SMTP id e5so14028902ote.11
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Bphi//UCJWdgiGIhoGNfVCxrpEYRFAwyzF+EmT3tJeg=;
 b=Tg5TkvMXO7Y4qbxIaCt0ipCycnU2B0H33p1vr9oyp7ldMU8O//q1DAAhVQX/SjupvU
 9Rbacppft0QJ/xpduHWeGR2/In0Njssij+EXywpxTXg7RshvEa7EzRrDlqVlAd0k3ptH
 bzRnNLgSV8+FiAy1TsDi4dUD5IfjnGhxLRbOqLN5MaSDm5OUMjzzj9lHahCI+2Cv6lxm
 PDeacrS9LRJmzaRPx1n9fdacL1WgquttaJGL+PGeLvcR5SNM3+X9LpQe3u0n0B+Rh4OH
 /diyQ8Wy6VayC9G19lZpq576DCPuUtxExiUwPIsKgrfYIO+jXjelBxX66vQsez7I+KM0
 gh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bphi//UCJWdgiGIhoGNfVCxrpEYRFAwyzF+EmT3tJeg=;
 b=E7BZS9GxuBRn5LRMNKumvaozpZQlxGqxpuzvtGvs3T702Nyd1hbQQrLsyz5ZYViIAf
 9OOInRcJ6gWWJg0PT5l3S1X270XxdqRT0b2OvLxymDUezzLDh+FgHJjumwDf88ULKdP1
 qaZL9mItXXbuY83Pp1GON29NOOy5TxrwmheJXvCRp+f7QjMXOXOnhniq9TAIsoSlSvCQ
 yEl7Axb3PME5heICqICDj7VCav3v1HBwH/M2D38dWP975NjKtIk5DClE1TU66rm1E3xv
 sN4x4PnB+dHh61sllgixZdYIWuvScprc9J2iSeRWytEYrsJyCiowzp0fBnuSBwoQCAzQ
 bqkQ==
X-Gm-Message-State: AOAM5323V12uzAJn8+BViPuKMaThRIYTmuZhJEuVGZj8b7/Yr8APBapS
 5VgXGw4laWqhWSROPp2V3EGRTbLhCX/OhJHQ7iuCdg==
X-Google-Smtp-Source: ABdhPJwpXtFuR8fkRN67XlXHmgIWLp+Srzw0q0TpZ6ylSVdaYzgIY4x3QRSJAHr2yJBkW/tOPvFh5ucVYE39StMgVwM=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr4666605oop.20.1592853468697; 
 Mon, 22 Jun 2020 12:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200522023440.26261-1-richard.henderson@linaro.org>
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2020 20:17:37 +0100
Message-ID: <CAFEAcA_rnDDCTBQDEfbx5qzFFmkyeo9D_NdEC-v52i3wgKjApw@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] risu cleanups and improvements
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just a note that I'm assuming this is still on Alex's plate to review.
Ping me if it gets reviews and is ready to apply.

thanks
-- PMM

On Fri, 22 May 2020 at 03:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 3 changes the --dump option to --fulldump and --diffdump,
> after an off-hand suggestion by Alex.
>
> These are now mode options, similar to --master.  Which means that
> dumping is an orthogonal apprentice type, which means that we can
> dump from a socket.  I'm not sure that will be useful as such, but
> I think it makes main be a bit cleaner.
>
> If using old trace files with the new risu, you get
>
>   Unexpected magic number: 0x000078
>
> If for somehow you use different risu for master and apprentice on
> sockets, the apprentice will hang waiting for data that the master
> will never write.  This is less than helpful, but should be trivial
> to avoid.
>
> While cleaning up the interface for reginfo_dump_mismatch(), I
> noticed some bugs on the ppc64 side.
>
> The patches without reviews are:
>
> 0014-Merge-reginfo.c-into-risu.c.patch
> 0015-Rearrange-reginfo-and-memblock-buffers.patch
> 0016-Split-out-recv_register_info.patch
> 0017-Add-magic-and-size-to-the-trace-header.patch
> 0018-Compute-reginfo_size-based-on-the-reginfo.patch
> 0019-aarch64-Reorg-sve-reginfo-to-save-space.patch
> 0020-aarch64-Use-arch_init-to-configure-sve.patch
> 0021-ppc64-Use-uint64_t-to-represent-double.patch
> 0022-Standardize-reginfo_dump_mismatch-printing.patch
> 0023-Add-fulldump-and-diffdup-options.patch
> 0024-Remove-return-value-from-reginfo_dump.patch
> 0025-ppc64-Clean-up-reginfo-handling.patch
>
> most of which are new, and those that aren't new have had
> significant modifications.
>
>
> r~
>
>
> Richard Henderson (25):
>   Use bool for tracing variables
>   Unify master_fd and apprentice_fd to comm_fd
>   Hoist trace file and socket opening
>   Adjust tracefile open for write
>   Use EXIT_FAILURE, EXIT_SUCCESS
>   Make some risu.c symbols static
>   Add enum RisuOp
>   Add enum RisuResult
>   Unify i/o functions and use RisuResult
>   Pass non-OK result back through siglongjmp
>   Always write for --master
>   Simplify syncing with master
>   Split RES_MISMATCH for registers and memory
>   Merge reginfo.c into risu.c
>   Rearrange reginfo and memblock buffers
>   Split out recv_register_info
>   Add magic and size to the trace header
>   Compute reginfo_size based on the reginfo
>   aarch64: Reorg sve reginfo to save space
>   aarch64: Use arch_init to configure sve
>   ppc64: Use uint64_t to represent double
>   Standardize reginfo_dump_mismatch printing
>   Add --fulldump and --diffdup options
>   Remove return value from reginfo_dump
>   ppc64: Clean up reginfo handling
>
>  Makefile               |   2 +-
>  risu.h                 | 103 +++----
>  risu_reginfo_aarch64.h |  16 +-
>  risu_reginfo_ppc64.h   |   3 +-
>  comms.c                |  34 +--
>  reginfo.c              | 183 -----------
>  risu.c                 | 676 ++++++++++++++++++++++++++++++-----------
>  risu_aarch64.c         |   6 +-
>  risu_arm.c             |   6 +-
>  risu_i386.c            |   4 +-
>  risu_m68k.c            |   4 +-
>  risu_ppc64.c           |   4 +-
>  risu_reginfo_aarch64.c | 212 +++++++------
>  risu_reginfo_arm.c     |  32 +-
>  risu_reginfo_i386.c    |  22 +-
>  risu_reginfo_m68k.c    |  37 +--
>  risu_reginfo_ppc64.c   | 183 +++++------
>  17 files changed, 803 insertions(+), 724 deletions(-)
>  delete mode 100644 reginfo.c
>
> --
> 2.20.1

