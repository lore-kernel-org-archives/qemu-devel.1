Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47840C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A1D2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+Vr3vfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A1D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1955-0004kM-9j
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j194C-00044s-Dg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j194B-00037V-2I
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:25:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j194A-000376-VL
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581341134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9oR63gc5Kxstekn/LqUpEIbad1MHfmrO3d4e+XqSqI=;
 b=Z+Vr3vfbTt3ejFIWrrrv1T3e4UcIKznpiwUpOEWAMoNy2vNsmIRcUK5PUba2dLFigUVxDM
 8oAO20dqnH3Whlt/+c4QrRW/5mgRAvlRP+gDDcPp74sdbNHTxmvykQEPevFnavlo7i+72/
 OSh/QLIe7GljxkgHehz1RwWILf5IbEc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-in1lamjlP_iJfKjuLi4WCw-1; Mon, 10 Feb 2020 08:25:32 -0500
Received: by mail-wm1-f71.google.com with SMTP id y24so3003037wmj.8
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 05:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XKV51D38Ol/2AB+0heBxOtcu0TQX+UzZDuODAQfBuhg=;
 b=or+DRZhWkPeMYl7Jys2shokisgu+k39WnETDAZuKgStdtVNQJsp31ks/0zQz7NPTNA
 xWIFvC7jTGRL24v26djlVOQTf/PVQdAT1LFT9Z6Gc5K/RmbhEv1Ljqkzym93VE51ZVYY
 RBg3CS+hunO0grR4cZWzubf2B0N38eQxrvedMSu25dNlai5L72p6OYsGkzsVMf5YUNxc
 4qPWaLw6+kuMZTSSHGr7u7n+wROJZcPSMksOLF4gu5PUesyuBBEqFf8KJAEOIjWK39ER
 HO4yYXW7nV+No3ic4jC4EDNOnlriiL7kAb0iUAYzCu9eMQw0ne6+UDb4vrEjT32IMPAA
 wNKQ==
X-Gm-Message-State: APjAAAUVJXdR/0KpgGdQYsOzR8EykEhvG9adp2Xdw92/ZDh7Ezed+xOm
 tXfe7ZbU0zjKWWMLMZUe9Pv5qwAxwLetjGraD5RduAxE0yBcXWpnGpsMfgc9ARtScGlfLG92xTQ
 N0285mw0qQl+Cb+A=
X-Received: by 2002:adf:f886:: with SMTP id u6mr1993876wrp.409.1581341131018; 
 Mon, 10 Feb 2020 05:25:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8Wfn6CHQ6EVXlvZ3QlBX7f+VvahWCpP7bHBG4zcYGigNgUNxKMtGWnU6aHFVeG7tHkJCdBQ==
X-Received: by 2002:adf:f886:: with SMTP id u6mr1993850wrp.409.1581341130822; 
 Mon, 10 Feb 2020 05:25:30 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id d22sm581270wmd.39.2020.02.10.05.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 05:25:30 -0800 (PST)
Subject: Re: Tricore default machine
To: Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20200207161948.15972-1-philmd@redhat.com>
 <20200207161948.15972-2-philmd@redhat.com>
 <9590e020-226d-bc85-e496-95b4f0116f69@redhat.com>
 <e4157357-7697-a2d5-8662-f5bd12d74619@redhat.com>
 <f7b72c47-4202-d220-7b29-bd5ad6283700@redhat.com>
 <c775db8c-63ec-e88a-f643-63f31de26f2b@mail.uni-paderborn.de>
 <CAFEAcA_evEqBg160MWASS1izoMkEF7-7nnRn9xhpBJVPb5ehOQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3c83ea64-179a-db30-1bd0-9d7a495af8d4@redhat.com>
Date: Mon, 10 Feb 2020 14:25:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_evEqBg160MWASS1izoMkEF7-7nnRn9xhpBJVPb5ehOQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: in1lamjlP_iJfKjuLi4WCw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Thomas Huth <huth@tuxfamily.org>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 2:22 PM, Peter Maydell wrote:
> On Mon, 10 Feb 2020 at 12:33, Bastian Koppelmann
> <kbastian@mail.uni-paderborn.de> wrote:
>>
>>
>> On 2/10/20 11:26 AM, Thomas Huth wrote:
>>> On 10/02/2020 11.08, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 2/10/20 10:35 AM, Thomas Huth wrote:
>>>>> On 07/02/2020 17.19, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> I wonder whether we should simply make that machine the default for
>>>>> qemu-system-tricore? There is only one machine here, and not having a
>>>>> default machine always causes some headaches in the tests...
>>>>> (see e.g. tests/qemu-iotests/check for example)
>>>> Or make it generic? If a architecture has a single machine, use it by
>>>> default?
>>> Sounds like a good idea, too ... we've got a couple of targets that hav=
e
>>> only one machine.
>=20
>> As far as I remember, I did not make it the default machine, since Peter
>> Maydell advised against it. His argument was that defaults are really
>> hard to get rid off since external tools (like libvirt) might rely on
>> the defaults and we don't want to break those. Anyways, no objections
>> from my side.
>=20
> Yes; we have default machines partly for historical reasons
> and partly because x86 does, but unless there's a good
> reason for some architecture why this specific machine
> should be the default, I don't think we should have a default:
> making the user specify what they actually want helps to nudge
> them into thinking about what they do want, rather than
> assuming that QEMU will somehow magically be able to run
> guest images built for any random machine for the architecture.

OK now it makes sense.

> Anything in tests or whatever that breaks if there's no default
> machine for the architecture should be improved to handle that
> (it already needs to handle that case, though: arm does not
> have a defined default machine).

I tend to agree here.


