Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A51CC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E00220B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E00220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hudib-0003Gi-Ew
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hudiC-0002X3-Rb
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hudiB-0004zQ-Pi
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:11:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hudiB-0004xT-KI
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:11:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so74937220wma.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rILzswBqMu16j/NeIYTzHXQwBt8vqrrkCja05tDmKvg=;
 b=JJOtdigZdpVCSEaEgOaigclSOMTmW6Ts5CmubVPZ6+0H5pRfFLl+aDTty6lYCikWQ7
 Brj7xW68DAzYjXRWiuPSTMug7n7S/kZT8PGvKYYgG9Gud1TCxhdcn2OTwYzWh/bXcZzu
 PfV7X9+VR67uJRxEM27icGwGad7BlsfVlo1v1dLQ0gCDnCOA5jRxHINTFDjKiEmm9nwy
 TPhlot5UVgPECMgjm2FYZbSo1SPMwd3Kn1rpDrYDNN9THDCYUAlNTsoguUU9qDOfKebG
 yFs0O3t4Wrz4Y3zC2ac1lhc4pebCFXhss8CP/bwrOcbenu/QoymfwTKGM1Eo/lZPU6mh
 uBuw==
X-Gm-Message-State: APjAAAUbvgjExpGDq4K182udKFYp0sdAhs3FGSnMvUjq5MHfV2ma1ZW7
 9Zg3nLqkTi4EwwUFhxrC8+aERg==
X-Google-Smtp-Source: APXvYqzSkJd7126/1BwQNHwgPsltRtZQMKrrKHrX7uRk+Y6snUJ0YTtbPNwI0hfwvjRdq90is1PM4Q==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74mr19949582wme.9.1565014301358; 
 Mon, 05 Aug 2019 07:11:41 -0700 (PDT)
Received: from [192.168.1.74] (67.23.27.109.rev.sfr.net. [109.27.23.67])
 by smtp.gmail.com with ESMTPSA id b8sm75855398wrr.43.2019.08.05.07.11.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 07:11:40 -0700 (PDT)
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190803082517.15035-1-philmd@redhat.com>
 <CAFEAcA_cPDdwXkSra_8vxE8c9M2y91s5FvpB7sZh12xF-LPUWA@mail.gmail.com>
 <a4158e8a-d67f-52b5-c082-681d21ac2599@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <19158743-5f00-f89c-d9af-5b991a581b6c@redhat.com>
Date: Mon, 5 Aug 2019 16:11:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a4158e8a-d67f-52b5-c082-681d21ac2599@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 8/5/19 3:13 PM, Michal Prívozník wrote:
> On 8/3/19 12:22 PM, Peter Maydell wrote:
>> On Sat, 3 Aug 2019 at 09:26, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>
>>> The following changes since commit 9bcf2dfa163f67b0fec6ee0fe88ad5dc5d69dc59:
>>>
>>>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-CVE-2019-14378-pull-request' into staging (2019-08-02 13:06:03 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://gitlab.com/philmd/qemu.git tags/edk2-next-20190803
>>>
>>> for you to fetch changes up to 177cd674d6203d3c1a98e170ea56c5a904ac4ce8:
>>>
>>>   Makefile: remove DESTDIR from firmware file content (2019-08-03 09:52:32 +0200)
>>>
>>> ----------------------------------------------------------------
>>> A harmless build-sys patch that fixes a regression affecting Linux
>>> distributions packaging QEMU.
>>>
>>> ----------------------------------------------------------------
>>>
>>> Olaf Hering (1):
>>>   Makefile: remove DESTDIR from firmware file content
>>
>> Is this pullreq intended for 4.1 ?

Sorry, I was not sure how to comment on the pullreq cover (everything
between the '---' lines get include in the merge commit description).

This fix a regression introduced during the current development cycle.
Already 3 different distributions hit this issue and complained (Suse,
ArchLinux and Fedora).
This is not a critical/security issue and distributions can easily
backport this patch, but since there is a RC4 planned, it would be nice
regarding distributors to fix this if possible.

> Please do pull it into 4.1 as the commit it fixes is aiming at 4.1 (just
> like the whole feature). If not included then distros will need to
> backport it anyway. Just my $0.02. Let's wait for Philippe's confirmation.
Exactly.

Thanks,

Phil.

