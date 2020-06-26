Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A1221532
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDmo5m+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A1221532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokuQ-0006CX-7J
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1joktp-0005fL-HG; Fri, 26 Jun 2020 05:43:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1joktn-0007ZR-Sl; Fri, 26 Jun 2020 05:43:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so8837162wrc.7;
 Fri, 26 Jun 2020 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=epw7Ya6mrSaGCZp6nWlwRKSneX+jRfVGp7MULgc8HsY=;
 b=vDmo5m+w1Mca2MdXfsczqoN8j7EfGlJY3KNbkhXGS8Q344cVp5EewVfJoTJMG27GBz
 P5u+8nlabbc8Al7OuGrTO8vdC7RKl4sTqQCTLMZIL0QucovmUlBgId5GalrfrMyO5h0Z
 q6zmoD679/N0xyr5EoPqjSCu/SE7k1XJncxhVIua8mqC6jAVl3Zkjq11GHfL04UdzjIb
 Yptq2omhMeuSfMqdd6MCbOKrH0F7scYhq0GJ5wFzMzZt2nZozwUpFT9tXMDzEK83meYH
 zSvtX2nkMW59VLswJNpBgY7Soia8tMsaqS/JGqoihCKdzkIFwCLu+y0XrxWJx7Qb3yB8
 dz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=epw7Ya6mrSaGCZp6nWlwRKSneX+jRfVGp7MULgc8HsY=;
 b=RcxiKyKSqVBTIq0tuBpgQmyK6Jx/trKCb0Be3I3rj6IG48eBaRGPJFZzEpFORw2Q/I
 P0bu0/s/4D3uBnVhb7CtASiKXSQ7QY5wyzoC6tLF9w0HXwgADJaxVVkLSmrHfrOUrVWL
 FgjVglUN/tExYRxewCioqxYW1O26+c/7WF/cSOSlkgHQER0L/OBriNo+8/P7vpoOolgQ
 lppCwDs/HuMaywrrGB1qmQWWnW2id06qKuts22GkEKw9iXHpAchhk+G4aleOsfrjfDWQ
 VYXAkbSp6CPGQtIMYhPhzPSMxny6dry08y8FoiRMw8T7GvVCXkciYgDohI8Yn80lugbx
 690w==
X-Gm-Message-State: AOAM530ukfs8oZmoUemCLGGcllMT99VA1ZAXHuy+WXOKF9MiC1JGrFc9
 3k8dBT8OWvZaqyE4B6q8iqI=
X-Google-Smtp-Source: ABdhPJzjM2AzaeEiDe0zng5wWHeoVzBkrH97so/vWkTc+AsXOtVJ7OsYWoNKY2Wf35P5nQBYxQHcLA==
X-Received: by 2002:a05:6000:128e:: with SMTP id
 f14mr3020663wrx.276.1593164633724; 
 Fri, 26 Jun 2020 02:43:53 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p17sm16020070wma.47.2020.06.26.02.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 02:43:52 -0700 (PDT)
Subject: Re: [PATCH v4 4/8] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
To: Markus Armbruster <armbru@redhat.com>
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-5-f4bug@amsat.org>
 <4d335933-9669-43e1-0966-5f0255142012@kaod.org>
 <34fe3d2b-6b41-0509-f172-5b45486fdf0c@amsat.org>
 <deccf836-48ef-7112-d66e-a8d3cc4a9681@kaod.org>
 <877dvv4pmg.fsf@dusky.pond.sub.org>
 <2d1b8b24-3b2c-d84e-8026-e369f6531247@amsat.org>
 <03da95ed-399d-53e2-c946-a45f1a771701@amsat.org>
 <87bll6tlzl.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <61d1f904-0d4f-4ae6-2d4e-3d8e87a9b77c@amsat.org>
