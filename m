Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C4BC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1397D215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1397D215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3PKf-00051c-AS
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3PJf-0004Tp-Vm
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3PJe-0001SB-BK
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:38:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3PJe-0001R6-3Y
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:38:38 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BBBDA796FC
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:38:36 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 19so2076924wmk.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+m3L+ZGL1s692oFNAw3ClQDshQv5F2SCqK4XZGSftPc=;
 b=s4/AKM0r8QA//hD9Tt6WML7LJZfAWQ9F4jGu0cJWBVTXdGIrqwZiQW8BbH/JKxIVPn
 pYLK7kD7Ac0EFMKIezooN3sMS7PkjOWBdA49ikhXOELWw7Kq0b4trEf893qqCk6MQqzH
 hity7Ql//g944Hmm4GyohPwp4ucsow6bQLAMvIO1fsPnrFQGlXI5+hz/as7wdZtMwmef
 xlOU5drvQNEGvhxitLRVyeQVrEsHGQsuBp0q95l/8o/E4hQQ03GR6dAdN/WpZ1Qqe7Rl
 BFADBGFdGgdE9vz9tggTV27AgXE+x+w81zj+tZJBy2LzDeMehLJBR5lFB6xw65Pc+I7i
 yUUA==
X-Gm-Message-State: APjAAAU1XGHyy/e4KLzpQ8OBcSLPBAU47O98VePfE07ooUNyivMl47YA
 zY3sAYViHYCxuAZhU8FKvc/rR+mYG8JFXJ7gLUTCvQ06/DpBiLLfVJqxHdWsScg8+HAyV5thLIk
 sljYOgJM/TnWtcAE=
X-Received: by 2002:a5d:4582:: with SMTP id p2mr1088982wrq.305.1567103915554; 
 Thu, 29 Aug 2019 11:38:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjKbVLzvY4vL1RUHq9zHz4Q0wQXHwgmHXLmtKwpZKtOjXbdWR4vD6AMNReSCjSkXRa0aLLBA==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr1088928wrq.305.1567103914976; 
 Thu, 29 Aug 2019 11:38:34 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id i18sm5220116wrp.91.2019.08.29.11.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 11:38:34 -0700 (PDT)
To: Jan Kiszka <jan.kiszka@web.de>, Eduardo Habkost <ehabkost@redhat.com>
References: <f056c7e5-fa74-469c-87f8-0f0925301b2d@web.de>
 <90ea3127-5e26-ed2a-4ad7-d30445bcf53a@web.de>
 <20190827194948.GB7077@habkost.net>
 <055f099e-c9a7-1d75-7dcc-0d8916988cc6@redhat.com>
 <b5878351-cf0f-81c3-5965-eec20b59996e@web.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6278a641-c6bd-d676-359a-478c398a307a@redhat.com>
Date: Thu, 29 Aug 2019 20:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b5878351-cf0f-81c3-5965-eec20b59996e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386/vmmouse: Properly reset state
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 8:12 PM, Jan Kiszka wrote:
> On 29.08.19 20:00, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Jan,
>>
>> On 8/27/19 9:49 PM, Eduardo Habkost wrote:
>>> On Sun, Aug 25, 2019 at 04:58:18PM +0200, Jan Kiszka wrote:
>>>> On 21.07.19 10:58, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> nb_queue was not zeroed so that we no longer delivered events if a
>>>>> previous guest left the device in an overflow state.
>>>>>
>>>>> The state of absolute does not matter as the next
>>>>> vmmouse_update_handler
>>>>> call will align it again.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 hw/i386/vmmouse.c | 1 +
>>>>> =C2=A0=C2=A0 1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
>>>>> index 5d2d278be4..e335bd07da 100644
>>>>> --- a/hw/i386/vmmouse.c
>>>>> +++ b/hw/i386/vmmouse.c
>>>>> @@ -257,6 +257,7 @@ static void vmmouse_reset(DeviceState *d)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMMouseState *s =3D VMMOUSE(d)=
;
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->queue_size =3D VMMOUSE_QUEU=
E_SIZE;
>>>>> +=C2=A0=C2=A0=C2=A0 s->nb_queue =3D 0;
>>
>> Don't we also need to reset the status in case vmmouse_get_status() is
>> called directly after reset?
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->status =3D 0=
;
>>
>=20
> Thanks for checking. We call vmmouse_disable() here, and that sets
> status to
> 0xffff anyway.

I missed that, you are correct :)

So:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmmouse_disable(s);
>>>>> =C2=A0=C2=A0 }
>>>>> --=20
>>>>> 2.16.4
>>>>>
>>>>>
>>>>
>>>> Ping - or who is looking after this?
>>>
>>> Despite being in hw/i386, I think we can say vmmouse.c doesn't
>>> have a maintainer.=C2=A0 Last time someone changed vmmouse.c in a
>>> meaningful way (not just adapting to API changes or removing
>>> duplicate code) was in 2012.
>>>
>>
>> Well it does has a few:
>>
>> $ ./scripts/get_maintainer.pl -f hw/i386/vmmouse.c
>> "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
>> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>> Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 TCG CPUs)
>> Richard Henderson <rth@twiddle.net> (maintainer:X86 TCG CPUs)
>> Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86 TCG CPUs)
>>
>> However the correct section should rather be "PC Chipset".
>>
>>> But the change makes sense to me, so:
>>>
>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>
>>> I'll queue it.
>>>

