Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024DDC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DD9214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="froQg6DU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DD9214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUb5j-0002en-T7
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 13:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUb56-0002AM-7c
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUb54-0007Qu-VT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:40:00 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:42528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUb54-0007Qe-Nl
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:39:58 -0500
Received: by mail-ot1-x32c.google.com with SMTP id b16so15215068otk.9
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9zwVg2O8wptvJsGyfjFUwZZJImE1hfapMUoloLI0lnk=;
 b=froQg6DUP7S51/DFD97DmN5wImcamN+tO/Oa5ZxmLQbyJT5VQkNF/+EDy/uyEaoM5J
 sjxRjTFy108KOC/MEfOe8kK40VGn+mlM+b/OmOG5ipRlHkkdzFRRrHF59PnQbOyvVxur
 qSIEfffusKk9CEjd5SuBZljPkGzGIk4YPRnoPCsYv7F9X9v50Rw4uxTjxvgN/BqHaaWE
 dDuyhfPiCJCu3XEmzm9zOZreVq1KMRdX7wMNyWfP8N2jbF0rb5XoVcu4Cufe6VRkISkt
 mRCB/iwxo9XnjBras2HWGrWdp8aYHcW99qNLVuvdxt4S72IQeDhW+xSDKDdpxjP5fOnC
 Wsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9zwVg2O8wptvJsGyfjFUwZZJImE1hfapMUoloLI0lnk=;
 b=X7rGAUrH1GweyoKo31PeeJQfmugTWbca7k235XAt7vgDK0fJpGS4uSYXYhIqGp60nS
 pgcYPDGYdEeSZxr7+Rc9xYJV0aPZOL084rb2MdlIDsK6UwOI3SRU9nMy0gY4OBDBDJgK
 mzbVjrV3c0cetoj7UR+lcjE/WHGC/8ujgvJbY3Jsw4FrFPth6+9KgCNhvhn/Bk6YGK6E
 wOrDYpHv2lXWwwI8t2eXuupcStATdZACvQml9jnZspIytQNUaR2aM8p3tHu3FZNnVWW5
 HfAIyyRgXBzS9oaqhgieJViedsNsdl2ThXDFJfmBvX38kNYAOGeKHIxPWuUB/GPKMP+O
 Fgqw==
X-Gm-Message-State: APjAAAX/rFbppPwo8O1B4Uuf+AQqBTl5mmNydUSOktOBNEIxTqqy54c6
 CplxvNrQZsldQC4wPTcOyY1Q9jEZIyGaDAUQtTYQwQ==
X-Google-Smtp-Source: APXvYqwtYdZInmxKfgya/UllSv2VTH+CM6bqTCGs55oH4sJA2fIIsaC/DQU9dAdU3/NSPNj3tLf/o3ZO6SBlk0A/sXM=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr16740218otn.135.1573583997721; 
 Tue, 12 Nov 2019 10:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20191112161654.2253-1-laurent@vivier.eu>
In-Reply-To: <20191112161654.2253-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 18:39:46 +0000
Message-ID: <CAFEAcA_6JO-3FXSjOFizes9r2mO23-QmvDEoFEZHg9oPk0-DLA@mail.gmail.com>
Subject: Re: [PULL 0/2] Linux user for 4.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 at 16:18, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 2a7e7c3e103a5c29af7c583390c243d85a2527e8:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-tcg-121119-1' into staging (2019-11-12 14:51:00 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request
>
> for you to fetch changes up to 0f1f2d4596aee037d3ccbcf10592466daa54107f:
>
>   linux-user: remove host stime() syscall (2019-11-12 17:05:57 +0100)
>
> ----------------------------------------------------------------
> Fix CID 1407221 and stime()
>
> ----------------------------------------------------------------
>
> Laurent Vivier (2):
>   linux-user: fix missing break
>   linux-user: remove host stime() syscall
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

