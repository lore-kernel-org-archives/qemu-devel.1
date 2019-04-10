Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C691C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608FC2084B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608FC2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE62i-0000Dg-H5
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 01:45:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE61w-0008Km-Ou
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE61u-0002nk-Qs
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:44:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hE61t-0002mR-JC
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:44:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so1086557wml.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 22:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=RuGfALqiLmdPsQdPEver0PKa2NZgQPFTkLI8axkZ5qA=;
	b=nyTrkKWD9u6xdA8pNnSy4L9X2mdqCqQfTo/iFAtvs2bnp3hO1tC6eIaNd+tpzEqC8j
	QdnRvB7VK3JG83/CUtzecfowvAVnxEtxLlTSwhcIJ2sgkd7t75H00EHoy/vj//jSRJm7
	nLjFWK+enuffvBaTh6DVWLaOVCF2XLw0jmeUgT+XveErbuuY6awbgIG8rTUsHgNHrvHa
	GiX3nbdCYSI5Dr1IE7rT0xpdZixeoIJ32RYBIoDzfuyCIHTJ7LK2PrqGeI7hD9+VaPAT
	K946qWF1/UBmLxial0U16hDgWXFBOGU8bNGRdi88Qyx2PRNbrrYAf1+NDuE/9DvyN2wp
	cXAg==
X-Gm-Message-State: APjAAAXjpVt24lzufOFiDu8no3TKa9kQLKJVok24SAHhswqup974Q4fC
	SOjZBHpFPZ/w7po4ij0+DkxdKA==
X-Google-Smtp-Source: APXvYqzK7Ee4Ew/mXHgpvIb+NHh+WOrnSVjXWiOUGxOkMfR+1orec/GOt6VujQFRsBIkVsaJe1eizA==
X-Received: by 2002:a1c:9617:: with SMTP id y23mr1283998wmd.31.1554875052376; 
	Tue, 09 Apr 2019 22:44:12 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	i28sm99207705wrc.32.2019.04.09.22.44.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 22:44:11 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
	<874l764eez.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <38442eb0-501e-dbf8-60e0-74675a999dba@redhat.com>
Date: Wed, 10 Apr 2019 07:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <874l764eez.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
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
Cc: peter.maydell@linaro.org, alistair.francis@wdc.com, qemu-devel@nongnu.org,
	slp@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410054410.3hoylYTQwe82SCPRuZ2nPvPpFtgTzXiunrU97F7iveM@z>

On 4/10/19 7:28 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>> On 4/9/19 7:40 PM, Markus Armbruster wrote:
>>> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
>>> computation of @dt_size overflows to a negative number, which then
>>> gets converted to a very large size_t for g_malloc0() and
>>> load_image_size().  In the (fortunately improbable) case g_malloc0()
>>> succeeds and load_image_size() survives, we'd assign the negative
>>> number to *sizep.  What that would do to the callers I can't say, but
>>> it's unlikely to be good.
>>>
>>> Fix by rejecting images whose size would overflow.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  device_tree.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/device_tree.c b/device_tree.c
>>> index 296278e12a..f8b46b3c73 100644
>>> --- a/device_tree.c
>>> +++ b/device_tree.c
>>> @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, int *sizep)
>>>                       filename_path);
>>>          goto fail;
>>>      }
>>> +    if (dt_size > INT_MAX / 2 - 10000) {
>>
>> We should avoid magic number duplication.
>> That said, this patch looks safe.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks!
> 
>> BTW how did you figure that out?
> 
> Downstream handling of upstream commit da885fe1ee8 led me to the
> function.  I spotted dt_size = get_image_size(filename_path).
> Experience has taught me to check the left hand side's type.  Bad.  Then
> I saw how dt_size gets increased.  Worse.

So you genuinely neglected to mention Kurtis Miller then :)

>>> +        error_report("Device tree file '%s' is too large", filename_path);
>>> +        goto fail;
>>> +    }
>>>  
>>>      /* Expand to 2x size to give enough room for manipulation.  */
>>>      dt_size += 10000;
>>>

