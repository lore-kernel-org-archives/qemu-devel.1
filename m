Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D498C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C1B2166E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C1B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVetw-0004ia-HL
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 12:24:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVet3-0004ON-Hs
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVet2-0005MF-Hg
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:23:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVet2-0005LV-BQ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:23:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so3657068wme.0
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 09:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=P29XF5SjOXl4FiDCcWCoxHHguQrOzLvIJFTuy5Q566U=;
	b=V9INyxUJhWZXek0+lm1+ke5WPeMBZRKRUVlVeWqQ2KyCC9yEaCkkQ0VNR1eBxOWOGy
	r/lH5pHmZfQJj/M8RkcWsWyq1Lgg0gl0729iAf2ynE4XAVt0QQLKxInktxuEmgXeaEbm
	GIXd8viY9SQ7LUOhGbuP5tV/WuRkHjBh035LHWYcLbOuyQurpmsa9SEhPAFxs7m0ZTpL
	nKjuWwT/r4cuAZr0TYnUMQ638cnY0JvSKIxTQRVDDbWOD+icfv4Qyph1draDHljjBZLG
	faJuP8PuOjsWHLZxhKLrSy4XH1pFrdobYn4jKTZ6Yyx3JMGK4Afwt0MWyTwk3EvqTYlH
	XifA==
X-Gm-Message-State: APjAAAWnCe3kT8IWIMi4q1uaTZ/nVjae9PGirl3CeiapJKyC5narpE3b
	e2q3z5UXNGkhc23yFBMu0uUzzQ==
X-Google-Smtp-Source: APXvYqy5oymBc+QBRNGiKpj2uyigbp4e3d6rE6z4wWLqv0sfGTTwFWMK/SqCPQDElnsrxw8lMvVKzg==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr3939536wma.93.1559060619195;
	Tue, 28 May 2019 09:23:39 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	g185sm2274528wmf.30.2019.05.28.09.23.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 09:23:38 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190528153304.27157-1-philmd@redhat.com>
	<eb44b164-aabe-d072-b2a8-392bdb37dc7e@redhat.com>
	<20190528120741-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a759c163-b732-6c3c-eda6-a15aeae246f3@redhat.com>
Date: Tue, 28 May 2019 18:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528120741-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2] tests/docker: Update the Fedora image
 to Fedora 30
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/19 6:08 PM, Michael S. Tsirkin wrote:
> On Tue, May 28, 2019 at 05:36:54PM +0200, Philippe Mathieu-Daudé wrote:
>> Cc'ing Michael/Igor/Stefan about git comment format.
>>
>> On 5/28/19 5:33 PM, Philippe Mathieu-Daudé wrote:
>>> Fedora 30 got released:
>>>
>>>   https://fedoramagazine.org/announcing-fedora-30/
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>> v2: Added Marc-André and Stefano tags
>>
>> ^ This is my local commit
>>
>>> ---
>>
>> ^ This line was added by git publish via format-patch
>>
>> Michael is that what break your patch workflow?
> 
> 
> Used to but seems to work fine now.
> So I guess you can ignore me sorry about the noise.

Good to know :)

Thanks,

Phil.

