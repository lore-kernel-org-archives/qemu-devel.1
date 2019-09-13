Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F9C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF94F20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/iH3tz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF94F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mqX-0006cZ-Ra
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8mo6-0004jj-3H
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8mo4-0005zk-Je
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:44:17 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8mo4-0005z3-Dg
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:44:16 -0400
Received: by mail-oi1-x242.google.com with SMTP id 12so2865075oiq.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mFEfL9BaFYpOGKMvDGW4sy98EPwYq5AOdMgj2gLY0Jw=;
 b=r/iH3tz5v4ZN17wqcIYALjS7gtLeZE3BHWNS0QzdYVnelXFDz4QoZ3OmJgasIVTYCP
 UX4XLdW6aWsefJrcZsRR2GrNUpChwv78TvKKuXnHGB3iB0zWRQ4rbml1x+LphCOBAzDl
 8vF821ZOSHmt2XPzG5TEGwz6eQiue6Xj0KqjaQVtUepNRv+3OukXhe8bf2ig+QZ1CFfw
 9RXIrn05OLoO34DxlB6ZrOceipimsxzhrqd8Dur4ShHO50C/Mo9JcJNFBCk2cTHw0T4Q
 nZmVOMHZ7VHFhfncWsJe62jtygAJ/6D59Oya/jz6IZjkpMzxcn/qNf6G5j2ASjN/x0O/
 gefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mFEfL9BaFYpOGKMvDGW4sy98EPwYq5AOdMgj2gLY0Jw=;
 b=P46ZnW4N7uO7DjK8CQXPynUpm7k3mp7Qs3djQOauNneG8Ze9HWX45sCVyXI/8T6NtI
 VOjdimtqIlFl+gFopNX9v2v+yqnNEoGkMMkSzDpoLI0G8rxcFn6LU1HkV/BUwr822Bt3
 jLsbIleeNB7Kj74kocgMyB3b56gHbrdYqm/8h+mkQ/Gr2L3Kj7i0pG0moODqwY9XrFR7
 RNzxcebk1ttUjdZNPi3AH09d83s84AaPSNql4pdXMVEG/Ivw2S6P3tufASP4tGPKtOr8
 wmmYTW+ELV+zhsqeEZDlLYZuOHJEHp6LWX+m/qDoNj6Jm+CqvMK3Orel5P8XlMDg4gs/
 Da5A==
X-Gm-Message-State: APjAAAVD7ET2Gg9tjjRJpyOMCvjh0rCzusdQE0KZeaSsZwR1c7dZO9HL
 yT/DBM7QFROm8gxcNPeC1SCs7wNsnckcOlyarIBrIw==
X-Google-Smtp-Source: APXvYqwUMAairVpHgBNUHrSAf962ChLKey5eeCPceKvCwYcaJetUqcn7k+woGPH4QWb5kUO4xH4AwNwreqCNTwUWu7g=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr3702382oif.98.1568385853599; 
 Fri, 13 Sep 2019 07:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190912135006.14820-1-dgilbert@redhat.com>
In-Reply-To: <20190912135006.14820-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 15:44:02 +0100
Message-ID: <CAFEAcA_wjtsUMCp6uJme8WOht02JWr=9hqwXM4E0V40g-6KQTw@mail.gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 00/12] migration queue
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
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Wei Yang <richardw.yang@linux.intel.com>, ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 15:10, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-09-07' into staging (2019-09-09 09:48:34 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20190912a
>
> for you to fetch changes up to 268dcd46ae6d608a4ce93b191b51a318504bf1fb:
>
>   migration: fix one typo in comment of function migration_total_bytes() (2019-09-12 11:25:06 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2019-09-12
>
> New feature:
>   UUID validation check from Yury Kotov
>
> plus a bunch of fixes.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

