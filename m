Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0142C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0DF206B1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3gF6GBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0DF206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRjp-0006o7-Mn
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCRj7-0005qi-7b
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCRj5-0005NO-UT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:34:32 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCRj5-0005N9-NF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:34:31 -0400
Received: by mail-ot1-x342.google.com with SMTP id a49so4377403otc.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gFSRM4tVVH9/k36mlrb2nKTgOwLRJVC7k58PZXAqNXY=;
 b=M3gF6GBEP1F75PJLSuN0TcZWtxhbf5vGklg0E7J9XKmBXO7pFBbYsks1PmV44ZJhVm
 8kIEMW5UZKb6LIsdd8ezG0wLIz0vfvR6plhzg87U8MYWBSStwmcbaEBLIBwuKXyChIdC
 l4/OBVr9SXWKhdwJsGhy3x9OU5a9uO/DnnnVxrBCj7gySxg4CXwVkixC5wsbRSp8gKHg
 BOUae5MitPWOlsT+vhIiiL+DSBkWvbxZ9HGcJOZjciWn8bWfqJnjkSa4mP1Vdi9/1Vq3
 cioZYdU9Bnw5IdoH3C5RsjTMlzLxfLr7uL3V3LO9LnTsGXLPLCxW6xxFzbao+ANfcx2N
 xLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gFSRM4tVVH9/k36mlrb2nKTgOwLRJVC7k58PZXAqNXY=;
 b=uG6PnKVzkq28Pdiv42s+sN7bflDMAa9Fjb7tbeqzP8kHIvoNslz/QqAwMPiy33+Nw+
 g4kzbpbY6dRpTS8Rqhm0P9fmHdcuE44xYTGNiEQMQO3FZbrTlYz5aUFyV1vGMGOuii7k
 rwG/0WVueswr2+38JmpCe6Cqp5yndpfec+Gk6BCBQG37G8BySUl7P4vGx5v6WR9J6Vn5
 fBlC+kWuHTc1yUg6S6zP/stB6j9iKP8LUqJglPFVW5n9P7jKAt+vaY1iM08eDHCfoh6x
 3LlNSo0gWrC0+8/l4aBSo/o4CAHXtwCoI+oDDxJs4W58mMomy+6XD8VE4m8BXlZWyhbA
 /dEQ==
X-Gm-Message-State: ANhLgQ2i/5dhr08vrPK/xOCRKHpQOUywxrqRLWwcG1FW4glSZl6bg4QP
 8mgnmWEfAriLjCB7A4KtD1Jz8fKASzsGXZUih/tQHQ==
X-Google-Smtp-Source: ADFU+vur6hTRXhmmVZdjzGBkcEiNXiDdpqfs+q/Xi7szkA5YIcAdLQ92zJpGdxs5KgTZeG4E3VNn5R3mn2/3pAPRZHY=
X-Received: by 2002:a9d:6c05:: with SMTP id f5mr7313174otq.232.1584034470704; 
 Thu, 12 Mar 2020 10:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200311154218.15532-1-kwolf@redhat.com>
In-Reply-To: <20200311154218.15532-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 17:34:19 +0000
Message-ID: <CAFEAcA_8o5qGa6znPDpg406kMU+Y-e3v+tt01Cu6TUAQHPti9w@mail.gmail.com>
Subject: Re: [PULL 00/13] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 15:42, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit ba29883206d92a29ad5a466e679ccfc2ee6132ef:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20200310' into staging (2020-03-10 16:50:28 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 8bb3b023f2055054ee119cb45b42d2b14be7fc8a:
>
>   qemu-iotests: adding LUKS cleanup for non-UTF8 secret error (2020-03-11 15:54:38 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Relax restrictions for blockdev-snapshot (allows libvirt to do live
>   storage migration with blockdev-mirror)
> - luks: Delete created files when block_crypto_co_create_opts_luks fails
> - Fix memleaks in qmp_object_add


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

