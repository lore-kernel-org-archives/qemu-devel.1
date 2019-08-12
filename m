Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E3EC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1248820679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1248820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxB76-0005wA-Dg
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 10:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxB6M-000513-Uq
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxB6L-0001FP-RW
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:15:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxB6L-0001FD-La
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:15:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so11933684wmg.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 07:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pE2oNFD9NGYk/wAS51pwHviOScOTo0UPbsSqtFjpICE=;
 b=LGvsQX35WqI/VyLO4kaA+GFhX0SZq28DYFF6uM8A0m1rI0E+DgE1B7R2ZNwK2ylW/L
 Ji8SSu+Ponu745QuA7YdD/ygjHcW49C//Qh+AQIzYWntbMXB8gTl4373bLww86rN8B4t
 dHJoKEiDxcksrR/cd3K8lIz52P51cqZ6/TyH8vL1K9XZMjziDRNqQFnSgmX/3CnK9jQQ
 Nsj2YC8nhog1tHxxLCBAUOQbKJ3lGXkRE7aYx8ORl/XpyY6ks6qwrJAURQ83VltotxI3
 KmaanuUoRsLinmzQ6Q8EUTuJVzUnNMmzkQtgrX4AWRm8gsaAOLJQjPhETa8fryBFpiKF
 JBLQ==
X-Gm-Message-State: APjAAAWiiRMUz4ZHSXNt/NXIE39RP5A9Ke1oyk53tc9rJLFa62f83iVx
 llZzspvE32A/lMGYhLGnUzZIUHfApYo=
X-Google-Smtp-Source: APXvYqy3Rc3ZahKQLR+qykLK4qvh/9T3eeUKVabEzMgvzOOLDpXHlj3B+75ZsxFenVtU3JYVvfzDaQ==
X-Received: by 2002:a05:600c:2486:: with SMTP id
 6mr29592591wms.80.1565619308444; 
 Mon, 12 Aug 2019 07:15:08 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id v3sm8494006wrq.34.2019.08.12.07.15.07
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 07:15:07 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190812065221.20907-1-kraxel@redhat.com>
 <aec51679-b766-5773-86cb-9ebd06a8cb49@redhat.com>
 <c4b30dfe-83d7-f1e0-d868-82791d56d6b6@redhat.com>
 <CAFEAcA-3bFuy2DDG8=-_Y3JO4HWpCW80EcsGWWN8toxiMpafBA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bdd475d0-c6be-027d-759a-a1e330cc3190@redhat.com>
Date: Mon, 12 Aug 2019 16:15:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-3bFuy2DDG8=-_Y3JO4HWpCW80EcsGWWN8toxiMpafBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 0/1] display/bochs: fix pcie support (qemu
 security issue)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/19 3:39 PM, Peter Maydell wrote:
> On Mon, 12 Aug 2019 at 13:51, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> On 8/12/19 2:45 PM, Paolo Bonzini wrote:
>>> On 12/08/19 08:52, Gerd Hoffmann wrote:
>>>> Just found while investigating
>>>>   https://bugzilla.redhat.com/show_bug.cgi?id=1707118
>>>>
>>>> Found PCIe extended config space filled with random crap due to
>>>> allocation being too small (conventional pci config space only).
>>>>
>>
>> Can you amend this information to the commit description?
>>
>> <...
>>
>>>> PCI(e) config space is guest writable.  Writes are limited by
>>>> write mask (which probably is also filled with random stuff),
>>>
>>> Yes, it is also allocated with 256 bytes only.
>>>
>>>> so the guest can only flip enabled bits.  But I suspect it
>>>> still might be exploitable, so rather serious because it might
>>>> be a host escape for the guest.  On the other hand the device
>>>> is probably not yet in widespread use.
>>
>> ...>
> 
> I can add to the commit this paragraph of the cover letter,
> and I think also the 'mitigation' note might as well go in.

Yes.

> 
> I've also put the cc:stable into the commit message.
> 
> Updated commit, ready to apply to master if we're OK with it:
> 
> https://git.linaro.org/people/peter.maydell/qemu-arm.git/commit/?h=staging&id=c075b5f318a8be628ab8edf93be33f5a93a4aacd

Thank you!

> 
> thanks
> -- PMM
> 

