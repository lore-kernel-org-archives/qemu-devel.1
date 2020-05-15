Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE66C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A8A20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDlrUcju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A8A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXR5-0008OC-9Z
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZXPz-0007Aj-DT
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:18:15 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZXPv-0003JZ-95
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:18:14 -0400
Received: by mail-ot1-x344.google.com with SMTP id 63so1476597oto.8
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cy1IdB0d+X1PdUacwAOklZDGZHmWQAl8yZxoYR2eMcU=;
 b=lDlrUcjuD3Ev+aLDHwi0h4aHdARryO6yuLvZEFwvaIhg/lvU0/hcTP8trDxhG0qaMd
 bHe/4KHjSvFApYZfjssdqPlYPeVm3bJIxrDOC9sSBeYbX2zCPaf0Vjd8dnQux/qz5k8K
 KixFg0eYvgLcTfyrKfmSNNlRypTX3FoDjPiceRA3Skr0W7hOhzJraUFHpCKBFGJkSHUP
 y2R4B3/2CLAoWFl9VNRNM4mhfBMMfNIbU4VK0EFoAw/7q1liZDRBZ+Rqr3qw22Y07dq2
 Ebk1b+7B92NZofTgys0F44F4Avpp1GNGUANvff4crFDfhwXrxhLrIvxBd15o/vSIJ41f
 GZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cy1IdB0d+X1PdUacwAOklZDGZHmWQAl8yZxoYR2eMcU=;
 b=AMRQpAoAY4P4/fjoZQDCNe8C9YDqCJSdt/LzpoBNBC/BpUvFI+4bCCmSYeSwaZaosV
 ShLEUzxff0iOKKLT0sSKjoXU3AsS+YzpldUmyPySFS0aM4GA30GL8kOEws71Qh4n0qLf
 ngw749rqfl0QDxsyoRQuV0aSom/e1q5ZPXlGnbOedx3Vl5fleJqzSjUpDeffJNoV2qXf
 yfCy1SB5e0EdWKNfL+9HPaaOuyAqai3obDvrmo1XIRv7gQ4duucmpu5WGKwrLue7vXda
 MnIXVhtfa9abIViwYDH67bDWeUcO74BJNbuNVFEz5BOTJ0euQoDVje2lwsQH/mchnGW8
 XbQw==
X-Gm-Message-State: AOAM531A9//67MZpiKBZoK/gloNfNH1C6+xFaAJdIs3+fPW6H9L8cc17
 CZtrlA0dyID88rKcxS4EfCIl0IbX4OrhAEs7I62LUA==
X-Google-Smtp-Source: ABdhPJz50qM2i+UZ+NOAIPVslgXpEnp2KchVDT8xC3zbhcwlB0Jh61pn3UrjgUagLpnGfZ5RoPeJQCT+xnI/GLhtGA8=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr1596176oth.221.1589537889827;
 Fri, 15 May 2020 03:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200515060424.18993-1-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 11:17:58 +0100
Message-ID: <CAFEAcA-KTYtgsQ3+W3XBcUPfRbTr-zshVhuKj3UvnUG0wNpbYQ@mail.gmail.com>
Subject: Re: [PULL 00/21] QOM patches for 2020-05-15
To: Markus Armbruster <armbru@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 at 07:07, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 013a18edbbc59cdad019100c7d03c0494642b74c:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200514' into staging (2020-05-14 16:17:55 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qom-2020-05-15
>
> for you to fetch changes up to 8e5c952b370b57beb642826882c80e1b66a9cf12:
>
>   hw: Remove unnecessary DEVICE() cast (2020-05-15 07:08:52 +0200)
>
> ----------------------------------------------------------------
> QOM patches for 2020-05-15
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

