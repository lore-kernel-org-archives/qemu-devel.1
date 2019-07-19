Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8531C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE23420873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE23420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoQ16-0003l9-VQ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 06:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoQ0u-0003F2-L9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoQ0t-0000Oy-L5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:21:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoQ0t-0000O8-Ft
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:21:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so28504089wmg.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 03:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RILE1iZpMYXfF8OwS6dKminfjIGlAG6jhJeAundloEM=;
 b=pcjGIQz9NVXks7Zvud70FgP2ukX/CpSYwOyl/4rebOWQFwHxKTvuhMK8KZATlRQMtA
 PpjTIBlLIm6ZGzhUTMr8/h7g4F9naWb2hAyz/vtYrfx0h01zDFf24vSnVUVwYFYepp5i
 FutBSbPhR29x+e2Qh1WYPFQZlmkafEwVHUgglQ/xStbss8dWOKYJT4si9zpjjURiXFSq
 gH8btH5ww9q7nMNc+gpm7YjRvLdAqgT5zEd2bZUrQ6bzN2rSWzQW6lZXyS9E8SQFjaMi
 Ts9fterKHNPPwXES2hfsfIYOBi7xBKpDzHYnuXjPrqH0rwjij9ofBUr+YqzLgP4zbhlV
 8cxA==
X-Gm-Message-State: APjAAAXdA5yPTYJbap3D6HMGXBZgFgg0P4yRjXBsBnV+M0MOY2iPSy38
 EFgTUigwL1Ow/qNiqW7gYXdmBQ==
X-Google-Smtp-Source: APXvYqw+LEsLriVeCMSW4dh3XgT/gokUV0pAoIyjS923gO8qn4nZpvIyoByaVNq8pfgLG/+yhirfog==
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr48978539wma.41.1563531677915; 
 Fri, 19 Jul 2019 03:21:17 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id c1sm59315666wrh.1.2019.07.19.03.21.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 03:21:17 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190718193441.12490-1-sw@weilnetz.de>
 <6241fd95-789f-f560-2170-0544cded1720@redhat.com>
 <CAL1e-=h01=ouAuTiPK7mGqCJVX4C-WQUEVZngFBG5nthDQ936g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <da7e8484-246b-45e6-3790-7d3e8407bf37@redhat.com>
Date: Fri, 19 Jul 2019 12:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h01=ouAuTiPK7mGqCJVX4C-WQUEVZngFBG5nthDQ936g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] audio: Add missing fall through comments
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/19/19 9:43 AM, Aleksandar Markovic wrote:
> 
> On Jul 19, 2019 9:30 AM, "Philippe Mathieu-Daudé" <philmd@redhat.com
> <mailto:philmd@redhat.com>> wrote:
>>
>> On 7/18/19 9:34 PM, Stefan Weil wrote:
>> > Signed-off-by: Stefan Weil <sw@weilnetz.de <mailto:sw@weilnetz.de>>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
> <mailto:philmd@redhat.com>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com
> <mailto:philmd@redhat.com>>
>>
> 
> Philippe, how do you test these comments?

The testing is quite easy since it doesn't build with
'-Wimplicit-fallthrough=2':

  CC      audio/audio.o
/home/phil/source/qemu/audio/audio.c: In function ‘audio_pcm_init_info’:
/home/phil/source/qemu/audio/audio.c:308:14: error: this statement may
fall through [-Werror=implicit-fallthrough=]
  308 |         sign = 1;
      |         ~~~~~^~~
/home/phil/source/qemu/audio/audio.c:309:5: note: here
  309 |     case AUDIO_FORMAT_U16:
      |     ^~~~
/home/phil/source/qemu/audio/audio.c:315:14: error: this statement may
fall through [-Werror=implicit-fallthrough=]
  315 |         sign = 1;
      |         ~~~~~^~~
/home/phil/source/qemu/audio/audio.c:316:5: note: here
  316 |     case AUDIO_FORMAT_U32:
      |     ^~~~
cc1: all warnings being treated as errors

With Stefan patch applied:

  CC      audio/audio.o
  CC      audio/audio_legacy.o
  CC      audio/noaudio.o
  CC      audio/wavaudio.o
  CC      audio/mixeng.o
  CC      audio/spiceaudio.o
  CC      audio/wavcapture.o
[...]

> 
> Yours, Aleksandar
> 
>> > ---
>> >  audio/audio.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/audio/audio.c b/audio/audio.c
>> > index 5fd9a58a80..a7a13e900a 100644
>> > --- a/audio/audio.c
>> > +++ b/audio/audio.c
>> > @@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info
> *info, struct audsettings *as)
>> > 
>> >      case AUDIO_FORMAT_S16:
>> >          sign = 1;
>> > +        /* fall through */
>> >      case AUDIO_FORMAT_U16:
>> >          bits = 16;
>> >          shift = 1;
>> > @@ -311,6 +312,7 @@ void audio_pcm_init_info (struct audio_pcm_info
> *info, struct audsettings *as)
>> > 
>> >      case AUDIO_FORMAT_S32:
>> >          sign = 1;
>> > +        /* fall through */
>> >      case AUDIO_FORMAT_U32:
>> >          bits = 32;
>> >          shift = 2;
>> >
>>
> 

