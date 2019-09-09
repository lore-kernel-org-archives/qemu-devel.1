Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB35C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 23:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B107C21670
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 23:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUUj8b6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B107C21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7TJa-0004c2-U7
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 19:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7TIm-00041m-Tb
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 19:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7TIl-0001Ie-CV
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 19:42:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i7TIl-0001H7-5u
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 19:42:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id u16so16470960wrr.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 16:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i8cs48C2GMSAyX2IG3HmIJZxu86gStrMallWCVtcqRs=;
 b=gUUj8b6xATlck4dGloSC+F6O6JWPmqyGjP7q5qIkcC6sTA1nPkPTZ/enEP39MtPzKS
 SZFrSHdOmd23G0D5df6nEpiOA1L1eI8OEgG69JrWs6c9Z39nAJojCM/YXZPdlnTa8mcG
 0ASH7cYLw8mhr9TnCd6ink/UxYDr+XXQgs3ChudjEvzyuj1mtjLZIK+4dfDWyb5LNPGN
 wswy5gWjIwh/ZLAz5gQbYEWMhIatxOj7v0vsbPXk9NKHq3RYefIg2IwH+OjA7HYNqeTm
 6ahuFatMoxPNb8Ma52P3qFcHSPDzGF+TG5j1ATnPJfQ56I71g0ObuONKD3I6xNzrGCIS
 EQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i8cs48C2GMSAyX2IG3HmIJZxu86gStrMallWCVtcqRs=;
 b=sYlFZrW1eBxisFvtKVk2wiU/YVPkyNLPPHCca/jdr9t4+SWpxnj0IFHx/nKNiYOnwr
 xvDB2t5glZlhK8vPIYe3UuUtv846sbaV+YparFtakYnOMQA9k9xaSFV9yy+IF2acACi9
 3nA/yMwbMEnnzXDD/iMGOMwTja45rLamyOwFpev3m/TJ15q2KwE/wycJmuCKdQ/jJLoj
 Wm/KQ/OLyepxuU5ZtIAJpmzZ8KVepMljd1Dzkmd6ajQJZEtUyaOyVn3kekmptRdcOd4y
 5uhN9UJH2dHKb/5ILCrcJ7hZSX78Y39ci7A02PDFjwtGNtg/zJkrB5MY6YYwqTLx70EE
 OlHg==
X-Gm-Message-State: APjAAAVu5J+UrcquFstgLbyYxcLHsAqcIEPJ2hdGM+JPlW9EpBHyKsLf
 tB4ovE/XRqdVdj1Dcx5Guc53I7T0
X-Google-Smtp-Source: APXvYqzy2uiWw2jdRYUqY4hgMZTJDssz7klsiMSywlUIleBwjjcMbzmU1AviJjZSlZNphQSndQEjfA==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr22867661wrp.281.1568072549235; 
 Mon, 09 Sep 2019 16:42:29 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::d3?
 (2a01-036c-0113-6ea8-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:6ea8:1::d3])
 by smtp.gmail.com with ESMTPSA id s1sm23574588wrg.80.2019.09.09.16.42.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Sep 2019 16:42:28 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
 <43076a2afeb0439b607b0631e0bfff77d55bc0cc.1566847960.git.DirtY.iCE.hu@gmail.com>
 <20190827054223.nuiz7fz27tld3hpt@sirius.home.kraxel.org>
 <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
 <20190828095308.GE2991@redhat.com>
 <6a1f7b1dc372abfbbf8efaa7d0ce9c7db1881849.camel@redhat.com>
 <20190828102603.GG2991@redhat.com>
 <ae12796c51767489970f1040d3d86230f01ec79d.camel@redhat.com>
