Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B2BC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD79208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD79208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37007 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVeP5-00006B-Am
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 11:52:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVeOC-00089g-6o
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVeOB-0005LT-04
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:51:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVeO6-0005Ap-Qs
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:51:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id d17so3525197wmb.3
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 08:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=iWgxgtGHgIxIk9YYgTAWk8eP0xu0aRMTM93yvADB+uE=;
	b=E31ThEU5LiZMRxStmCT8EID8I1bgLuIBrIsACJPK0MNVgpX2nTbPfFKS9G/uaOJmx6
	Ap0Wr6s5BlY+tcqvqBdouIP2YBN0qD7Ew3ZuD2i4eb/xgEOU3IoOtcNeLhMGUaZApNNj
	YetvGMFN31/X3PmocG5gfM/hnLy0puacrMazF6cobsq85UdLvXgQ8hxjXHBXdxT/J3Ar
	/K1rbLXtzsOHeTofjA1hmdUZTntPZi8CP9RTBjhpdZpf47D9j/Li+Zy9GS85yF+c2HtD
	V30oNuNGeydqMk0AtbOyYDION5tBHYX5ZPJvifbZ0m0iib2SMrsnosnAQovStberMCGS
	9UMA==
X-Gm-Message-State: APjAAAVZJSdj/4EOlBqXO2CazaWuRFMzpxPoGjm2CRpZtWTpqMPC5SxA
	3Jk/n3ybhYM/e3BQQSIQC9tt5w==
X-Google-Smtp-Source: APXvYqw1tftMTN6rFLHyJgvUjuzFRuMuB991QBiFkCph2EXICo7CDLuf/BEyydTyVZQYKkG8hsI+Dw==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr3451713wmj.22.1559058701118;
	Tue, 28 May 2019 08:51:41 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id y8sm4611251wmi.8.2019.05.28.08.51.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 08:51:40 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190528140750.28036-1-philmd@redhat.com>
	<CAFEAcA8PmF-y8-RH6gC2mZQpUdOUEfHWp0aW_hwEDFHK7+QxwA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e51f26b7-7f81-8904-1a77-8a4bbbaf0f03@redhat.com>
Date: Tue, 28 May 2019 17:51:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8PmF-y8-RH6gC2mZQpUdOUEfHWp0aW_hwEDFHK7+QxwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] hw/scsi/vmw_pvscsi: Use qbus_reset_all()
 directly
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/19 4:12 PM, Peter Maydell wrote:
> On Tue, 28 May 2019 at 15:08, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Since the BusState is accesible from the SCSIBus object,
>> it is pointless to use qbus_reset_all_fn.
>> Use qbus_reset_all() directly.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> One step toward removing qbus_reset_all_fn()
>> ---
>>  hw/scsi/vmw_pvscsi.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
>> index 584b4be07e..6f571d0d19 100644
>> --- a/hw/scsi/vmw_pvscsi.c
>> +++ b/hw/scsi/vmw_pvscsi.c
>> @@ -440,7 +440,7 @@ static void
>>  pvscsi_reset_adapter(PVSCSIState *s)
>>  {
>>      s->resetting++;
>> -    qbus_reset_all_fn(&s->bus);
>> +    qbus_reset_all(&s->bus.qbus);
> 
> I thought our QOM style prefers using "BUS(&s->bus)"
> rather than looking inside the definition of the
> SCSIBus struct with "s->bus.qbus" ? (Compare preferring
> "DEVICE(s)" to "s->qdev".)

This is not explicit in HACKING/CODING_STYLE, but I agree this is
cleaner and better to treat the generic QOM objects as opaque, and use
the macros to check for the QOM type.

I'll respin.

