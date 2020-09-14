Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F43C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E1A22252
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ueYPj2tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E1A22252
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnJ0-0005Nw-Na
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHnIS-0004xX-H1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:09:24 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHnIQ-0005jR-PN
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:09:24 -0400
Received: by mail-ed1-x541.google.com with SMTP id i1so17346071edv.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CfaHevMu4ag6B3b+RZBZT+nMGG1E5oS5IDwTPtCrOro=;
 b=ueYPj2tUb1YIksW8FtQz9Zn2S7EVNyniiX0odeoPFTAA4o1yuz/p715kn9BniDNc5u
 mNleRLv1iuSLu0Jo2gUGPioXCtW1ht3Bd8Dh0KVJtCEHeZKqz9+eu6vIAOyxcfns7DWe
 xdeaRap6yVlLtU7PTSTfU5ZGoDGHj6l/Nn82RaG+hcd1NUMzVJhsbogTSySYtbVFjYfw
 CxmA/tgYZg1Ftp1VhLdPw4xKLQUyfNBV7S7xklQU3hE2s4Hq+HstBAlQavHsZpOJU3No
 cCLXHo3vH1kJ9jc22ReRX+UAxxh1vZa48ChVNHM5QjXpDIyuUrb+MQ+1b15MUjgmXLc9
 diYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CfaHevMu4ag6B3b+RZBZT+nMGG1E5oS5IDwTPtCrOro=;
 b=OIeIn45xwjdb9jnWzI4M2t6adme6/1I22Xej2cnBUjn6ymGOvGHIcksEt/JOzL5JJP
 KmBEmNmqsN5C9jbfgKLbxfTOfJ7K6uPW0jLQ6EWYS3eZZg2zc7PLN35C1lna5BHlg5k3
 2M+tpK9K7s7Xmb8Q9aZaakfe52rExWE8A9NTvOGWG6b7qK0qNfgRESQJ89QzppWcaKov
 nceG227IDCKz+neR/0lQYfFvS6d+AzygYa0/LfF/cwv3XRThuQPgBpFal85mcVhvCxjf
 sVus9ySsmejFjQP1fd5oR9Oe6i02t6cQG8usEac+KE5S83/OWKhc0l+rlGTdMc9sdrpA
 e9Ig==
X-Gm-Message-State: AOAM531YRzoN3ewQ0DCqJpNpPiScZHdfxvYD7e2yRGTzyQL6bqatWMgy
 9d7itpKe1M3GS/e0eAV1NX3pCIM1LnCwbRb2Qiq5aA==
X-Google-Smtp-Source: ABdhPJw4TnfBzb9etvafymd4VqKSg/ZT80Au+nylFXNLdUN94hvyjqQ5UQMC75eHA8H0FpbJlt/uxE0nwDXOMVDzKsc=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr17466945edm.100.1600085361235; 
 Mon, 14 Sep 2020 05:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200914071720.1099898-1-philmd@redhat.com>
In-Reply-To: <20200914071720.1099898-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 13:09:09 +0100
Message-ID: <CAFEAcA8VLMgFeJOyhEmiabVeEFQ_C=0x9Bs+hq03Q5+QJzYO7w@mail.gmail.com>
Subject: Re: [PULL 00/10] EDK2 firmware: Adopt the edk2-stable202008 release
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 08:19, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit 3d9f371b01067d9cec4d592920013012119397=
c8:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-fixes-1=
00920-1' into staging (2020-09-12 22:54:32 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/edk2-next-20200914
>
> for you to fetch changes up to 8fa3b7029f3c9f901cd6bb01004114c003432d9b:
>
>   tests: acpi: update "virt/SSDT.memhp" for edk2-stable202008 (2020-09-13=
 23:03:15 +0200)
>
> ----------------------------------------------------------------
> EDK2 firmware: Adopt the edk2-stable202008 release
>
> Note from Laszlo Ersek [1] while addressing LP#1852196 [2]:
>
> Consume the following upstream edk2 releases:
>
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable201908
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202002
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202005
>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202008
>
> Worth mentioning (in random order):
>
> - various CVE fixes (see [2] and shortlog)
> - OpenSSL-1.1.1g
> - UEFI HTTPS Boot for ARM/AARCH64
> - TPM2 for ARM/AARCH64
> - VCPU hotplug with SMI
> - support for Linux v5.7+ initrd and mixed mode loading
> - Fusion-MPT SCSI driver in OVMF
> - VMware PVSCSI driver in OVMF
> - PXEv4 / PXEv6 boot possible to disable on the QEMU command line
> - SEV-ES support
>
> The IA32 and X64 binaries are now smaller -- the reason is that Laszlo
> built them with DevToolSet 9 (gcc-9) on RHEL7, and so this is the first
> time they've undergone LTO (with the GCC5 edk2 toolchain settings).
>
> CI jobs results:
>   https://gitlab.com/philmd/qemu/-/pipelines/189394120
>   https://travis-ci.org/github/philmd/qemu/builds/726842542
>   https://app.shippable.com/github/philmd/qemu/runs/866/summary/console
>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg738173.html
> [2] https://bugs.launchpad.net/qemu/+bug/1852196


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

