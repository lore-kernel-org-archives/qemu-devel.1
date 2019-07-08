Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF11C606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01F121479
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMU+3QNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01F121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkU76-0002yh-NQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 09:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60227)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkU6b-0002ZU-TX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkU6a-0000Le-8U
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:54:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkU6Z-0000Ip-Tq
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:54:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id n5so16292437otk.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=FfVzBSYimixQ3rekhUE+RC8BfTRQKR8Q6zHyHJcs/i4=;
 b=LMU+3QNvcyQBD1zdFHbHeZfzB9qj5ADd20nLcSzdAhumNA0lr7Rigp+KYsQuHLDFDp
 Ym/bDX0YCl+z0G5Rw4JR45MSAbQAhVqOlmdfzEkq0N20xsNPwpkLM5i3xWJkMb/9rzW6
 6joP2S2aZVBWztEGm5bP5GRyn1+RTap5jtlPgIi1S0+4y9tNgsov0Ak1YpK3M8HjnxNO
 Ji+DIZbwbIMZZ6dZWnneO6Sey6IFHfjrh45dO2vP6n0Umbey2uDcA0qYkKHLX9swD2gM
 Jo544rUtIUJ2YBXcCrPUE+zoAO8KQUXoAx4/50Bga8D/I6SjFvruesYUUgSOqi07V8K2
 DDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=FfVzBSYimixQ3rekhUE+RC8BfTRQKR8Q6zHyHJcs/i4=;
 b=rV3WcUKVCzg4ra3krBZpIY9NgIj8qH2vcdNdJ7H4YJlamdxPuQx1F5cdHU6NM4hpTN
 CrAljULV+nkjiyCPzziTbHCxMBciPf6VSQqnS5lpxrnhMONKSVP8Oy8JXe39mkA50efD
 FCoXSwiLB+2zQiFs58Dz7Ax1vjVQVDWneGdx0j78I/kAep93Ep4s+xAuWBcsQ/G/QWHt
 cmQZLNj9V/F/ywxOcZqRISH+0hIHkHmJwrkM7AZ2DJk8ykO6bl1xCfUyek7x3bp5Litl
 yeZWLQvWOvbI3SonTgnyW8TI33EhaHjnMnqlN9h8y735uDi8e2jjFdAHhHcEcGcmOT0M
 Z6aw==
X-Gm-Message-State: APjAAAXReJ9cOuoc3EJOJ4tbHWY0NqixeAWoqj8PfFFuXboVcyvk1krN
 OTYYHI4Yh6SGPu0f+rr+4SM320XkF/NzQ0L5UBwzXODIZhs=
X-Google-Smtp-Source: APXvYqy303iZY+u6riMkOhE+v2b9D5VJwY8B1hk40cc5zi1Z4baFHCqPhv4r/58dmySDRAln00dtaXlrppfMC/7vI0Y=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr15099358oti.91.1562594092915; 
 Mon, 08 Jul 2019 06:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190708132237.7911-1-peter.maydell@linaro.org>
In-Reply-To: <20190708132237.7911-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2019 14:54:42 +0100
Message-ID: <CAFEAcA_JwDw3-+ZMj91rDKyAp_yYxSXE9O87KeNAMhFqybbcsQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 0/4] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jul 2019 at 14:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> A last handful of patches before the rc0. These are all bugfixes
> so they could equally well go into rc1, but since my pullreq
> queue is otherwise empty I might as well push them out. The
> FPSCR bugfix is definitely one I'd like in rc0; the rest are
> not really user-visible I think.
>
> thanks
> -- PMM
>
> The following changes since commit c4107e8208d0222f9b328691b519aaee4101db87:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-07-08 10:26:18 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190708
>
> for you to fetch changes up to 85795187f416326f87177cabc39fae1911f04c50:
>
>   target/arm/vfp_helper: Call set_fpscr_to_host before updating to FPSCR (2019-07-08 14:11:31 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * tests/migration-test: Fix read off end of aarch64_kernel array
>  * Fix sve_zcr_len_for_el off-by-one error
>  * hw/arm/sbsa-ref: Silence Coverity nit
>  * vfp_helper: Call set_fpscr_to_host before updating to FPSCR


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

