Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1075C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADABC20825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADABC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45934 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNz4q-0005rn-S7
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:20:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNz2H-0004aT-8b
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNz2G-0006k8-D9
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:17:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNz2G-0006jP-7f
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:17:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id j187so3642232wmj.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wtAOQ44i8ItsYRj++6bN+njSZRVY/UHVJci6HQ5foCc=;
	b=eNUMKVfDO/q2VsD/7KT7mzn+dC2/vZQmtecblF4xXW5njDOtJPGspxMp1DeADcBZFo
	KVXvDO3G9KFefrtuTv400bLb6rSF83qjXmOtKFdJ4OgNe84XoUA7n8GSaRUiQxWUtX1j
	tUR/7XTW6aqT5Sy1D5Z6lkCrL579PXtMxQGNlENhfjhRQy7JtUvOa1GAC4ZAxdwQd8FB
	O5GVS6R1CzmIafdQChVcKOpSvJB/1POZAXmz1KH9l1Etae4GezShq71EX7/AKA5DJ8x1
	Lw5KsUukHKbFIF7V941uVtjME76G9fBj+jEvEU8s7OXKIaYwJb5nHD61kjp9dgQ6j3CD
	PFcA==
X-Gm-Message-State: APjAAAXiyvbKulb6uuYF2Ws5mn02CmREQAmNCEp7MQGGbpBwsOzbD/0u
	36JZY6LzGIYsJ+cisRcTkoT9iA==
X-Google-Smtp-Source: APXvYqz+vdPvB59R9GC7sb4BBdPMuV+KWke0p7xLgXPLfiBfZpwrOWuilvJ+lI9DxgHhNSusA0dX2A==
X-Received: by 2002:a1c:4087:: with SMTP id n129mr2171839wma.14.1557231446836; 
	Tue, 07 May 2019 05:17:26 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a6sm12656798wrp.49.2019.05.07.05.17.25
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:17:25 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	QEMU Trivial <qemu-trivial@nongnu.org>
References: <20190506141923.12183-1-philmd@redhat.com>
	<fcf6d003-36b2-9e8c-4708-58293a610a6e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <acff1361-31c1-9379-21e4-3c9867360e79@redhat.com>
Date: Tue, 7 May 2019 14:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fcf6d003-36b2-9e8c-4708-58293a610a6e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 0/2] roms: Add 'clean' make rule and
 EDK2 documentation fix
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 12:56 PM, Laszlo Ersek wrote:
> On 05/06/19 16:19, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> Two trivial patches waiting Laszlo's series to land.
> 
> ... I think you can submit a pullreq with these two patches now --
> because I believe that you refer to
> 
>   [Qemu-devel] [PULL 00/12] bundle edk2 platform firmware with QEMU
> 
> above, and that's been merged for a while now.

Hmm I sent the previous series Cc'ing qemu-trivial@nongnu.org, but not
this one. That's odd (because I use git-publish which takes care of
keeping the same destinataries since the previous version), I probably
messed something.

I won't submit a PR that keeps Peter's test setup busy a while for 2
lines of documentation changes =)

Cc'ing qemu-trivial@nongnu.org again, hoping they can queue this, since
there is no rush.

Thanks!

Phil.