Message-ID: <5e06cdb9-3215-361f-9a12-9b0f9024dda9@gmail.com>
Date: Tue, 10 Sep 2019 01:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ae12796c51767489970f1040d3d86230f01ec79d.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 4/4] audio: paaudio: ability to specify
 stream name
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-08-28 12:39, Maxim Levitsky wrote:
> On Wed, 2019-08-28 at 11:26 +0100, Daniel P. Berrangé wrote:
>> On Wed, Aug 28, 2019 at 01:14:03PM +0300, Maxim Levitsky wrote:
>>> On Wed, 2019-08-28 at 10:53 +0100, Daniel P. Berrangé wrote:
>>>> On Wed, Aug 28, 2019 at 12:43:49AM +0200, Zoltán Kővágó wrote:
>>>>> On 2019-08-27 07:42, Gerd Hoffmann wrote:
>>>>>> On Mon, Aug 26, 2019 at 09:59:04PM +0200, Kővágó, Zoltán wrote:
>>>>>>> This can be used to identify stream in tools like pavucontrol when one
>>>>>>> creates multiple -audiodevs or runs multiple qemu instances.
>>>>>>
>>>>>> Hmm, can we create an useful name automatically, without yet another
>>>>>> config option?
>>>>>>
>>>>>> Useful choices could be the device name (usb-audio, ...) or the device
>>>>>> id (whatever -device id=xxx was specified on the command line).
>>>>>
>>>>> I'm afraid this is not going to work with the current architecture: due
>>>>> to mixeng even if you have multiple devices, they'll be mixed to a
>>>>> single stream and the audio backend will only see this one mixed stream.
>>>>>   As a workaround we could do something like concat all device names or
>>>>> ids, but I don't like that idea.
>>>>>
>>>>> Alternatively we could use the id of the audiodev instead, and no more
>>>>> problems with mixeng.  However, with mixeng off (implemented in my next
>>>>> patch series) suddenly soundcards will have suddenly end up as different
>>>>> streams.  (This can be worked around by creating multiple audiodevs,
>>>>> like what you have to use now to get multiple streams from pa, so this
>>>>> is probably a smaller problem.)
>>>>>
>>>>> Currently I'm leaning for the audiodev's id option, unless someone
>>>>> proposes something better.
>>>>
>>>> Using the audiodev id is not a good idea. If you have multiple QEMU's
>>>> on your host, it is highly likely that libvirt will have assigned
>>>> the same audiodev id to all of them.  Using the vm name would be ok,
>>>> but only if you assume that each gust only has a single audio device.
>>>>
>>>> Using a combination of vm name + audidev id is going to be unique
>>>> per host, but not especially friendly as a user visible name. It
>>>> would be ok as a default, but I'd think we should let the mgmt app
>>>> specify stream name explicitly, so that something user friendly
>>>> can be set.
>>>
>>> No, no!
>>> It seems that pulseaudio has a name for each connection, and a name for each
>>> steam within that connection.
>>>
>>> The suggestion is that we use the VM name for the connection,
>>> (which will be unique per VM usually, at least the user can make it be so)
>>> and then use the audiodev id for each stream. Of course for multiple VMs,
>>> the audiodev ids will be the same, but this is all right since you can
>>> always distinguish them that the streams come from different VMs.
>>
>> Ok, if I'm reading the code correctly, it seems we do take care to
>> re-use a single connection to PA for all audiodevs we create. So a
>> VMname is fine for the connection.
>>
>>> Also note that this thing is cosmetic from the correctness point of view,
>>> that is pulse-audio internally has no problem with duplicate IDs.
>>>
>>> The thing is useful mostly for tweaking the output streams in the pavucontrol,
>>> where the names will allow you to easily know which steam is which.
>>
>> Yep, I wasn't really concerned about internals - from the user POV being
>> able to accurately distinguish streams in pavucontrol is very important
>> though, so we should ensure that's possible. If we use 'id'  for the
>> stream as a default though, we should still allow an override, as 'id'
>> values are not really intended as end user visible data. If a guest
>> has multiple devices I'd expect to be able to give them names that are
>> meaningful to me as a user, not something libvirt auto-generates for
>> its own machine oriented use.
> 
> I have absolutely nothing against user specified override!
> Just that if the idea is shot down, lets at least have device id instead.
> 
> 
> For the reference this is how currently the sound streams are shown,
> without any patches applied
> https://imgur.com/a/I8HZhgx
> 
> Gnome sound panel only shows application names,
> but pavucontrol shows both the application name and stream name.
> 
> Best regards,
> 	Maxim Levitsky
> 

Ping.

If I understand the situation correctly, the current consensus is:

* use VM name for PA server connection
* audiodev id is a good default for PA stream name

What is not clear whether we need a separate qapi option for stream 
name, or just always use the audiodev id.  I don't use pulseaudio or 
libvirt, so I can't really comment about this issue.

Ideally I'd like to create a new patch with this change and a fix for 
the coverity issue reported in [1].

Regards,
Zoltan

[1]: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01543.html

