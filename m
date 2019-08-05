Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FF5C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D611216B7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D611216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hue0N-0000pD-4z
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hudzg-0000Kd-Gf
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hudzf-0003ZZ-EJ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:29:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hudzf-0003Yt-8b
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:29:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so73212702wme.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E0C+RkYHks7HhA83e9f98hkN+BtCBQAgRM1EVdUf7a8=;
 b=JsNrWxiTieXEKUvhdGwDtuGe8lsjrPSPyhHDMgWCmVkf4DZWQuGx3TVusvKS8hk7RQ
 OzejWOyANutYHMnL4AmskBKyx6efc3Rz8nc8ptIMTs/mXc9jP8OV07O1CbHK2enMJ0X4
 gdeBnV4hXWQVh615QvFprFMQEf1ioIiUulqvQ7BT6SgBEE9sxEOXhhaTnotuXKr28eIU
 dIURSwERu8xM2Xl4f0y44aD1366ZbQd5dudp4Xlx1pDVYJyo6UxyGIEh0Cof8xQyUpKs
 ROvHRcCLSdCJXDVTGHFlY1FXUDsD4MLy9LXna2VLpd4kbYXfotOE2UmXhAcyqi2eGVb7
 TlUg==
X-Gm-Message-State: APjAAAWZkc//gOzBViGwjyjOcN7mdEpeXYrS5CyTp69N0Pmwwnbc52th
 3wGKQD3eAvW6k52tIf8AvoANtQ==
X-Google-Smtp-Source: APXvYqxEjstrtyyWgJGZ1skcEaR6OtLJUIHf1dA6KxOkYqMEA+zZHI4lyp8o5LS80jSu4c/bKOqUbQ==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr18715383wmg.65.1565015385872; 
 Mon, 05 Aug 2019 07:29:45 -0700 (PDT)
Received: from [192.168.1.74] (67.23.27.109.rev.sfr.net. [109.27.23.67])
 by smtp.gmail.com with ESMTPSA id b8sm114395860wmh.46.2019.08.05.07.29.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 07:29:45 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190803082517.15035-1-philmd@redhat.com>
 <CAFEAcA_cPDdwXkSra_8vxE8c9M2y91s5FvpB7sZh12xF-LPUWA@mail.gmail.com>
 <a4158e8a-d67f-52b5-c082-681d21ac2599@redhat.com>
 <19158743-5f00-f89c-d9af-5b991a581b6c@redhat.com>
 <CAFEAcA9zm-JXkzG05oHAfXQpEnW4x+Bi13TA7Hr1KQtEXSHWvg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9625d2b7-e61f-ead6-78ef-e2ca7b88b878@redhat.com>
Date: Mon, 5 Aug 2019 16:29:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zm-JXkzG05oHAfXQpEnW4x+Bi13TA7Hr1KQtEXSHWvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PULL 0/1] EDK2 firmware patches
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
Cc: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/19 4:14 PM, Peter Maydell wrote:
> On Mon, 5 Aug 2019 at 15:11, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Hi Peter,
>>
>> On 8/5/19 3:13 PM, Michal Prívozník wrote:
>>> On 8/3/19 12:22 PM, Peter Maydell wrote:
>>>> On Sat, 3 Aug 2019 at 09:26, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>>>
>>>>> The following changes since commit 9bcf2dfa163f67b0fec6ee0fe88ad5dc5d69dc59:
>>>>>
>>>>>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-CVE-2019-14378-pull-request' into staging (2019-08-02 13:06:03 +0100)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>   https://gitlab.com/philmd/qemu.git tags/edk2-next-20190803
>>>>>
>>>>> for you to fetch changes up to 177cd674d6203d3c1a98e170ea56c5a904ac4ce8:
>>>>>
>>>>>   Makefile: remove DESTDIR from firmware file content (2019-08-03 09:52:32 +0200)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> A harmless build-sys patch that fixes a regression affecting Linux
>>>>> distributions packaging QEMU.
>>>>>
>>>>> ----------------------------------------------------------------
>>>>>
>>>>> Olaf Hering (1):
>>>>>   Makefile: remove DESTDIR from firmware file content
>>>>
>>>> Is this pullreq intended for 4.1 ?
>>
>> Sorry, I was not sure how to comment on the pullreq cover (everything
>> between the '---' lines get include in the merge commit description).
> 
> Depends on your workflow. For me my pull-request-creation
> script creates a bunch of files which will be the emails
> to be sent out, and I can manually edit the 'cover letter'
> email before sending everything.

OK (I don't want to give you extra manual work).

>> This fix a regression introduced during the current development cycle.
>> Already 3 different distributions hit this issue and complained (Suse,
>> ArchLinux and Fedora).
>> This is not a critical/security issue and distributions can easily
>> backport this patch, but since there is a RC4 planned, it would be nice
>> regarding distributors to fix this if possible.
> 
> OK, sounds good -- I just wanted to check. I've pushed the
> pullreq to master.

Thank you!

