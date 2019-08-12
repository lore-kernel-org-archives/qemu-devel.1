Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2B9C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743F4214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743F4214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx9WI-0005IY-Lj
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 08:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43037)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hx9VU-0004rb-Sw
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hx9VT-0000oQ-OM
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:33:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hx9VT-0000nx-IK
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:32:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so5311457wrl.7
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 05:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p8PxqbzG3e7C9Em19vRh/KyV6CjJIfxp9nJ/JsPCgro=;
 b=X0g1sxPstD2BUJcBtncBz8M6sqUuP7OBid/nXBW7H9lsFo+5fzQg6OCxRovRlR6I1i
 aJN4u9/CLszqEnBp5d1EbbfELTrno8bE2KEzN7P8yY/aOzmttsd4J2FLUpGbQtvjnhVN
 hD5T4i/qn2flz4ZgyZZ/Zb+KX8pS+SS8DAzow+XsSis3iut0kyQU7FZjl/b4T4dBN9/9
 v1xSU4mo567ptbnNW7utU6YZmSOahC4v60T3b71ELl6h9CAgk0aNPctUabLm62oR6V/t
 zGLttRJQFvsTtzYcZk/m/I8XFuTMRKN/P5Y0rDo2E9W2/gPP8Qp/8yk5lGZOFo84sFqk
 UkjA==
X-Gm-Message-State: APjAAAVxULV1Mm3a9iloss6PCVup5mEsR/alciGa5fQhScAJKAHEJadQ
 kUxthEQwvRqc+owfY9byEYD+ig==
X-Google-Smtp-Source: APXvYqyGMaPYmCL3h5dIF4tPjovM5TY0QIMPfY/Uh1DbPMM3kPpqmruRCNHahiWlYFpuKYY72AoiaA==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr26749922wru.74.1565613178344; 
 Mon, 12 Aug 2019 05:32:58 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id i66sm29795771wmi.11.2019.08.12.05.32.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 05:32:57 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <695325d7-a0c3-73c1-97ab-f62fb345c622@unipi.it>
 <87blwzho1y.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2fb98b77-efab-6092-dd5a-fa50c3c4b3f9@redhat.com>
Date: Mon, 12 Aug 2019 14:32:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87blwzho1y.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping?
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
 "Daniel P. Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 1:52 PM, Markus Armbruster wrote:
> Giuseppe Lettieri <giuseppe.lettieri@unipi.it> writes:
> 
>> Dear Markus,
>>
>> the netmap project is alive and well, if a bit understuffed. We have
>> moved to github:
>>
>> https://github.com/luigirizzo/netmap
>>
>> We have users from FreeBSD, where it is part of the official kernel,
>> and Linux, both from Academia and industry.
>>
>> But you asked about the netmap backend in QEMU, in particular. When it
>> was merged, the decision was made to disable it by default because it
>> was not supported upstream in Linux. As Jason Wang says, this support
>> is even more unlikely now than it was then.
>>
>> The fact the the backend has to be explicitly enabled and built from
>> the sources has obviously cut down the number of potential
>> users. However, we still think it is useful and we have pending
>> updates for it. If it's causing problems in the workflow, I am willing
>> to help as much as I can.
> 
> Could we make it a submodule, simililar to slirp and capstone?

Good idea, this would extend the coverage. Netmap users/developers are
probably best suited to do this.

> 
>     --enable-netmap=system      use the system's netmap
>     --enable-netmap=git         use the git submodule
>     --enable-netmap             use system's, else git, else fail
>     --disable-netmap            disable netmap
>     default                     use system's, else git, else disable
> 
> A fresh clone of https://github.com/luigirizzo/netmap clocks in at
> 14MiB, which is between libslirp's 1.5MiB and capstone's 72MiB.

In which directory should we clone it? As /netmap directly?

Should we start using a 3rd-party/ subdirectory?

Similarly, what about the virglrenderer component?

Its repository is: https://anongit.freedesktop.org/git/virglrenderer.git

