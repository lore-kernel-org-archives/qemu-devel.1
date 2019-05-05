Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A84C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7106E208C0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7106E208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNIwj-0006DI-Oc
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:20:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNIvj-0005Hb-0y
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNIvh-0004oH-Tw
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:19:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNIvh-0004mm-NJ
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:19:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id w1so1979439wmi.1
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/17JWLGq5wcUkT8EVkYTuHG6wOc4RBcy6zXEeGzXiL4=;
	b=PJgUveIBGrCh98zOXu33impT+cpRI9fc1xwKioFUOmtXlAPohShu+0Y2Wz7OeeLRnB
	VZN9vH9NP1bNYsmUZal3GwxOXDjsnEXm+dD3Iu/8z+xzXA/ZlsjY5RJUqm6+aR13ur0F
	e5GydsOSC0iVBJEZc+0dDZghoGQUNMxmboSr9mMwQpoN6pKdIBlhIVNJ2rqrey0bXwL6
	E8YIfHkpCaA9GYEYgnGRm3mT4s9a+xjOTGYArUjoy0AfIYFlPYjYdPPA+fQdGY42l4U8
	hIcX7SFbyZcgxC+FcW+nOKTVLxtoyRHAGcSCLW7k7D0Prit8Qfp+WtRYDNBqQDGXkIbd
	q+Hw==
X-Gm-Message-State: APjAAAXQ0Osm1kGWodtMcKV15sK5MCezzapjKznz1lU/rePn8HcOzdTC
	/L+N4Z1CzVUivkTbwOIS0qPfCA==
X-Google-Smtp-Source: APXvYqw2uiYeO8adFoYrRlyFcwU/cwUhjta0iO0TX+IzeqLTrawzDCBHhOtwfr+ca0OAkGhi6iwTnA==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr14011242wmh.137.1557069591201; 
	Sun, 05 May 2019 08:19:51 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id k1sm5968156wmi.48.2019.05.05.08.19.50
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 08:19:50 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org,
	hpoussin@reactos.org
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
	<1557003754-26473-4-git-send-email-atar4qemu@gmail.com>
	<7e282cd4-f402-c807-b9aa-7034d04031b6@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <debd00a6-dcc0-83a0-b0a8-1184d6da6d9c@redhat.com>
Date: Sun, 5 May 2019 17:19:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7e282cd4-f402-c807-b9aa-7034d04031b6@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 3/3] hw/isa/i82378.c: use 1900 as a base
 year
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
Cc: "open list:PReP" <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505151949.IejuUtIwFnaPw1BKTick367gg6BMa5V1zQxwK2eVCkI@z>

Hi Mark, Artyom.

On 5/5/19 12:46 PM, Mark Cave-Ayland wrote:
> On 04/05/2019 22:02, Artyom Tarasenko wrote:
> 
>> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
>>
>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
>> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
>> ---
>>  hw/isa/i82378.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
>> index a5d67bc..546c928 100644
>> --- a/hw/isa/i82378.c
>> +++ b/hw/isa/i82378.c
>> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>>      isa = isa_create_simple(isabus, "i82374");
>>  
>>      /* timer */
>> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
>> +    isa = isa_create(isabus, TYPE_MC146818_RTC);
>> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
>> +    qdev_init_nofail(DEVICE(isa));
>>  }
>>  
>>  static void i82378_init(Object *obj)
> 
> Is this true for the 82378 in general, or is it a particular quirk of the 40p
> machine/PReP specification?

This is indeed incorrect (see
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02452.html) so:
Nack

Artyom: I did wrote the patch and included it in another series based on
top of Joel Stanley's
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00657.html
which is also depending of another from Cédric, so I'll just extract it
and send directly, sorry for the delay.

Regards,

Phil.

