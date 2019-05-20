Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B3C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83E221479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83E221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSprc-0007zb-Td
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:30:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSpqp-0007bd-1s
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSpqn-0007F5-U8
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:29:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSpqn-0007E5-OH
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:29:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so849856wme.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 14:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=GWjy0qbJfehsC2gkj4ZFDg83/l5QQSBrj3Ka+2Q6ynY=;
	b=Rzn6bRisYjZUS8DK8FzOQekzmgtBHel3N6B1ZkE2uWKcB5M9cwlpU4bCooOlQEpOuD
	Q5uGEilQEUoOtYfG3X/QqOH6tCQvsZdFAMplQsKsKFcHOA5Tv4uaB2LF+B0DCzjbkmRT
	X4xi2ZKpDCtlVSrJXMfuiQRynJ8TkRjXuJ9tOsYNMlRa+wANYmPiwWGBsR3hvNLL3Hwx
	BEvAuZwc/HCP3U4qMsKyz+aREzYHsxP6JItC2OGSm0R6/Moum4Tb0YK6ZgtE5+vWX0Qe
	ps+8F0E0Xq+nKd2rbnUXcnA4lF00f7zHdqQbaBUkDR0TsOArM9Rx0krtCsQAu0e2H4mJ
	Ysmw==
X-Gm-Message-State: APjAAAUfpHdF9yGKG4RsN8Prh0kTdel4Pcnrj5dqRjJKRPoHXofkkh7r
	d6kefqOpZ6j9DGszwuwTxDtO79Itm1I=
X-Google-Smtp-Source: APXvYqzN1oPWCJjdyN2H/XL7X0HBdZn8pkoaJcc4nD7UsiRov9nK/MyAIyeqJ0yba9G/kcVhQu7wdQ==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr795870wmk.15.1558387780011;
	Mon, 20 May 2019 14:29:40 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	h12sm12759633wre.14.2019.05.20.14.29.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 14:29:39 -0700 (PDT)
To: Li Qiang <liq3ea@gmail.com>, Li Qiang <liq3ea@163.com>
References: <20190424140643.62457-1-liq3ea@163.com>
	<CAKXe6S+J7OgqJkrDByo3y9M5BGTaCN0Cjb0_WYxDyTvFGg-w8w@mail.gmail.com>
	<CAKXe6SL3x6S5Pco6ZdFvPpmwPhPj6d2B7mFLDbyGoSqcGB+KCQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c1153add-2518-ce69-1c83-eb46d6c643ac@redhat.com>
Date: Mon, 20 May 2019 23:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6SL3x6S5Pco6ZdFvPpmwPhPj6d2B7mFLDbyGoSqcGB+KCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two
 test cases
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
	Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Li,

On 5/17/19 4:28 AM, Li Qiang wrote:
> Ping.....
> 
> Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>> 于2019年5月9日周四
> 下午5:57写道：
> 
>     Ping.... this serials.

I apologize I hold this series for too long.
With your v1 I wanted to clarify the commit descriptions without asking
you to send a v2, then I reword your patches and the same day you sent
your v2, then I had mixed feeling about how to do to not frustrate you
asking to respin again, but I ended it worst :(
I adapted the descriptions on your v2 and will repost as v3, then merge
if you are OK with v3.

Regards,

Phil.

> 
>     Thanks,
>     Li Qiang
> 
>     Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>> 于2019年4月24日周
>     三 下午10:07写道：
> 
>         In the disscuss of adding reboot timeout test case:
>         https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html
> 
>         Philippe suggested we should uses the only related option for one
>         specific test. However currently we uses one QTestState for all the
>         test cases. In order to achieve Philippe's idea, I split the
>         test case
>         for its own QTestState. As this patchset has changed a lot, I
>         don't bump
>         the version.
> 
>         Change since v1:
>         Add a patch to store the reboot_timeout as little endian
>         Fix the endian issue per Thomas's review
> 
>         Li Qiang (5):
>           tests: refactor fw_cfg_test
>           tests: fw_cfg: add a function to get the fw_cfg file
>           fw_cfg: reboot: store reboot-timeout as little endian
>           tests: fw_cfg: add reboot_timeout test case
>           tests: fw_cfg: add splash time test case
> 
>          hw/nvram/fw_cfg.c     |   4 +-
>          tests/fw_cfg-test.c   | 125
>         +++++++++++++++++++++++++++++++++++++++---
>          tests/libqos/fw_cfg.c |  55 +++++++++++++++++++
>          tests/libqos/fw_cfg.h |   9 +++
>          4 files changed, 184 insertions(+), 9 deletions(-)
> 
>         -- 
>         2.17.1
> 
> 

