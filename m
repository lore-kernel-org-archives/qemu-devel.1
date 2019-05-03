Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1BAC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D040820651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D040820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMb4d-0002j4-1J
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:30:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMay1-0005bn-LU
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMaxy-0007RK-Ta
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMaxy-0007Pr-DW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id b10so7799647wmj.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=M8WgKMHGzcbGODR9dlVFSGXZfHqiB8f0FlklaO2r7VE=;
	b=LHJwUWWXJyHcWkWTDWOvl8byJLjjepE1IKCbGDArvKNTZWhNO0ABDKTERnRvPygU8a
	XqX9dUYTkvkLd4VGHnyQu2FtSZKqH+JYKo8TX3BCuN9vh6aPN/V6QIUBH+yXs0WqA2FS
	vUygzzmIimKw44oPRLyex90tAyQzCHN9GuiYv9KFBlyptriqIt4c4f4Ha1LHLnYAj5ye
	OrlHjC2wUN7pOHuk0eUC7Lt7QN6lR1a4GfuWMqgqsl6aeKa03DU0gjxcxYTSwb1lhZ44
	FrMllVilkd9bnAutd4y8u4pIQDJF3MVItM8el83VIskJjpc6dAkf340rHVEj+gfNiGfz
	7WhA==
X-Gm-Message-State: APjAAAVlUb9xhH/KRFq1NLdJrlCasuTgfWOJI7AxuvQgZ7bvypxgXVWb
	VycJIEzGfWhMjwwDPWnW+DZnTw==
X-Google-Smtp-Source: APXvYqz8vBxL/1QRATJFWVv+CkMOrPGhOudx04VsCjyj54tgb6MYR8JkYlqOlzd2l3Nygiw42SL5ig==
X-Received: by 2002:a1c:e085:: with SMTP id x127mr7336885wmg.140.1556900597449;
	Fri, 03 May 2019 09:23:17 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a184sm1934471wmh.36.2019.05.03.09.23.16
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 09:23:16 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003618.10089-1-driver1998@foxmail.com>
	<aa0dce0b-1be0-7247-8f81-c4f265ba0009@redhat.com>
	<CAFEAcA9a8oQHe+cbSotO+BR2-iqgKOBV5Pg4n1aOBY7_tnvqFg@mail.gmail.com>
	<CAJ+F1CL+2YGHMZteU74y9a61rW6fXLDxcb4KGzPBEAL6878Ujg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a6456256-cda6-0604-6602-2102d47ac006@redhat.com>
Date: Fri, 3 May 2019 18:23:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL+2YGHMZteU74y9a61rW6fXLDxcb4KGzPBEAL6878Ujg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 1/4] QEMU_PACKED: Remove gcc_struct
 attribute in Windows non x86 targets
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
Cc: Thomas Huth <thuth@redhat.com>, qemu trival <qemu-trivial@nongnu.org>,
	Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>,
	Cao Jiaxi <driver1998@foxmail.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503162315.dxhlTzE6N4YsLstBE9uLmPasRM_jMzm6VPd0qolBgLs@z>

On 5/3/19 5:56 PM, Marc-André Lureau wrote:
> Hi
> 
> Le ven. 3 mai 2019 à 17:23, Peter Maydell <peter.maydell@linaro.org> a
> écrit :
> 
>> On Fri, 3 May 2019 at 06:07, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 03/05/2019 02.36, Cao Jiaxi wrote:
>>>> gcc_struct is for x86 only, and it generates an warning on ARM64
>> Clang/MinGW targets.
>>>>
>>>> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
>>>> ---
>>>>  contrib/libvhost-user/libvhost-user.h | 2 +-
>>>>  include/qemu/compiler.h               | 2 +-
>>>>  scripts/cocci-macro-file.h            | 7 ++++++-
>>>>  slirp/src/util.h                      | 2 +-
>>>>  4 files changed, 9 insertions(+), 4 deletions(-)
>>
>>>> diff --git a/slirp/src/util.h b/slirp/src/util.h
>>>> index 01f1e0e068..278828fe3f 100644
>>>> --- a/slirp/src/util.h
>>>> +++ b/slirp/src/util.h
>>>> @@ -43,7 +43,7 @@
>>>>  #include <netinet/in.h>
>>>>  #endif
>>>>
>>>> -#if defined(_WIN32)
>>>> +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>>>>  # define SLIRP_PACKED __attribute__((gcc_struct, packed))
>>>>  #else
>>>>  # define SLIRP_PACKED __attribute__((packed))
>>>>
>>>
>>> The slirp code is currently on its way into a separate module, so you
>>> might need to provide that hunk to the libslirp folks again... I'm
>>> putting the slirp maintainers on CC:, maybe they can pick it up from
>> here.
>>
>> Yes, the slirp module has now landed in master, so this patch
>> definitely needs to be split into two. I've kept in my
>> target-arm.next tree the parts which are applicable to
>> the QEMU repo itself (ie everything except the slirp/ change),
>> so we just need a new patch for the slirp submodule part.
>>
>> Marc-André, Samuel -- what's the process for submitting and
>> getting reviewed changes to the slirp submodule now it's a
>> separate project ?
>>
> 
> It's hosted on gitlab.freedesktop.org, with some CI. It's fine to send
> patches on qemu devel, as long as Samuel or I are in CC. But in the long
> term, I think gitlab MR will be favoured (after a while using it, I think
> gitlab is better than ML for patches & bug tracking tbh)

Except when working offline (or with poor intermittent link).

