Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89966C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 23:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6AB21BE2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 23:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLQogZ5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6AB21BE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiS3F-000769-TH
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 19:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiRzT-0006Z3-AO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 19:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiRzR-0003xr-Q8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 19:15:11 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:33767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiRzR-0003wP-G1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 19:15:09 -0400
Received: by mail-ot1-x330.google.com with SMTP id q20so342100otl.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HfE7ifOD43i2Us6uxSjIoXRy6I///5MCkk7ImzWZXd4=;
 b=aLQogZ5ht7cYuMPZfYOlsdWS7nFZPuzxvSEuTWi5pn2Deg7vPE9EefpdGK4QxymSh8
 +ETsWUM9W1jqG36AOa1IcaZmRKKuA6/NgI4ei2ajurV/eaU2yofh0PYm51tvM5FDN1SG
 X5o9zgyoG1NYK0sHlqY5sG/9zr2Ip8EurzjFPNbuSqN1cjysz9WyQ+TjzLvf+Vxqf8I2
 rPNiPJC08PNvv7lEGo2q7pEQIDhSnG0LXbIio7Pl726wQW4OtS7c3Tf28ACtxDIwd/j1
 6OAQer57Ogq4dEU0JlujJD92mN+fr7T047v6mtlm7NMipwW/FkhOeDJaYICDmXVsydPa
 4FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HfE7ifOD43i2Us6uxSjIoXRy6I///5MCkk7ImzWZXd4=;
 b=sNBPxW3TDGIJVIEjamoqYCRMUIw1WpC/fW3xgfaW9mtKdiDbtQbsgCmUM1wBvqoEuc
 UfM9wQ63vV9q+iAm4zHueK9JSxkCUVRGCFxdzbwV5nhunYT1KySovgSbjsK4OqubbACX
 eMamORY93mpT/7D3ExAQ8JnLeEUTmUrHSrCnWSWxQndBzEZe5LJSQsyCitE97VF0BZOJ
 EQnUiM7UVPFZGLnxQGZbpX2BdSOOX1eBfUO45yROq+VU7JRtBJDZRDnq3v72HRdF71k/
 a+Jrbpmerd9cjyBpa7gzKbk1uoeYpwfa4rjI4Hcb8ICW0b13WdJ/WSq8ZwuIWP3eca/1
 LpMA==
X-Gm-Message-State: APjAAAVwnBdPPNf4cTBU2HSEStkQRBCZT95vtqvbRQjMkHQAvi6LOA9v
 DDGpwWk3wlqDlAdLbl5B+agHFdINI3dg0NREmSIZVA==
X-Google-Smtp-Source: APXvYqw5DRVBBPojQtDhJ6xzHLlh6rnch8lD3+9yuPfeLUWNxIYFURTIOXkwGy0IPpXZs1jdRTfZAKHR/pmq9AKKyQA=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr26860537oti.91.1562109308441; 
 Tue, 02 Jul 2019 16:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190702113414.6896-1-armbru@redhat.com>
In-Reply-To: <20190702113414.6896-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 00:14:57 +0100
Message-ID: <CAFEAcA9oPS2FbBgm+SQYqMbwzg+Dwmm0W9U8Vc-2LX7TmzAADg@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL 0/4] Build system patches for 2019-07-02
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

On Tue, 2 Jul 2019 at 12:38, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit ab200dafc0e8a9925bb0ad0be478621f5f117c95:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-07-02 10:17:54 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-build-2019-07-02
>
> for you to fetch changes up to b7f9b1b7fc9a00ab6e5f46555e87166533292576:
>
>   Makefile: Reuse all's recursion machinery for clean and install (2019-07-02 12:48:40 +0200)
>
> ----------------------------------------------------------------
> Build system patches for 2019-07-02

This seems to break the incremental builds (most hosts):

make: Entering directory '/home/petmay01/qemu-for-merges/build/w64'
make: *** No rule to make target 'subdir-slirp', needed by
'config-host.h'.  Stop.
make: *** Waiting for unfinished jobs....
config-host.mak is out-of-date, running configure
Install prefix    c:/Program Files/QEMU
[rest of configure output snipped; no other output]

thanks
-- PMM

