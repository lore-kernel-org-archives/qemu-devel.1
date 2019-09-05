Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38811C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 16:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F162E20828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 16:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPP8sD2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F162E20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5v2F-00005O-UI
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 12:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5v0r-0007dP-30
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 12:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5v0p-0000j5-Rl
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 12:53:36 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:38428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5v0p-0000iO-Kq
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 12:53:35 -0400
Received: by mail-ot1-x32b.google.com with SMTP id r20so2888553ota.5
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fi70QtOSQG/BxMsmLlyR0xUoaLszBx+vWdUzTxiWjcs=;
 b=yPP8sD2O8Dvc4stq/aVIHDFNCejR98bg7pgTzEcaAPnK8QYfgYVh3kBpADtIP55ONP
 /9avvzvm+dismVQOdiIeBP7KM5cYCK3HDAvrmx6Ah9+vlWbXlKGgy7Lmu7oNViOMGYOP
 x96sxHbfqaV1WXwAQOoaQfT8TMeBjsx3rXeCTJZpBtTlvnFep5X5oez9JrgH7K0Wp1St
 Ytq9xiPYVauqgdIORDL7irDa6RwhlY8w1vzXAFB9H2k3EtiGydL3b1E3GJbk8y7TvzwA
 NEjK0Pzx0Kq8lldbEILF/Vj6+B58z1IRRfyju8S34GpnjuJUSI0i/sLxi08w8tBXOWwX
 IGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fi70QtOSQG/BxMsmLlyR0xUoaLszBx+vWdUzTxiWjcs=;
 b=bjk06vEzQRhEhfK92SCusLq3G8+F6ifJmRFmRXVKc46oQaPdNh/ZBnQLmJ6Ts4/o3V
 iW1UCX1CatUr+id3NLFQe6gKRnZT6kfAwsXJF4/TS1vrQ2rvZc9pOMl7cMegGYOs2RPq
 z9+dleuCSchxpuvYXdSSJSxcVnjDcB4P2XgjDmacyeH5+RfTxYkNwvSF+rgBSXlnNN+6
 MdJF/QC27T6dYHBsM2zeCLLPNSrGKfa9WcMjJPMgjfbSmkADZ5D5IoWEOzyj97sh4cft
 e5S2HFwwtKBFbn1Cmdz5kh5FjGmqcMX8rDwUFbnf0ypwvQElzpY03ZwhEeUY0BXBRQSW
 40ng==
X-Gm-Message-State: APjAAAVGO0kkhGd/RtIcME59fdBUkjrdvs01DSIvFULc8UznIyVCb2T0
 Aq+rqt3WOaOBwF8gs+1sRxqSbsPRMaH1qTrgekUyvg==
X-Google-Smtp-Source: APXvYqzvMKRwR0EB34g1ACh+P4UXwFGvZ3VkDHAnNDXYUqrG2yLnqBxQVFrynJX/1opU8FGbl/s6BY9TRhgmTRAljcg=
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr131456oth.232.1567702414541; 
 Thu, 05 Sep 2019 09:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190905153011.24010-1-thuth@redhat.com>
In-Reply-To: <20190905153011.24010-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2019 17:53:23 +0100
Message-ID: <CAFEAcA8f+jjMher5yKRbz3LGEQMi-_qvvXvm_JSZzdcn+NGsNQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL v2 0/9] qtests and misc patches
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

On Thu, 5 Sep 2019 at 16:30, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 500efcfcf0fe2e0dae1d25637a13435ce7b6e421:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-or1k-20190904' into staging (2019-09-05 09:33:01 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-09-05-v2
>
> for you to fetch changes up to e7dc804ef0d7cac9ac8b4a1324ab7dbfafb55704:
>
>   gitlab-ci.yml: Install libattr-devel and libcap-devel to test virtio-9p (2019-09-05 16:00:01 +0200)
>
> ----------------------------------------------------------------
> - Make the core libqtest library independent from global_qtest
> - Clean up docs from hard-coded qemu-system-* names
> - Install libattr-dev and libcap-dev in gitlab-ci to test virtio-9p
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

