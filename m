Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7FBC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A6A205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A6A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQa5c-0006R9-Cs
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:15:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQa49-0005L6-RL
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQa47-0004bU-Re
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:14:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQa44-0004Li-BP
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:14:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so3497522wme.3
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EdoZQthCrUH1rq9oZofl1NSqIzFWV+CPYyxzTmP7mww=;
	b=q74cAw3BjcBT2WtGXjPcUdPErJ0DXxtNjYoXR+2a56f7yhUzYi18tRxFZCsCQ5B9ja
	11g6vTzE2sSfX2a4lhOTpqHH2iTTH1T5UdLW9aFoSLMr6PMkyRgPHrPjuJQfaeBwid4h
	nqx75XaIHcIKCCXRqixjqlHAQHQJVm3NRiNH9MonZTi5zwuvRpVg24E5vnaB2NUDyrpu
	cIv2dmcJ1L0heI24L6gwsV3zaPNMj/zFbuavzXfVCau3X1CLxDlTFGeunzHw5YEgXdj9
	FaPxfdNLVm+QxkfpxcDB6EqAZP42gUn9sh14SYqaW6PpaiPA54EKsR8eGg78PCwoKi7z
	NWZg==
X-Gm-Message-State: APjAAAUtr+iQ2hrn4/LdOcKuREMRlm3od+u33SaLI/+cqLUXRq2xzp8m
	ymrnAEZrBxCW/40kJOGoxBmUcg==
X-Google-Smtp-Source: APXvYqz+g/UJuf2BLMUQBC6CBgui230K25N0+aE5mgfMSAxfUuGLVznkdcbrWXmdjTWONaSaqqfQlA==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr18865434wmc.59.1557850434383; 
	Tue, 14 May 2019 09:13:54 -0700 (PDT)
Received: from [192.168.1.43] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id y1sm3817734wma.14.2019.05.14.09.13.53
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 09:13:53 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190510185438.29533-1-richard.henderson@linaro.org>
	<20190510185438.29533-4-richard.henderson@linaro.org>
	<CAL1e-=hRXg7eykwjDxTDXt33FiFOAkkGQk23mEZRB3ChaZcAQA@mail.gmail.com>
	<87bm05nijn.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e7cc54ef-c40c-1ea4-792b-b3d44abe7739@redhat.com>
Date: Tue, 14 May 2019 18:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm05nijn.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PULL v2 12/27] target/mips: Convert to
 CPUClass::tlb_fill
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, peter.maydell@linaro.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:48 PM, Alex Bennée wrote:
> 
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
> 
>> On May 10, 2019 8:57 PM, "Richard Henderson" <richard.henderson@linaro.org>
>> wrote:
>>>
>>
>> Please change the title to 'target/mips: Switch to using
>> mips_cpu_tlb_fill()', or something along that line.
> 
> It does seem a little redundant as "target/mips:" already marks it as a
> mips specific change and viewing the log you can see a series of
> architectures being converted to a new API.
> 
>> Also, the reason for changing the field access_type to mips_access type
>> should be explained in the commit message.
> 
> ok
> 
>> This commit message is generally poor, as it explains relatively
>> unimportant logging issue, while not explaining the core of the
>> change.
> 
> Surely the core of the change is explained in the main patches that
> introduce the new API? I think it would be redundant to repeat that for
> every individual architecture touched. It's a shame it's hard to
> explicitly reference a patch in the same series as the commit hashes are
> not yet permanent. At least when we fix things referring to the short
> hash of the original commit is fairly easy.

Except in the case the maintainer is sending a pull request (like here)
where he can manually fix the commits. Still this is a PITA...

> 
> Generally for an architecture conversion I want to know what might be
> different from other architectures converted. If it is a broadly
> mechanical change it doesn't need to be too detailed.

