Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2109C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B25E22384
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N30qLYBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B25E22384
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtiV-0002Vw-T3
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZthT-0001el-NL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:38:03 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:34623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZthN-0005Rn-Jw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:38:03 -0500
Received: by mail-ej1-x62c.google.com with SMTP id o9so21304984ejg.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 02:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XWbeyCT/vPEY7GJo3H5B2FtjQ0B4KWXEhDq63plN6Vg=;
 b=N30qLYBCLAH59BaWzWXyLeqfo1yEY42ei3pSQfCV9uPNjwFx34H3yLRM0uUfN7ivct
 K9ooepMPVERWORNQAdo9iygFWSERMnkAanRuU02YbVHgv0gJKPaAcmYsYoWTGFmO3vE4
 vGjY5FaUC3c5JpYM89EnHhWBBpL0K0byTfvBQeIJrNj3NVqUlCfwLpAWqVnX26ZgegYf
 W3yaea6R+cD4e11HIAYvUcnUSyYFOASEjArfdDn1EHGlB/ocIG40kmhZZY1bgaCSJ1oH
 VDQXanx69f2qbAaaKHd0mf1GXG25XQN/LTdqYIP5Xf4w8bUZG6MBvhKNXxzdg1U9AddU
 QwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XWbeyCT/vPEY7GJo3H5B2FtjQ0B4KWXEhDq63plN6Vg=;
 b=qnGYyFp+LMU3TIC1EbtrfsSI5X1NgKpx8SfSqgh2Wb2guE+3HyyB3TGJR5QkIirpX4
 XCtRxUzmPUnN5XxAalni5tQB6SqHCXDsUWDjq+9UwM01yx+97rQjJECI+8n50jnvoY/I
 i0Y7IAAQapzlMM6svsGxgtLTtXYm2sb/26h+43+1XR4GvW4CAMp9I/OfBZZ6Uv0P8nAv
 SzrnRM/7WFbyrHu3Gw2fX1eRQghbadGy4+AnP2mBFijiGh30TEfu2uZ5C/2YGOFxQ0RD
 9s25ghBIpiWnBYsvCSuwxe9KuQH8PLRaQH2HItR1eJ333qzFXneDF4EUtJoq1yRKKGQQ
 V0/Q==
X-Gm-Message-State: AOAM530H05+uLosaaBYv0u6QGKFoDSw3Mttkt67PfiKukm68K9PbJm1n
 70NKI8hIaX8v/oUZB9+2H5MiRaiW8oR6cIgi+1271A==
X-Google-Smtp-Source: ABdhPJy6hRLw0ilziyr7lLsUwjbyJXQBrNPhYAHQC+Wzm6M9msJIDVb/aNl5Na6wIe4yI160793R/yhP6q49kdGo1YQ=
X-Received: by 2002:a17:906:6949:: with SMTP id
 c9mr7308821ejs.482.1604399875865; 
 Tue, 03 Nov 2020 02:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20201102195657.219501-1-dgilbert@redhat.com>
In-Reply-To: <20201102195657.219501-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2020 10:37:44 +0000
Message-ID: <CAFEAcA_YZ0-1ArGMMg072--riAK+ScH6Yu-DTbo5rCqTjYu0qQ@mail.gmail.com>
Subject: Re: [PULL 00/12] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Max Reitz <mreitz@redhat.com>, zhangjiachen.jaycee@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 20:00, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit b139d11ae198aba0e009daddf7a3370ce84b2d09:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201102' into staging (2020-11-02 16:05:47 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20201102a
>
> for you to fetch changes up to af1bb3fe7f146fafdaadb479975ca2b53b49df40:
>
>   tests/acceptance: Add virtiofs_submounts.py (2020-11-02 19:23:48 +0000)
>
> ----------------------------------------------------------------
> Migration and virtiofs fixes 2020-11-02
>
> Fixes for postcopy migration test hang
> A seccomp crash for virtiofsd on some !x86
> Help message and minor CID fix
>
> And another crack at Max's set.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

