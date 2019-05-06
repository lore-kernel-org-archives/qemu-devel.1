Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ACCC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37CD2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37CD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNiRz-0001oA-6E
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 14:34:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNiQ2-0000po-Hm
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNiQ1-0002tW-Dt
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:32:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNiQ1-0002ry-6y
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:32:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id m20so6024316wmg.1
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 11:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bB6HdO1hV5S/e+203cs2u4VEx0lSy9c6Ee7FCQQZ5eI=;
	b=bZRClTYo1q0uKsNl0FbzFhh4hxAJ2fuPYlG2CE6UdV24gAaYiqeaNU43+1kOVvOrAN
	rFnWd5w9SogFMAxhuiJs5YJ3Bvy2xSQdOUh1cXyBKBxMs1bd9IKF/SQ0wYw8Yp3MMowK
	sdDtyr1OYYalRCu8nwqsxQcy352U+5mjR5wqSycjm85QE/zUFbM1g4/SnpcXSjgYzRTi
	Jqw1WlDujVHKqetjDj+XlS96EjbLAs0sFSQ03fYc55rKSsHIM6mHZ4WGxmNVvXLVhpqZ
	lhxa1nbiLSCbFOj/hQ83ALx+q8E9u152bUfXjj+ob5fhXgrB/FEZ5WxBOg0CIpjkbXOX
	sUHw==
X-Gm-Message-State: APjAAAW5pxzz7zCKVK2DzqBJvxcuNSJsS625yHRUxJW8QYMdXbJ6azD3
	idchGLZ7sGkR821JTRaxvAsHrQ==
X-Google-Smtp-Source: APXvYqy0yrGNgFUnnarKZH5+Rutbc7WS+YTJFmhluo4VOk/GRvQ1QDNFOCkr5ylzcwHU/EH66UsXEQ==
X-Received: by 2002:a1c:a008:: with SMTP id j8mr18082372wme.73.1557167571065; 
	Mon, 06 May 2019 11:32:51 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	x17sm10194072wru.27.2019.05.06.11.32.49
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 11:32:50 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
References: <20190505200602.12412-1-philmd@redhat.com>
	<20190505200602.12412-6-philmd@redhat.com>
	<25a7725c-3ac4-43cb-cd0a-cfc4007b244c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d0f5b01d-9b9b-9b8f-30b2-c58b719a7bc4@redhat.com>
Date: Mon, 6 May 2019 20:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <25a7725c-3ac4-43cb-cd0a-cfc4007b244c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 5/5] hw/block/pflash_cfi02: Add the
 DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 5:17 PM, Laszlo Ersek wrote:
> On 05/05/19 22:06, Philippe Mathieu-Daudé wrote:
>> The pflash device is a child of TYPE_DEVICE, so it can implement
>> the DeviceReset handler. Actually it has to implement it, else
>> on machine reset it might stay in an incoherent state, as it has
>> been reported in the buglink listed below.
>>
>> Add the DeviceReset handler and remove its call from the realize()
>> function.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1678713
>> Reported-by: Laszlo Ersek <lersek@redhat.com>
> 
> - IMO, the above two tags should be dropped from the commit message, as
> they are specific to CFI01.

OK.

> - Additionally, the commit message references the realize() function
> (correctly), but the patch doesn't change that function. That is, the
> patch doesn't remove the pflash_reset() call from pflash_cfi02_realize()
> that was introduced in the last patch.

You found a bug, having your reviewing CFI02 is useful :)
I had it correct in a staged branch, then messed while rebasing.

Thanks for noticing this,

Phil.

> 
> Thanks
> Laszlo
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/block/pflash_cfi02.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
>> index f321b74433c..5af367d1563 100644
>> --- a/hw/block/pflash_cfi02.c
>> +++ b/hw/block/pflash_cfi02.c
>> @@ -674,6 +674,11 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>>      pfl->cfi_table[0x3c] = 0x00;
>>  }
>>  
>> +static void pflash_cfi02_reset(DeviceState *dev)
>> +{
>> +    pflash_reset(PFLASH_CFI02(dev));
>> +}
>> +
>>  static Property pflash_cfi02_properties[] = {
>>      DEFINE_PROP_DRIVE("drive", PFlashCFI02, blk),
>>      DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, nb_blocs, 0),
>> @@ -701,6 +706,7 @@ static void pflash_cfi02_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>  
>> +    dc->reset = pflash_cfi02_reset;
>>      dc->realize = pflash_cfi02_realize;
>>      dc->unrealize = pflash_cfi02_unrealize;
>>      dc->props = pflash_cfi02_properties;
>>
> 

