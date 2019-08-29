Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFFCC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6791F2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6791F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Ok1-0007AM-KG
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Oj5-0006eO-RW
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Oj4-0003xt-9r
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Oj4-0003s2-0B
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:00:50 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 88B2612E5
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:00:40 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id e14so2472292wrd.23
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vs8yMwzN3NSSsYT9mv8mp+mk9RKAJUEIDiVZGrOb5zc=;
 b=s3w7BHrwq0fw7SNT/xy+Ru/VqL7iRWp+QGjY94iN14QDN3+YyjbXfbVqzMeQ2/aPjN
 AIj17+Kx/h5AF/QdrHr5BWoUS0lYaUTlgvPdRXJomH2nzr2tlb/XAZrTsoeZuLuMen/N
 iGREbXE4WhOQtGLBdWE2X8zLd3rJpoSvuEHYUUvZ9SWE/RJ4tvSLwsd5zIFPnj7j6UZi
 nTEFo+QI14VLNWHPAiQF0HrxhP7yAD6MxWJqI7xMZXhUxrDsPvsqS2xer/WsOa5tA92g
 8EZcmUL89UeCFQC2gZZTZrXn45AB4gYlmPVOZo6920Gaw6HOm/Cb116PRIAogSDW1t4H
 QWgA==
X-Gm-Message-State: APjAAAVdvbXTNUksrsGCAu2JZ144afsveA9axPu43mWxPqGfeZ6PAsue
 QmoRtVnHNARNq7ApavhAcP4RZ5HeVX3VugNXz0sfb/CB3V0LHRzO0IpgGY6j591msIb9GG3xa0Y
 rzpEqfLtNkt/GErw=
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr12913443wrv.272.1567101639293; 
 Thu, 29 Aug 2019 11:00:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxxudAL/3vb4CyatA/Ve1RGUtjriTxtLdAYSbrl0kra166LuM4TUTa4HwKNBQqo5KrgwyWOw==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr12913428wrv.272.1567101639119; 
 Thu, 29 Aug 2019 11:00:39 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id 12sm2301076wmi.34.2019.08.29.11.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 11:00:38 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, Jan Kiszka <jan.kiszka@web.de>
References: <f056c7e5-fa74-469c-87f8-0f0925301b2d@web.de>
 <90ea3127-5e26-ed2a-4ad7-d30445bcf53a@web.de>
 <20190827194948.GB7077@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <055f099e-c9a7-1d75-7dcc-0d8916988cc6@redhat.com>
Date: Thu, 29 Aug 2019 20:00:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190827194948.GB7077@habkost.net>
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

Hi Jan,

On 8/27/19 9:49 PM, Eduardo Habkost wrote:
> On Sun, Aug 25, 2019 at 04:58:18PM +0200, Jan Kiszka wrote:
>> On 21.07.19 10:58, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> nb_queue was not zeroed so that we no longer delivered events if a
>>> previous guest left the device in an overflow state.
>>>
>>> The state of absolute does not matter as the next vmmouse_update_hand=
ler
>>> call will align it again.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>   hw/i386/vmmouse.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
>>> index 5d2d278be4..e335bd07da 100644
>>> --- a/hw/i386/vmmouse.c
>>> +++ b/hw/i386/vmmouse.c
>>> @@ -257,6 +257,7 @@ static void vmmouse_reset(DeviceState *d)
>>>       VMMouseState *s =3D VMMOUSE(d);
>>>
>>>       s->queue_size =3D VMMOUSE_QUEUE_SIZE;
>>> +    s->nb_queue =3D 0;

Don't we also need to reset the status in case vmmouse_get_status() is
called directly after reset?

         s->status =3D 0;

With it:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>>>
>>>       vmmouse_disable(s);
>>>   }
>>> --
>>> 2.16.4
>>>
>>>
>>
>> Ping - or who is looking after this?
>=20
> Despite being in hw/i386, I think we can say vmmouse.c doesn't
> have a maintainer.  Last time someone changed vmmouse.c in a
> meaningful way (not just adapting to API changes or removing
> duplicate code) was in 2012.
>=20

Well it does has a few:

$ ./scripts/get_maintainer.pl -f hw/i386/vmmouse.c
"Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 TCG CPUs)
Richard Henderson <rth@twiddle.net> (maintainer:X86 TCG CPUs)
Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86 TCG CPUs)

However the correct section should rather be "PC Chipset".

> But the change makes sense to me, so:
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> I'll queue it.
>=20

