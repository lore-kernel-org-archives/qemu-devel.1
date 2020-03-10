Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4152C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826A921D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZORU5CF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826A921D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfJM-0002NJ-Ot
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBfIe-0001XW-TY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBfId-0000xm-IU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:52:00 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBfId-0000v6-Br
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:51:59 -0400
Received: by mail-oi1-x22f.google.com with SMTP id y71so8513927oia.7
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ApIoAECcBP6gzgRvXKLM9FBd0AbBTm/GWFiNc9Bjnmc=;
 b=xZORU5CF/tcys1Dq9aXLVRnSDORRtJpE3PHVvM2mOmo5l2Xl+DVelLTq+kmzfmlqtv
 iD+NYGTiY5X+y4qJJmHIP8cpdK/KGh+wd/ROzO+4sbrke6MSn+Nrng7LsNWcFAQN9pkc
 4a1kufPP90bMA2vp8u9xOJZJHIW9cekubCgzgRPkhHovmOSP/ajq/pxLSN7vE4UjR5Zr
 dZFuSL58TbobGqcBIDtSPl9/+H2EFXUegEplYYkqDjGt2cU0pglEuEa65r/iLJh73iBA
 VCb/kj+ZHFn1XAOFpJxjjLJ72kRK6xYOdY3lUVf6jdnRGtw20pkJpZXASiVHBJuUO0ga
 aatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ApIoAECcBP6gzgRvXKLM9FBd0AbBTm/GWFiNc9Bjnmc=;
 b=Ax3GfRLympb4lfNnn8rT99ZWv06aySHau1TYLYGotXlZADu77yFYJ7EWpGMeMchFFX
 MdVmiWVZm7rHzilOp5G1cqYdE2PNf2Xsz34w3o0HtjLpU0qSpqH6hTtUc37rtcgcgJNi
 R6jTgyfqR70hh7sgOr1LKqvLVlTAlIPJjGTHI7y7rKuPI1Qq0lveTGQz9IzZvUJ7SgIo
 izgbBcYiaNrJX0QChGp17nFhN581ZUdW+5KUHZDP+wur0OSeeqR00+31oj06qLYbo/sP
 XF88JRWD2K46giyQqID5+ATauGWxydyDMcV3C8DjclHzSG8wrSUuKYe9trpjbpjrYVIL
 HE7g==
X-Gm-Message-State: ANhLgQ1BZyfm18Q8dL7LDEvZIUQJl7hgV1QUvEgGRGY6R/VuJXXLIWuu
 zQiKc8w5wOIMuu3jaFAMv71EhHL7j5jebcZye5EyMA==
X-Google-Smtp-Source: ADFU+vsM1r1+Bv91+w3ZCutQlFfsiFQrKzPrEU+7csJO7uSfDqqoAEtP/XfT2vASmzeTLZnmOLFDKO11M7Pbhxk3TL8=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr1184339oic.48.1583848318508; 
 Tue, 10 Mar 2020 06:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200309194650.160552-1-dgilbert@redhat.com>
In-Reply-To: <20200309194650.160552-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 13:51:47 +0000
Message-ID: <CAFEAcA8c-5-C_CWzyBXsQHeSTPckoxxu_Y_KTHasRMecjQF4PQ@mail.gmail.com>
Subject: Re: [PULL 00/12] hmp queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 19:48, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506:
>
>   qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20200309
>
> for you to fetch changes up to b4983c570c7a5848c9df519cd9e056bea3177fe2:
>
>   net: Remove deprecated [hub_id name] tuple of 'hostfwd_add' / 'hostfwd_remove' (2020-03-09 18:44:04 +0000)
>
> ----------------------------------------------------------------
> HMP Pull 2020-03-09
>
> Maxim's hmp block move, Thomas's deprecation in hostfwd.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

