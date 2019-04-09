Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85077C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A355205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A355205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38922 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDoBv-00064z-Ie
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 06:41:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDoAs-0005CK-Uq
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDoAo-000372-4G
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDoAl-00036n-MB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so4611956wrn.11
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 03:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZI3/sLIf8M61o4FB6nPEbKtzD4235/w1ZxtjQUCKaNc=;
	b=BPsnmjSs31KPURl+p5knSbOGSl/LXT0Xy16i8iqRhftvWRHG8kWV7qf4yx++re3NtQ
	wsK24WENgd6QLe2AxttJ8GrlnXjzDrR44wbg03w38fmfHP3CxtP9gZ/PxO85r1Z8OBSd
	o4jWygStyaC0hKRSFkaQuDHWSw83B/uMSirsigsqvSZgiXBLq0H0HtLo4MnhKHDi0T0N
	oEvY/84hePJc0VcDTtJiixRqKO1/49BeDxNy3zuU4XewSNhFeCwuxYxeZaGdPUCYXHca
	brj9BiKVz++kHRqaBT3QRP7x3gIpPJCzUMcQRmhRk1kzAiFOAvyQp51Fqmp9hG/4nXL6
	tLhQ==
X-Gm-Message-State: APjAAAWAB1t8TVHjRJKEB2yBw5t57+MOe8s17wT2syuPwt2hSHQcqe+M
	pNFKvP9CivQ12Ve+jJCuYR/sMuHUxEM=
X-Google-Smtp-Source: APXvYqxYjVMDiomDY1QRM/VXycmrO9bEQjckGmHyx2HRFQ0Z7vxDvtwaBlqrFuPBNa0GEWTiZV8Qiw==
X-Received: by 2002:adf:e648:: with SMTP id b8mr22033489wrn.132.1554806410568; 
	Tue, 09 Apr 2019 03:40:10 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v190sm35063715wme.18.2019.04.09.03.40.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 03:40:09 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-4-armbru@redhat.com>
	<CAMxuvayc+RnpmFpUVFaLW2Uh8y6bZo2N4o6wu6YVyE1XRHtdWg@mail.gmail.com>
	<87bm1gr83k.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1f1ab942-49e9-0714-c6bc-65c7a0c4fa27@redhat.com>
Date: Tue, 9 Apr 2019 12:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm1gr83k.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 03/15] char-pty: Drop "char device
 redirected to" message
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409104003.MfVIEb2sjy3OYLPZYx6SAluC8bSqbreCCQGN1S10NzA@z>

On 4/8/19 2:31 PM, Markus Armbruster wrote:
> Marc-André Lureau <marcandre.lureau@redhat.com> writes:
> 
>> Hi
>>
>> On Mon, Apr 8, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> char_pty_open() prints a "char device redirected to PTY_NAME (label
>>> LABEL)" message to the current monitor or else to stderr.  No other
>>> ChardevClass::open() prints anything on success.  Drop the message.
>>>
>>> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  chardev/char-pty.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>
>> I guess that was printed for convenience.
>>
>> Allocated pty can be read from "info chardev", so I suppose we can
>> make qemu more silent. Fine with me:
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Thanks!
> 
> If we should decide the message is still useful enough to be worth
> keeping, I could direct it to stdout instead of dropping it.

I prefer this, if Marc-André is still OK.

