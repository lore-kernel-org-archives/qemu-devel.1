Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473BCC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0688E205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0688E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7wA-0007yI-6P
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:11:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL7tN-0005tL-Ob
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL7tM-00076a-9m
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:08:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL7tM-0006Q1-0Z
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:08:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so16545119wrs.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MpDgiLgJ9RRXgUs7sB2muXL9gf9ys+AyRP6KFcSBe2g=;
	b=kLHCIdByFmmVtsLYYWaSabMcAze9VneUmhG3X3EEsMpjSwuztKOPxIktkbqa3dif2W
	+JanifTTZY90BbTrhS6lvxrRij03SVewvexs0jNZU6yQJsF/05vwWQ2BoBVyJrrkI/wT
	e4GOHy4ps/aPBM0lsdEysxqGy+9Jm6xtOiGu4yYUEtcEitmnvmLKMksFyum06dHMugsR
	6mjilEOoff7hy95sez9i9LhG1yd2PJ3a1KOh4lAYGxd+WWZL4E3ZnmFB+alHdErZxeJj
	qu5aAyHLypOplF6cbOQhuScMHA0CYCssT9MATlB4QJtvgJUSQdQ9OH4Vt1tG2nS88lEJ
	ntMw==
X-Gm-Message-State: APjAAAXT4QRBDVCY7wOjiW6XJR6VwVmkvNBqfu1NKyPG966yOTif/jXd
	icGk0ke4r2vTMdx+rOYu8KU6Mg==
X-Google-Smtp-Source: APXvYqwjTrm88f5VUi+f7MCLkauYaswQp2D7ydZ4HwTVXJDIPPRndQ17lyHzANbbwqmfVbzTqp7ETQ==
X-Received: by 2002:adf:f749:: with SMTP id z9mr25511737wrp.218.1556550473246; 
	Mon, 29 Apr 2019 08:07:53 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	10sm32295838wmd.23.2019.04.29.08.07.52
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 08:07:52 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CAFEAcA8OVKO087uiNvwDGObiaxHAPYHwoXLEN1t5Y4v9B43r9A@mail.gmail.com>
	<20190429122819.GB7587@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <738394de-bd75-4ef3-10ef-de8cd07891de@redhat.com>
Date: Mon, 29 Apr 2019 17:07:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429122819.GB7587@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
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
Cc: Jim Mussared <jim@groklearning.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Steffen Gortz <qemu.ml@steffen-goertz.de>,
	qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
	Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429150751.xw33xDiE9useM1eb-v4COYaAy6haYF_x60gIE52B1Os@z>



On 4/29/19 2:28 PM, Stefan Hajnoczi wrote:
> On Fri, Apr 26, 2019 at 12:45:37PM +0100, Peter Maydell wrote:
>> On Fri, 26 Apr 2019 at 10:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>> On Thu, Apr 25, 2019 at 08:07:06PM +0200, Philippe Mathieu-Daudé wrote:
>>> Old boards probably want to continue using -kernel.  New boards like
>>> microbit may use just -device loader.  Perhaps there is even a group
>>> that wants both options.
>>>
>>> A solution is to introduce explicit checks so that we can tell the user
>>> the appropriate option for the machine type.  I can work on this if you
>>> like, but probably won't be able to send a patch until Tuesday.
>>
>> But it's difficult to tell how to identify whether there's really
>> any guest code there. For instance the user might want to start
>> QEMU, connect via the gdbstub and load guest code from gdb.
>> Or they might be using the generic-loader device. Or they might
>> really be using -kernel but with a broken guest image which doesn't
>> have a vector table in it, which will result in the same message.
>> I guess you could have a heuristic for "if an M-profile CPU is in reset
>> and the value it loads for the starting PC is zero and the gdb
>> stub is not connected, then print a warning that the guest image
>> is missing or there's no vector table" but I'm not a big fan of
>> heuristics...
> 
> I was going to add a function to check kernel_filename and the presence
> of -device loader.  Then each machine type init function would call the
> function with flags indicating which modes are allowed:
> 
>   /* Allow both -kernel and -device loader */
>   check_kernel_loaded(KERNEL_CMDLINE | KERNEL_LOADER);
> 
>   /* Allow only -kernel */
>   check_kernel_loaded(KERNEL_CMDLINE);
> 
>   /* Allow only -device loader */
>   check_kernel_loaded(KERNEL_LOADER);
> 
> This doesn't support the gdbstub use case you've described though.  No
> heuristics but a bit inflexible.
> What do you think?

We can check for QEMU_OPTION_gdb/QEMU_OPTION_s, if present display
warning, else display error? Or no warning at all...

