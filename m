Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6492CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2946720674
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/eJuP7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2946720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZzG3-0001cr-Ns
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZzBj-0004zT-6T
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZz0O-0006m9-5P
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:13:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZz0O-0006lg-1O
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574867603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Txqh/h5YxLxNYV3n7TxisN/j1GHqdmbPh3cmrTP7l/A=;
 b=C/eJuP7Lrf4lQder0Ji/+Tf0dUGVYVEpq8DGkcYWpQjjPYr+wxF8Mu78kt0tik9keG2VyJ
 yC5fCRUz6JoNqatFzucl3jlPzkB2VYAQEM38bknzfcgzrtvx5ZQ+iuH5nTpS7j3cJb/fiW
 TgvOOkhvQb81R6t6UP7JV+GZ43FfNX0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-XPjIJsTOM_q0F-7nnyYFuQ-1; Wed, 27 Nov 2019 10:13:22 -0500
Received: by mail-wm1-f70.google.com with SMTP id h191so2629634wme.5
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 07:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v6lZiE6563IauRAooCWyqSFoYEOr4nbq06GZhpIifA0=;
 b=GtkUoBCHAFape6BILXzbE4SQmw2MtbKuEjTIQJ3W62SAg7BurltDOMFFg3Y4FMVe3U
 kNQn/jjO2P6LA+exRJc4ABSxzs0q/SrRaqPfZl6d+q8GSIDgm+BItmR9hjb0rbZ7ClhA
 mt1Dq/YItxbKluU4Xu2iWFpeU9N+ujPI22NE69dq4C04liBoaEGJsMQufrAO4vFd3cGS
 CpR3BJlE10dsczOA7E/5LAQgG2ENVEDTLy432AAQ812Fmvj4eol1J+RiO6ILhfmcEUio
 zJmaW64rBxOQooH1gjdHam4iv48FO/EF8fAtWqTRt8xhp1mz3pr/ivdzRxku5M7Kd7YW
 u4zg==
X-Gm-Message-State: APjAAAUGI/BlLANFDCRQ/uFU3jjRntx2Q9A7oty3pHBDhNxAeK6CfR8f
 fdplB73h/2lCDh/GIsx8XURuyk+zyHm/OPyqMIzmYMj3BBpHkp9LueCJDIqFqmXcueRf/Yr2miW
 p4jzJpg7zdc2FpFY=
X-Received: by 2002:a05:600c:2549:: with SMTP id
 e9mr4670722wma.177.1574867600828; 
 Wed, 27 Nov 2019 07:13:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZFaGsj6zuSNNeRMcmk3khCnZInL01Hp+EJm6XWjZefEwAsSUaX5JYayOVVoWShD7xdL+Q7w==
X-Received: by 2002:a05:600c:2549:: with SMTP id
 e9mr4670697wma.177.1574867600614; 
 Wed, 27 Nov 2019 07:13:20 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id b17sm19855743wrp.49.2019.11.27.07.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 07:13:20 -0800 (PST)
Subject: Re: [RFC 00/10] R300 QEMU device V2
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126141924.GQ556568@redhat.com>
 <09273ecd-be76-ab61-304f-7ea0f1f0b107@redhat.com>
 <20191127150520.GG2131806@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <19e8e458-04dc-874d-d372-04a0e2d5246b@redhat.com>
Date: Wed, 27 Nov 2019 16:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191127150520.GG2131806@redhat.com>
Content-Language: en-US
X-MC-Unique: XPjIJsTOM_q0F-7nnyYFuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing more.

On 11/27/19 4:05 PM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Nov 27, 2019 at 04:00:01PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Hi Daniel, Aaron.
>>
>> On 11/26/19 3:19 PM, Daniel P. Berrang=C3=A9 wrote:
>>> On Tue, Nov 26, 2019 at 06:14:27PM +0530, aaron.zakhrov@gmail.com wrote=
:
>>>> From: Aaron Dominick <aaron.zakhrov@gmail.com>
>>>>
>>>> I have removed the botched patches and have got the code working upto =
the GART initialization.
>>>> I am not sure how to implement the GART. I am guessing it should be an=
 IOMMU device but I think that is a bit much for an emulated card.
>>>> The earlier problem of display probing seems to be resolved by using a=
n R300 bios I got from TechPowerUP's GPU database:
>>>>
>>>> =09https://www.techpowerup.com/vgabios/14509/14509
>>>> I am NOT sure if we can distribute it in the QEMU source tree. If it
>>>> does cause problems I can send a patch to remove it.
>>>
>>> That site seems to be a repository of BIOS uploaded by arbitrary users,
>>> with no information on what license terms might apply to the uploads.
>>>
>>> We have to therefore assume the worst and treat the BIOS images on that
>>> site as proprietary and not re-distributable, despite the fact that the
>>> site itself is acting as a 3rd party distributor.
>>
>> We can not redistribute this BIOS.
>>
>>> IOW, we can't have this in QEMU git I'm afraid, unless someone can find
>>> a trustworthy vendor source for the original image with accompanying
>>> license information.
>>
>> Daniel, I think there is no problem if Aaron contributes a model of the =
R300
>> device to QEMU, right? This doesn't involve redistributing any BIOS.
>=20
> Having just the device impl doesn't cause any legal problems.
>=20
> It does become a slight usability issue, as any users need to go and find
> the suitable BIOS in order to use the device. No downstream OS vendors ar=
e
> going to be able to distribute this BIOS either
>=20
> I don't know if we have hit this problem before & if we have any
> general policies about it ?

This appears to me the same case as a user downloading a proprietary=20
driver/firmware at some vendor website, accepting the EULA, then using=20
the driver within a QEMU VM.

No close source blob are redistributed, but users can still run them,=20
and both party (the QEMU project, and the users) are legally correct,=20
right? But IANAL.


