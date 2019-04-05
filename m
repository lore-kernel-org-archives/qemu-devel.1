Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD26C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAAE217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAAE217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38971 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCLDh-0006zF-NA
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:33:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCLCj-0006YK-37
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCLCh-0006BL-E4
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:32:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCLCf-00064s-FD
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:32:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so7142763wre.7
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 02:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=WlGImAp7Rqh7NxWvm79aznU+OyYHq+PWT6v+d2DwgI8=;
	b=o4aymwTNJ1zwam0tWm9Ai+lu8QpUMy7xNFxaWFZofQQj6zLOQZxTkRECcdsLznZUsX
	TmfsYBOf83vd2zY3iNsQCekrqY0SS3SLH6E7TLmsnvJrctpllSby7IgZI6QVsF0hXc3S
	v2rZjlWmX5mojKZiQ4h3Hv8mEJY5YwZxuHuwPHb8zfZXgFntNxSzcqCH4B/rMD7lr0yR
	Ny49vj7laSvTvX4IdKp1kE14rGMrbnPDfrOJ3UVrbYAtlj29UgUibTXbcpi//hl5wn/D
	jb60wDRsFqIrjJ1PABsq+wNg3WrSZE46ZvuBPnzscldqE7aOK+hryC9boIrS5Sn4Z6w9
	elsA==
X-Gm-Message-State: APjAAAXXCM102nMoFEM4j3J/z0NunKpbO7+H7kvE7AtZdizNIonXRbL3
	V/qgtqkILmxbJwmBNPp9vDaSOw==
X-Google-Smtp-Source: APXvYqzqreshXlYVVKXQM+YDFbiB0U+hNk0Ce2B2Elye8ixMS7+zPrGPWd4k+9FuN2rj4tuV5qj/rg==
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr7384530wre.55.1554456724337; 
	Fri, 05 Apr 2019 02:32:04 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z7sm15479333wrt.10.2019.04.05.02.32.02
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 02:32:03 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190404221238.12468-1-philmd@redhat.com>
	<20190404221238.12468-2-philmd@redhat.com>
	<ef95f30c-38e0-d7bd-533f-d8b9831bc62a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <26ccb60f-d80e-e309-7b53-718076678c78@redhat.com>
Date: Fri, 5 Apr 2019 11:32:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ef95f30c-38e0-d7bd-533f-d8b9831bc62a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/4] hw/isa/superio: Rename a
 variable
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405093202.jPeWjLjoRuzwoZpWLEe4IVVRymz1hBJjq0Q1I88uEz8@z>

On 4/5/19 6:14 AM, Thomas Huth wrote:
> On 05/04/2019 00.12, Philippe Mathieu-Daudé wrote:
>> This patch is purely cosmetic. No functional change.
>> This will ease the next patch where we re-indent an if() statement.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/isa/isa-superio.c | 69 ++++++++++++++++++++++----------------------
>>  1 file changed, 34 insertions(+), 35 deletions(-)
>>
>> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
>> index d54463bf035..c6845eaf578 100644
>> --- a/hw/isa/isa-superio.c
>> +++ b/hw/isa/isa-superio.c
>> @@ -22,8 +22,8 @@
>>  
>>  static void isa_superio_realize(DeviceState *dev, Error **errp)
>>  {
>> -    ISASuperIODevice *sio = ISA_SUPERIO(dev);
>> -    ISASuperIOClass *k = ISA_SUPERIO_GET_CLASS(sio);
>> +    ISASuperIODevice *s = ISA_SUPERIO(dev);
>> +    ISASuperIOClass *k = ISA_SUPERIO_GET_CLASS(s);
> 
> Sorry, but I have to say that I normally really don't like single-letter
> variable names. They are much harder to search for, and way less
> self-describing.

Me too ;) But sometimes I find the 80 chars/line limit generate
indentation harder to review. But here I have no excuse :)

> If you get problems with the line length in a later patch, what about
> refactoring the related code into a separate function? So that you'd
> only have something like this in the realize function:
> 
>     for (i = 0, j = 0; i < bus_count; i++, j += MAX_IDE_DEVS) {
>         if (!k->ide.is_enabled || k->ide.is_enabled(s, j)) {
>             isa_superio_init_ide(...);
>         }
>     }

Yes, fair enough. Note you used the shortened variables in your example! :P

Regards,

Phil.

