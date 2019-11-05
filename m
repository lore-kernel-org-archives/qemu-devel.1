Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193D6C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CF921929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sngJIZ2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CF921929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5Ol-0003ur-2s
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iS5O1-0003HY-SF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iS5O0-00051A-6d
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:25:09 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iS5O0-00050g-0X
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:25:08 -0500
Received: by mail-wr1-x443.google.com with SMTP id n1so23041826wra.10
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zDH7H/D7b4lb7Z1roailgRM0ski48sKXGwr5qxR7z1o=;
 b=sngJIZ2lQFM2JsxlWOhi3oDR4lYxBBkowcvxaGnc4crVWTY+Bmt98cFOufEg0Aj6JD
 ZjBj31IlHGleq4Bvrgc69TTn33uq0Gsi6ffu7r97jsEFGjd3k6H4c884lFeTL2h7cfuG
 cfEfDT/nO5z5nnSUxKfOJzUerbrO7Dlr3mR6uiiM2Rumg8O4EhvjtL+ZKflZ+0EsEnlu
 I6629zWy/VvShSuGtjKK8ZUf6xeIJUmoOQ/2cGyLNkvjEC+IT1ZqieKRYPccVCPQ1KtH
 fNEXA620e3CeTdg7TExff9YnNMii8vSb9hfrFwAie7BFvE/qoUj8L7yf+UwezWLv360l
 lDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zDH7H/D7b4lb7Z1roailgRM0ski48sKXGwr5qxR7z1o=;
 b=mrbWgfHHkXHShii0KNDrc2PHbvMgjCv/LGjjeyGzAj3UPGDNzkG6xlxMNnOlhY98x8
 K1KsG++XISrJUcUM9biQR2Y0YysjlChsJIW/Rl6vVi+4Pk7+edvooXZqjCg/QX8KH2Ea
 nfeIxvppPbS7bkATdmD4DqkDYRhbdmjNU7/ZhJ3owyJSdj3eHkBRVxUBlX1LpY9FuMxc
 7pAeCrZT4qCN0H+J9XRA7v+eCkjsBiaGEg5Iuh/a9mxCvfxyfJZa+A0siGFciAW0SukT
 41hCek6I22LXqmpIyfSSc+stL28lz3m3t+bGad5QLuIDW9cJax9/I5Km+okCIGXk0ihW
 x3iA==
X-Gm-Message-State: APjAAAXLr3/nc1ANBfB8mKbqI4NeHuAstPIhYab08QLenyadVur+LBNR
 nWWQ0CsaFBxHcJBu/NlJFzdhgw==
X-Google-Smtp-Source: APXvYqzp4OvphLA1ZFpyZAx8QZtdbrq1/vJBcAdUTlBR3HNYPw3b5wtVVMbLEYt7327pMXdqsOVCTw==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr28323254wrq.255.1572985505505; 
 Tue, 05 Nov 2019 12:25:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j15sm22610078wrt.78.2019.11.05.12.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 12:25:04 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E707D1FF87;
 Tue,  5 Nov 2019 20:25:03 +0000 (GMT)
References: <20191025203427.20181-1-ehabkost@redhat.com>
 <CAFEAcA-F0iB2vzi3Z0J9FPAt6JpuMh+V0wsfXWLuAGX5_d69xw@mail.gmail.com>
 <20191105195748.GG3812@habkost.net>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PULL 0/1] Require Python >= 3.5 to build QEMU
In-reply-to: <20191105195748.GG3812@habkost.net>
Date: Tue, 05 Nov 2019 20:25:03 +0000
Message-ID: <87y2wuhy00.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathie?= =?utf-8?Q?u-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, Oct 31, 2019 at 08:12:01AM +0000, Peter Maydell wrote:
>> On Fri, 25 Oct 2019 at 21:34, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
>> >
>> > The following changes since commit 03bf012e523ecdf047ac56b205795024725=
6064d:
>> >
>> >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into =
staging (2019-10-25 14:59:53 +0100)
>> >
>> > are available in the Git repository at:
>> >
>> >   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>> >
>> > for you to fetch changes up to d24e417866f85229de1b75bc5c0a1d942451a84=
2:
>> >
>> >   configure: Require Python >=3D 3.5 (2019-10-25 16:34:57 -0300)
>> >
>> > ----------------------------------------------------------------
>> > Require Python >=3D 3.5 to build QEMU
>> >
>> > ----------------------------------------------------------------
>>
>> I can't apply this until we've fixed the tests/vm netbsd setup to
>> not use Python 2.
>
> Fixing tests/vm/netbsd is being tricky.  It looks like the
> configure patch will have to wait until after QEMU 4.2.0.  :(

I've posted fixes for the netbsd serial install but there are still
problems with the tests including what looks like a fairly serious
failure in the async code.

>
>>
>> Have you tried a test run with Travis/etc/etc to check that none of
>> those CI configs need updating to have python3 available ?
>
> I have tested this pull request on Shippable, and I will take a
> look at Travis.  I'd appreciate help from the CI system
> maintainers (CCed) for the rest, as I don't have accounts in all
> our CI systems.

Setting up accounts on the others doesn't take long. I use the
CustomCIStatus template to instantiate all the buttons for my various
maintainer branches on the wiki, e.g.:

  {{CustomCIStatus|user=3Dstsquad|repo=3Dqemu|branch=3Dtesting/next|ship_pr=
oj=3D5885eac43b653a0f00fa97f5}}

which means I just have to glance at the button state rather than going
through each individual CI's status pages.

> Do we expect maintainers to test their pull requests in all CI
> systems listed at the QEMU wiki[1]?  Do we have an official list
> of CI systems that you consider to be pull request blockers?

Well they all catch various things but none of them catch all the things
Peter's PR processing does. Historically Travis has been allowed to
slide because of test instability and timeouts. Having said that last I
checked everything was green so breaking any of the main CIs
(Travis/Shippable/Cirrus/Gitlab) indicates there is a problem that needs
to be fixed.

>
> [1] https://wiki.qemu.org/Testing#Continuous_Integration


--
Alex Benn=C3=A9e

