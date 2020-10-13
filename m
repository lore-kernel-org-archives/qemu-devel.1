Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2B620789
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vD3uj1iB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2B620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHqB-0000OF-Cf
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSHor-0008Kx-GE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:46:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:44900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSHop-0005B6-O1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:46:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id t20so14072775edr.11
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CMRaAhrfCCWvlz3H8gwY/4mvGLT15CLBPCudLpRxul8=;
 b=vD3uj1iBQhcONlNsgXtpbOiqCWYlFkUABFNYdQqpcqsF7eyosnRkMz3FRUSVDCQJ9v
 p5mZJBBYedhL5C/fntLq090lbL4YZIq2HVjPDAPCz/eoy94JRdWfmMnudyE1LEtXPGG3
 rqFG6FKSa85IqWMKlk5AJ8KhUJ3e8IR+AxleqqILkM4e1MLllvoyIvLIDnj7bKBnaO9v
 H+s9w3LLHfOfPaj1OdzYogE4FkxGQwkajGh8Rysvxo0PEUkkecFEl7zHQbsHD9sD7g4Q
 OSXHnu+8nxMHaCZNrUD4/6+r6GbFA/g0Kts197/Zbbb0/37P0nviBczrjfRQ8MTICW16
 HHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CMRaAhrfCCWvlz3H8gwY/4mvGLT15CLBPCudLpRxul8=;
 b=f3OU8niOzAbiIliZYL8aonMYziHqoBVUjG+YLVpOiJnMMmI6qSdSrrSHiOlQmuowpI
 18ZnZ9wSaNSrjawaL8NjOLIor8SsNr0hnrfP0aAFWFhgmkJxuNnOY6E9j/5Xunz7FSQ0
 yxHsRowWZPG2Fm4b0Hhki5nDNYinIL+mqDR7diX4LaQlRpadZ4gzeEajxaoh8sWBbEli
 tEJuao9miFDDE8hB4ElmjalG3wJOEhWhm/onoT8GcW+z1pD4pp175Rb5JKB+Eu/TTacS
 RrceFONt9LVCkT4IMj9rR7zfuGeZTqza37QsdeuesfRKvmsAtILilhmlr9uOLlgdv6fc
 idZA==
X-Gm-Message-State: AOAM530lcU/lJk5WZ9fGLZ2jluxuejOW+gXyo/Ag4yqqGN7S2HQlZGUt
 YRkVvyhowF+q4WPuEEX98h0ZQ8gn7K6OyquzZ8pSWw==
X-Google-Smtp-Source: ABdhPJz1w/VVUrdDYXFDbfl7SiuwMjwdICR8zUL0TYKfbqVZzGIptPdAYy+m3CkPlfvI9P9QKsIb/oe1xIoMs33O7XE=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr18896788edq.146.1602585969569; 
 Tue, 13 Oct 2020 03:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201012203343.1105018-1-pbonzini@redhat.com>
In-Reply-To: <20201012203343.1105018-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2020 11:45:58 +0100
Message-ID: <CAFEAcA8iVb1jAFZ_g5bcavOFd2SROphONhfrmb+gHQofe5q=7Q@mail.gmail.com>
Subject: Re: [PULL v2 00/38] SCSI, qdev, qtest, meson patches for 2020-10-10
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 at 21:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit a0bdf866873467271eff9a92f179ab0f77d735cb:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20201012a' into staging (2020-10-12 13:12:04 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to a0c9162c8250e121af438aee5ef93e64ec62dae1:
>
>   meson: identify more sections of meson.build (2020-10-12 11:50:52 -0400)
>
> ----------------------------------------------------------------
> * qtest documentation improvements (Eduardo, myself)
> * libqtest event buffering (Maxim)
> * use RCU for list of children of a bus (Maxim)
> * move more files to softmmu/ (myself)
> * meson.build cleanups, qemu-storage-daemon fix (Philippe)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

