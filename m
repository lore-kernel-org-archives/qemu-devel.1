Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD41C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DA522225
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqZqBptt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DA522225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWho-0001EK-0p
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIWdF-0003Ed-GO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:33:53 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:38431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIWdD-00060K-1Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:33:53 -0400
Received: by mail-ed1-x52b.google.com with SMTP id c8so6103786edv.5
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lRD0Tr0/Jp2bOEXR6ZBlrrC0vMKCglNBu4Y2ZAONc0Q=;
 b=pqZqBpttK8J4fcIQMvIRZiSBMFdxVivAUjs/w+SVzgh6ntD2Az0aoPhqSLiYt4V9fC
 g9lcpnBvalR9rvQoRmH9L3HbX9nZyd3TewzB3uqCgmSiKOy2iQmObjThSNBUzRD7OlFT
 lkNjdtTxa363Cjoasqdrf3ogX5gXZJvL8xyD3+xt5PTGRlQQSfHRdj5cdw+z3HjigNE8
 Hewf9hbnDeLaXV2FrO26eFJO7J831MDSxXSbCa1JiXLRlHGmG1rQZ2xvz5TCC9VqFlWr
 iF2sgGpuHHHP5d03B6HX/X+/lON0ILOWuGWG04l/mp3+MgzjunpsB1ehWYbI/gBVquho
 5UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lRD0Tr0/Jp2bOEXR6ZBlrrC0vMKCglNBu4Y2ZAONc0Q=;
 b=MaFykH9L4tGaH6tmcsIxKIY+7daJxR5lUlTl9JEIMFHFKS2YJc6vQ3RPdondy/iYbk
 BfhOjkfjve/Sufjgyv9y2mggZzUU6MybbhXjaRWY6lsRa2w8ZD1SzksOoyRpIShjzPXi
 wwJ/t2MxRbvikWXWoo4566kEnKbe6i+fu+xzxAD6KyyGqahowsKivHyKKoCDIReP7NCs
 NCd8cag6Pqa4+J+0I6rcpyzKzok8jLCLjeyW/WF9lWqrd9tDf9atc+eoA9m7KbQpe035
 mg3AffYtaYLk38SIsXO0dsypN/5qqNtz5e/h438uHrYOzARXAxTxT3pAVAv8nrgcBq8B
 rXVA==
X-Gm-Message-State: AOAM533OtFDzMt84kshnAV6oIJvAGmBAcu+OKxTEUY9xFdUUUYEcU7e2
 NyZfotw4Q/r48KvOsY33kmmokr4hnQgCQlMjlFu1WA==
X-Google-Smtp-Source: ABdhPJyhtCRtX35/+CizC2ib/bQvcp6PXQWKnhH9/Ewb5sf9rzEKgflh3mDz3cVB0cGCHc6PBKIZsKkiOxneq+Lpvd0=
X-Received: by 2002:a05:6402:1495:: with SMTP id
 e21mr26796648edv.146.1600259629509; 
 Wed, 16 Sep 2020 05:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
In-Reply-To: <20200916111025.GA756728@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 Sep 2020 13:33:38 +0100
Message-ID: <CAFEAcA8FD9HNKvsGs0q6YpSdX8gsoBaNtAPXuvv+e35O33Jbmg@mail.gmail.com>
Subject: Re: About 'qemu-security' mailing list
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 12:10, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> I think it's worth investigating whether GitLab Issues can be configured
> in a secure-enough way for security bug reporting. That way HTTPS is
> used and only GitLab stores the confidential information (this isn't
> end-to-end encryption but seems better than unencrypted SMTP and
> plaintext emails copied across machines).

Given that we currently use launchpad for bugs we should also look
at whether launchpad's "private security" bug classification would
be useful for us (currently such bug reports effectively go to /dev/null
but this can be fixed).

thanks
-- PMM

