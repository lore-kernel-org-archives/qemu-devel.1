Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66906C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8075A22202
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svDR8YdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8075A22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShNX-0007Hg-F3
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kShIB-0001lN-Ut
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:58:11 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kShI9-0001DJ-Nn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:58:11 -0400
Received: by mail-ej1-x641.google.com with SMTP id h24so4947418ejg.9
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eLGfw+cP39HEvrcN68wLjEACUJTBRGohbK2eHmUmPg4=;
 b=svDR8YdMvkzgVirt5xVKEpC7fhIMktWfttcGAuIdF9aPd3DguUckjCxcNVMQByIF/g
 lomU/fRfw7Pkbjh4s9OkHAReGs3PAzR1MiQcgf9I7pYBFjc6KFc24h72rhNWDtAdWUSq
 qpf15lzuvwzsl8CidAOhDZZkKP3BeYs6tNQ3BbR0dchy3a4qPD1fr4SiMPVnaavBa6GC
 5+tfOVLNBAtoUWc5NKIVMkA14Bp9KRr8+Jgv/pUaFYfSiF5Xf/jiFyYZCEaJY1ijagEJ
 zkNBAuNzwTn2lxyqJQagUsE1cqFpk0GT7d3EKWm2fLrQh5HP5lL2pC1ETimstOjPqB+d
 Lc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eLGfw+cP39HEvrcN68wLjEACUJTBRGohbK2eHmUmPg4=;
 b=RvWO0hZZYWtkHAqX64O+CSS5ojB3sYu6xMv401guYHDd4kQDAN8IkHfrQG2kT4xbX5
 4XjO0shqkdZ/czZ0X8DfETFIHH6l38vNUWuZWKZJPLsSLvUnPuaXpiPS5jRrIkbIvSiB
 5LbwKMHItYEB4GXjLeV0I2vAwTiHJtfGZbdKsl5UCBcbiHvSDUBiIP7JjvGsMHhBOxOf
 dcKujIazLGjER1MkmKwBqEx1kcMMu2pigbk9rxBzHMGp0bjzC8o+WGr0+n8WotR6flnz
 00Xvh1HjTayZyumbC3S0SmofnhxwEr6KoCWot8e8y7br8aDQGSVUs4EZJ/aRhJIXxhmU
 qW7A==
X-Gm-Message-State: AOAM53246bVgkMepfkh+73kL7EBD60j8noQ5r/kwFqlOyP6qAWMYLCW0
 RiaDROsRGCB2GDDqByAkaD13LPzX9xcT8h0dfBv9fg==
X-Google-Smtp-Source: ABdhPJwSs9gBsLyQiGuhYAwz4erDI5Pe0GIQVlt7t6x24nTqizPFtOnYu36/gKVHTim71IQ46XJ3W/S8pkj7efIfCFk=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr5678157ejb.56.1602683887619; 
 Wed, 14 Oct 2020 06:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201014135416.1290679-1-pbonzini@redhat.com>
In-Reply-To: <20201014135416.1290679-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Oct 2020 14:57:56 +0100
Message-ID: <CAFEAcA80sV4XZX3PJQZMeNwuCx2Lr5uX-8oq_r58zVF85eBb6w@mail.gmail.com>
Subject: Re: [PATCH 0/7] build: replace ninjatool with ninja
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Oct 2020 at 14:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This pull request is the last build system change for 5.2 from
> me, and it is simple: similar to how we are invoking
> ROM or tests/tcg "make" from the main Makefile, we now invoke ninja
> to build QEMU.  Unlike those cases, however, build.ninja targets are
> forwarded transparently.

>  27 files changed, 121 insertions(+), 1070 deletions(-)

The diffstat is certainly persuasive :-)

-- PMM

