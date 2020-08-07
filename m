Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25660C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA312177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMuls09g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA312177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40Bu-0006TU-55
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k40Aw-0005cZ-Pv
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:04:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k40Au-0005WQ-Sp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:04:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id x5so1375241wmi.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 04:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bRkpMHqcQrOChVVt6TJ7QQO3AAbHS/L2aTFiQQoAqHE=;
 b=lMuls09gp0rWzjF5OKAGLU8J/kpKSykGcFuZTTZx7rPd7EpzaUAiO1fIU6zPHcNWOq
 ckS8v1MQ2MfIHYO6NpRVICryNZfCpyOMqEuXyzIy0Y/VjG5vTibyt5XYbIG0XNq8ySVN
 2wybx9bkXq+MnDOEhsqvIP8HCpQvpltMZbxcldaf7KKr00wCX3QdkUKoGJG9f48it55H
 yKEQ/E4KZSvqk4aOKH68BtNzCzNrkHmoy8CgxN947OH8cntFwo+fpHgfGAGVa0dPeUKC
 8FnA6yNz1+9Ju88j7n6Z6q18mv88Vs5lAiK/r0vmyM40B6RXnl63DHW5je8vrbOHMRuq
 WWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bRkpMHqcQrOChVVt6TJ7QQO3AAbHS/L2aTFiQQoAqHE=;
 b=Qunil6VghxFb2nG8ekoqLyMMW7fhMLBfzzet+CfkBDKbE7Ef1kyYPqtxgvadWIvPms
 zBnuXiijYCvOyLkPxBeDa7Sl9wSy1gBoAMc7iFEP0yD8qko9Dgk/v/zDjcpO+jZiecd2
 QTl1kDpCvqSmf58VsOjrdWg1o8ayMcVe1C+UDbWV21y0wjMio3B27N1fuI3ZPOy1XWxh
 HqS6ukB28HROo0Vtj+om79Bw01n1CuTcL0ObHWAANtTxYnTtPJd5m+kNGZtLfFGEZMGf
 MXyO4WcoKC5h13eellW93QuPpOrfJmh++w6KKrYsRThy/HwxFbi5MP3/khcqJEe0OTS4
 M83Q==
X-Gm-Message-State: AOAM531Fv14Aw1168HU6QL4ewK8txzbCEKskmcTQRxfp6TVKLyc1zl49
 nmKkAh3knkfhkpuyVWUOC/dicA==
X-Google-Smtp-Source: ABdhPJy+hhdlwLUBUZxda1cGtPci51YlEPgPI1yqKCd/pcGfuq2/SS0xWM3yIPFdc8Mg74wKl8FUxA==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr12045258wme.119.1596798274595; 
 Fri, 07 Aug 2020 04:04:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u66sm9931271wmu.37.2020.08.07.04.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 04:04:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5486C1FF7E;
 Fri,  7 Aug 2020 12:04:32 +0100 (BST)
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-d0F9y2OSX5D7GrzUYU7yf4nAhHabE1dUVii3LRrueLQ@mail.gmail.com>
 <dc73a810-ee9e-711e-dad0-76a566b923e4@redhat.com>
 <8dedfe22-8659-5684-99a6-e9d503a5b3e2@redhat.com>
 <20200807091841.GG120942@redhat.com>
 <CAFEAcA8CVcKzNzaFVV4Gun91Nt0qQEOz+Ej2uedoN0MkQtaAxg@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
In-reply-to: <CAFEAcA8CVcKzNzaFVV4Gun91Nt0qQEOz+Ej2uedoN0MkQtaAxg@mail.gmail.com>
Date: Fri, 07 Aug 2020 12:04:32 +0100
Message-ID: <87mu36k98f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Aug 2020 at 10:19, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>> FWIW, for libvirt we decided that despite lack of distro support,
>> there was not a compelling reason to bundle meson, because it is
>> really trivial for users to update. e.g. just "pip install".
>>
>>    pip install meson --user
>>    meson build
>>    ninja -C build
>
> I really hate software build instructions that want me to
> "just pip install" something. I know nothing about the
> python out-of-distro packaging process and I don't want
> the python thing I had to install to build software X
> to be lurking around on my system forever being picked
> up and used by random other stuff...

I have the same feeling (although I'm a bit of hypocrite given the 7
binaries in .local/bin I have). This was the reason we pushed to have
avocado build itself in a venv as part of the build system. I don't see
meson can't do something similar if it has to (although the git
submodule probably works just as well).

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

