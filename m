Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1240C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798E0256CF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798E0256CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWHtu-0007tG-DW
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:03:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWHsq-0007T4-9f
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWHsp-0002ji-3t
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:02:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWHso-0002ia-U2
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:02:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id t5so3437321wmh.3
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=T6oG6/hElIryF7pWU2YE+/IyH+aJutyQpyU+obE3XqA=;
	b=OGDzXb3EW8ZYxOkhtl9TEuKKOD/VmI0DQThr0MeKhSnMLD5BLKbyHcsj0gouQyhL4R
	4bwBPbT7JLxeugnDAKX2R/qpfyFYYx9ryThKKNRHhoKJeC1lkSRv5IWD3X8oBMiBnLJY
	HACSks42yy3X8NaHHxFafw5QLI1D+VhhuoWVBurNKl2NAVClGjSPKULUct+s1Wvdp4Jc
	3lIm2SjOPpxlf3TLQgYAT8fZRlGMgPGTDjx23RZtt2KvceHxy/UkSgDtde3Q7dTJt8XM
	/sGLro+ySh79iqLxaex/hyxqpCyTu/L8y1C7RwLRnyn8pTcJ+fpO7hxx8fD8/9Nsyeie
	7d6g==
X-Gm-Message-State: APjAAAX5zUN5yDnsCkOJQpNQe8+4A11vFfC61KjOC1++d0FP9aqsHg5c
	v+vwrnubA2EbMBsQJFH/MX0Geg==
X-Google-Smtp-Source: APXvYqxqjdtX31+6G5c8UPrNATV2o9IrNrsdRi84peViOYlIRndaOEO2uWUpNW0cGw4ETF2ktNIrig==
X-Received: by 2002:a1c:f111:: with SMTP id p17mr1786591wmh.62.1559210521832; 
	Thu, 30 May 2019 03:02:01 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	l190sm2951931wml.16.2019.05.30.03.02.00
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 03:02:01 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
References: <20190520124716.30472-1-kraxel@redhat.com>
	<878suo5ls0.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f77a0c5b-c36e-4c44-5c3b-580e977682d5@redhat.com>
Date: Thu, 30 May 2019 12:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <878suo5ls0.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console
 autoinstall, misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 11:33 AM, Alex Bennée wrote:
> 
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
>> This patch series changes the way virtual machines for test builds are
>> managed.  They are created locally on the developer machine now.  The
>> installer is booted on the serial console and the scripts walks through
>> the dialogs to install and configure the guest.
>>
>> That takes the download.patchew.org server out of the loop and makes it
>> alot easier to tweak the guest images (adding build dependencies for
>> example).
>>
>> The install scripts take care to apply host proxy settings (from *_proxy
>> environment variables) to the guest, so any package downloads will be
>> routed through the proxy and can be cached that way.  This also makes
>> them work behind strict firewalls.
>>
>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>> was struggling with.  See commit messages of individual patches for
>> details.
> 
> Queued to testing/next, thanks.
> 
> One of the machines I'm testing on seems to have problems with getting
> the installer working over the serial link but it works on my main dev
> box and others have it working as well so I suspect it might be a local
> problem.

Is this the same issue I described there?
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06784.html

