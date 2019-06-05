Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09AFC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97E120866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97E120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYZ3j-0001b6-Ni
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:46:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYZ2s-0001Ad-Dx
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYZ2q-0002L1-Eo
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:45:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hYZ2m-00025R-LH
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:45:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id e16so11938938wrn.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 09:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+M0Lo8+dGo7lLTJIg1iKmM6dn0nJi6J5nhH6HjzVIIc=;
	b=lS/+MXflljAC+WGh2oWgLO28DddTTkF+Ug5ETAuc9XBoyOfYXlil4ofKYVilGZnDAY
	mU0u7mZ1ZHXb/1tkXgr1bM4gDlKEsyUCX5YAfhfzPbv26HjrtzJyjtOvAmOijOze/R/H
	SuDA5Om11uN2w+j+wXPd1mBd+r++NDmwp9gb2WqVBGAJrErMSJ6yb4LCUuGtTch9KnAs
	D+GNwCiP5mIAtzFI6C2L/boNx3hctDSN1KyKEqzuDRtLINBJIHdw1q6DnFzoKA4Msu/x
	hfOhgnokjZ0G1+Ph8ByTzZhqJC/nEfqEtfmQYmwFPnYLP3wNlaaxA2DOT6et01cT6nn3
	dkyw==
X-Gm-Message-State: APjAAAWyaaIRQEcJz7nbqjvfYmDuWjOT7pun41uaMbvjcEVTOQgPDzDv
	nvbhr3rYdDRiYQea/lnvQJ/P6A==
X-Google-Smtp-Source: APXvYqzgWzWDLJth0h70BbEMTies7+jhSBpdzyg5OTNL2i2F85X+7rqQQqVxYkkl0Q8JitGGV8sY7w==
X-Received: by 2002:a5d:564b:: with SMTP id j11mr7059278wrw.153.1559753136619; 
	Wed, 05 Jun 2019 09:45:36 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	x129sm18801876wmg.44.2019.06.05.09.45.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:45:35 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, Olaf Hering <olaf@aepfle.de>,
	qemu-devel@nongnu.org
References: <20190530192812.17637-1-olaf@aepfle.de>
	<3e79c06b-cffb-977d-1f08-f1bb46dad795@redhat.com>
	<33ae1318-9019-62d2-3718-143c9ac5bd9a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1e3b8918-7397-b2d4-743e-19ff1958c92e@redhat.com>
Date: Wed, 5 Jun 2019 18:45:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <33ae1318-9019-62d2-3718-143c9ac5bd9a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1] Makefile: remove DESTDIR from firmware
 file content
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/19 6:31 PM, Laszlo Ersek wrote:
> On 06/05/19 16:46, Philippe Mathieu-Daudé wrote:
>> [Odd, I'm pretty sure I replied to this last week but can't find it, so
>> again]
>> Cc'ing Laszlo since he wrote this.
>>
>> On 5/30/19 9:28 PM, Olaf Hering wrote:
>>> The resulting firmware files should only contain the runtime path.
>>> Fixes commit 26ce90fde5c ("Makefile: install the edk2 firmware images
>>> and their descriptors")
>>>
>>> Signed-off-by: Olaf Hering <olaf@aepfle.de>
>>> ---
>>>  Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index f0be624f47..61267bf1a4 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -844,7 +844,7 @@ ifneq ($(DESCS),)
>>>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
>>>  	set -e; tmpf=$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
>>>  	for x in $(DESCS); do \
>>> -		sed -e 's,@DATADIR@,$(DESTDIR)$(qemu_datadir),' \
>>> +		sed -e 's,@DATADIR@,$(qemu_datadir),' \
>>
>> I'm fine with this patch.
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Laszlo, did you use the full path for a particular reason?
> 
> Yes. The reason was that I had no idea what DESTDIR stood for. After
> grepping the QEMU source tree for DESTDIR, I *still* have no idea what
> it stands for.
> 
> DESTDIR seems to be an installation prefix that is not controlled through
> 
>   ./configre --prefix=...
> 
> Based on memories from other projects -- with better documentation --
> though, DESTDIR looks like an install-time-only pre-prefix. In that
> sense, the patch looks correct (and the vague expression "runtime path"
> in the commit message starts to make some sense). Presumably DESTDIR is
> used in package build scripts... Yup, the RHEL spec files use it too,
> for "make install".
> 
> So, the patch is correct IMO:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Too bad QEMU is chronically under-documented (and the commit message on
> the patch doesn't help much in that regard).

At least the git history is public :)