Date: Fri, 26 Jun 2020 11:43:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87bll6tlzl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 7:49 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 6/25/20 10:12 AM, Philippe Mathieu-Daudé wrote:
>>> On 6/25/20 8:37 AM, Markus Armbruster wrote:
>>>> Cédric Le Goater <clg@kaod.org> writes:
>>>>
>>>>> On 6/22/20 10:31 AM, Philippe Mathieu-Daudé wrote:
>>>>>> On 6/22/20 8:27 AM, Cédric Le Goater wrote:
>>>>>>> On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
>>>>>>>> Add a description field to distinguish between multiple devices.
>>>>
>>>> Pardon my lack of imagination: how does this help you with debugging?
>>>
>>> Ah, the patch subject is indeed incorrect, this should be:
>>> "... for *tracing* purpose" (I use tracing when debugging).
>>>
>>> In the next patch, we use the 'description' property:
>>>
>>> +# pca9552.c
>>> +pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs
>>> 0-15 [%s]"
>>>
>>> So when the machine has multiple PCA9552 and guest accesses both,
>>> we can distinct which one is used. For me having "pca1" / "pca0"
>>> is easier to follow than the address of the QOM object.
>>>
>>>>
>>>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>>>
>>>>>>> Could it be a QOM attribute ? 
>>>>>>
>>>>>> What do you call a 'QOM attribute'?
>>>>>> Is it what qdev properties implement?
>>>>>> (in this case via DEFINE_PROP_STRING).
>>>>>
>>>>> I meant a default Object property, which would apply to all Objects. 
>>>>
>>>> Good point.  Many devices have multiple component objects of the same
>>>> type.
>>>>
>>>>> What you did is fine, so :
>>>>>
>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>
>>>>> but, may be, a well defined child name is enough for the purpose.
>>>>
>>>> object_get_canonical_path() returns a distinct path for each (component)
>>>> object.  The path components are the child property names.
>>>>
>>>> Properties can have descriptions: object_property_set_description().
>>>
>>> TIL object_property_set_description :>
>>>
>>> Ah, there is no equivalent object_property_get_description(),
>>> we have to use object_get_canonical_path(). Hmm, not obvious.
>>>
>>>>
>>>> Sufficient?
>>>
>>> I don't know... This seems a complex way to do something simple...
>>> This is already a QDEV. Having to use QOM API seems going
>>> backward, since we have the DEFINE_PROP_STRING() macros available
>>> in "hw/qdev-properties.h".
>>>
>>> Maybe I'm not seeing the advantages clearly. I'll try later.
>>
>> The canonical path is not very helpful in trace log...
> 
> Why?
> 
> Okay, I checked the code.  Since the devices in question don't get a
> composition tree parent assigned, realize puts them in the
> /machine/unattached orphanage.  The canonical path is something like
> "/machine/unattached/device[6]", which is less than clear.
> 
> The components of the canonical path are the names of the QOM child
> properties.  object_get_canonical_path_component() returns the last one,
> in this case "device[6]".
> 
> If we made the devices QOM children of some other device, we could name
> the child properties "pca0" and "pca1".
> object_get_canonical_path_component() would then return the strings you
> want to see.
> 
> We make a device a QOM child of some QOM parent device only if the child
> is a component device of the parent (hence the name "composition
> tree").
> 
> Are these devices integral components of something else, or are they
> separate chips?

Separate chips in the machine (actually not even on the machine mother
board where is the CPU, but on a daughter board card).

So in the composition tree I expect to see them as

  /machine/pca0
  /machine/pca1

>> The description I set matches the hardware definitions
>> and is easier to follow, see patch #6 (where it is set)
>> where the description comes from:
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg714658.html
>>
>>   Description name taken from:
>>   https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml
>>
>> So in this particular case I don't find the canonical pathname
>> practical (from an hardware debugging perspective).
> 
> Personally, I'd be content with i2c bus and address for debugging
> purposes.
> 
> The i2c buses *are* components: canonical paths look like
> "/machine/soc/i2c/aspeed.i2c.3".  The combination of
> object_get_canonical_path_component(dev) and
> object_property_get_uint(dev, "address", &error_abort) identifies any
> i2c device on this machine, not just the two you decorate with a
> description string.

The I2C busses is provided by Aspeed peripherals. I counted 19 different
I2C busses on this machine.

"pca0" is connected to i2c bus #11, "pca1" to bus #3.

I still don't think this will be practical, but I'll try your
suggestion.

Regards,

Phil.

