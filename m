Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231FDC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E422080C
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 18:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo+k0Eli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E422080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1wu0-0000Os-4k
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 14:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1wt1-0008DQ-Qo
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1wt0-00008U-PX
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:05:07 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1wt0-000083-JQ
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:05:06 -0400
Received: by mail-qk1-x743.google.com with SMTP id s145so12384239qke.7
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tDyhTTuBsg53vKE3kmibA3LjJ66riONy6Tj7Z4yO/+s=;
 b=jo+k0Eli969wOZz4tNYu+OaT0pJbBYuwt6GmFk6kdviHulCoPqLy3WK1XdLcGsF0x8
 eDupUS7XqI4nKP/ZYjXc8BEk6Do44oKcmh4ZVCU5k874eNQ0rzmv1i09AR3kot0EB6p4
 Ke/+UIFfW68IM6guMvU4b+dswLSvjpZVmHKYbnFDHeY8BoThrTVkRve5tmuh0S4PmMBX
 PciW1dxl/aQ6ebrhLEKqV124TYdGrjCESk2NPrEgQADCxB8shuQGOUckFhJJl6DG6xjU
 LXjtyJmGeaBBEppzBfPmaLYatCh65mL8Oq5NF1A0rLA2FveBWvyxtp19/0ze1eZzv8iP
 whQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tDyhTTuBsg53vKE3kmibA3LjJ66riONy6Tj7Z4yO/+s=;
 b=FnQmkpYMX1uIXQHEWviG2XsThhNskD4UNqV5rDjcFbq7mDEx5fAY2ybpBZCfHY8lUp
 aS5nvV9APriSC6NcV3I4u4XE3EoAxYDQRThhC2PTvyfvIVD1LD+ZSOt8l/9HKpvCsuEf
 erQdQWj8g4g+6+ksi9hsG6tatu9CSs+gsu5lgdPbkD/S+h08hXwL5xhdn976yyuT23Ye
 AjifK6YBNGYr9olp/2hb7G85hFtOdepv6lxy+rDehm8MXVEzkOXy1v8N8HBZFK7eygEk
 3lkvuxKWK4oTqEeF++9mgq6rSuc8q8a7ZmOfmP3o0zaYoBiwY1nnha0ZOC0zoZPS2QLm
 SfQg==
X-Gm-Message-State: APjAAAVbI/euLAv9YlhFDiAUGCOdRZz9szi9/dpXWtm6CQUwwxMEQ58B
 tueeJg793NazCPC4U626sMU=
X-Google-Smtp-Source: APXvYqwWmiuYSJElL7Zm7wNv9BuI4ZtcVjBZDkOlu4CJL+6d+ZinY3jYX3t5mMcoVw27NzC1nUWKgw==
X-Received: by 2002:a37:649:: with SMTP id 70mr13198521qkg.208.1566756305728; 
 Sun, 25 Aug 2019 11:05:05 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc::5?
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.googlemail.com with ESMTPSA id a67sm5483364qkb.15.2019.08.25.11.05.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:05:05 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20190821084113.1840-1-kraxel@redhat.com>
 <20190821084113.1840-8-kraxel@redhat.com>
 <01aadba9669734bfde832a01bb62f7746a57f905.camel@redhat.com>
Message-ID: <cc1b515e-de9b-8bb0-d1e1-94f038420853@gmail.com>
Date: Sun, 25 Aug 2019 20:05:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <01aadba9669734bfde832a01bb62f7746a57f905.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PULL 07/15] audio: audiodev= parameters no longer
 optional when -audiodev present
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
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Walle <michael@walle.cc>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-08-25 11:44, Maxim Levitsky wrote:
> On Wed, 2019-08-21 at 10:41 +0200, Gerd Hoffmann wrote:
>> From: Kővágó, Zoltán <dirty.ice.hu@gmail.com>
>>
>> This means you should probably stop using -soundhw (as it doesn't allow
>> you to specify any options) and add the device manually with -device.
>> The exception is pcspk, it's currently not possible to manually add it.
>> To use it with audiodev, use something like this:
>>
>>     -audiodev id=foo,... -global isa-pcspk.audiodev=foo -soundhw pcspk
> 
> Hi!

Hi,

> There is one corner case this breaks.
> In qemu 4.1.0, there is no way to specify audiodev for a sound device, specifying it
> fails with error.
> So some of my machines have audiodev (which is miles better that using old env variables)
> but also have sound devices without audiodev reference since this wasn't supported.
> 
> 
> In what will be qemu 4.2, you must specify it, thus this kind of breaks backward compatibility.
> Maybe we can have audiodev reference optional for a version or two?
> 
> This is just a minor itch, as otherwise the sound improvements are really good. The days
> of installing that old realtek driver are finally gone :-)

Hmm, this is what happens when you split a patch series.  We could
either revert this patch, or alternatively turn the error messages into
warnings about using deprecated behavior.

> Another thing I noted, that there is no way for pulseaudio audiodev to specify the 'client name',
> it always shows up in pavucontrl as the socket path to the server. 
> Thus if I added two PA audiodevs, I can't really distinguish between them.
> The in|out.name= seems to specify the pulseaudio source/sink to connect to, which is not the same.

We currently supply the constant "qemu" as a name to pa_stream_new.
While it's still not ideal, shouldn't this end up as a client name in
pulseaudio instead of a socket path?

Regards,
Zoltan

