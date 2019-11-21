Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F178C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2808F20672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRJkjmBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2808F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXpTY-0006sh-9i
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 11:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXpSH-0005fH-CC
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXpSE-00054O-Ce
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:37:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXpSD-00052u-SU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574354233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsXWsjdt0679tr2vRQUdzkBKAFyQ0vXUTb6ndCkBtgI=;
 b=VRJkjmBw9S6TPm+AwU6z1IlBSZcZ+dTfrNKefQOvlT/tKEsSBx4Qgswtb2g8tKXCk/UssR
 nDhCF/Yitfs8z78a+E/Dbztm/VXpZ8hnhgiJJj7t2+MM5vbbmrTov/k+7ai4iWjRJ5eTRh
 d/GqSv4ETppMJpRG9PVQNZY+o5cWoNc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-5xThmW5dNAeCzMUWaF46YA-1; Thu, 21 Nov 2019 11:37:11 -0500
Received: by mail-wr1-f70.google.com with SMTP id a3so2364931wrn.13
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MDRBO739PHOjVF4FV2MmIh8mGFI2SvN8tJfBN8rfJiY=;
 b=Gp7o8ijRC0ChgURizTZ3ePU+8xxqDYuU9hoaANP2OzA+/tN/DX2hHF6g2BDTcOg9nB
 fZYBIfF41YbVrp3e0pGp8V2mNSBnI5DR1Z1cqmQuv2uSwoyH+dOYLzmA8cmFx/VWIgPN
 GyEdYU1ogyT1cdJaiilEDN0XN9OFBYcjuRTGr+HorhQ5VV+fvAyUCBuxk4v8v+uMhPXM
 TP+3Tetu2GJ65XQoqSpVbUJKUQxFKm+I2aGyFm0ATTiwxMtkw6BDTgLNgE4W+WSc2tnk
 P9/MAZapVglCs1myp+Tgk+vUQVR84FWByCLOxzu0b9u+3epYvKGz4ohy3VBKjFnIPIhN
 erPA==
X-Gm-Message-State: APjAAAUStAMgG7ZJoDOcq6oHCqLzaZCezmaA54fOChc814Jlsn8rK4Fg
 TJdId1rYfFM1QLA4uPIddC5XPpTOjXKIVrFt59wFq6dxA43IpA5jHbJDzCSjo7zuuObLFeYIDUB
 pVfQS3msbJqpYCqs=
X-Received: by 2002:adf:ec4b:: with SMTP id w11mr11676434wrn.243.1574354230742; 
 Thu, 21 Nov 2019 08:37:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpGyXr82FzfaBPLMoRd7P+EQDkXoKJ0SXeBTrAKt18aPbOnZ8HuK0sDJNpzPDh4kJ50kFndw==
X-Received: by 2002:adf:ec4b:: with SMTP id w11mr11676407wrn.243.1574354230546; 
 Thu, 21 Nov 2019 08:37:10 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id a11sm163165wmh.40.2019.11.21.08.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 08:37:10 -0800 (PST)
Subject: Re: [PATCH v2] linux-user/strace: Improve output of various syscalls
To: Helge Deller <deller@gmx.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191120145724.GA15677@ls3530.fritz.box>
 <CAL1e-=jqoV0v0NdpeL3NUTOfURNJ9qmD6FcCjV30pXsdBeCD=Q@mail.gmail.com>
 <CAL1e-=gOHZOTnyB0=HOAqzqS4gBF1YkB7x3yQYGJvi5qWg20Kg@mail.gmail.com>
 <015ab947-57ba-6d73-d99d-2e3263226c02@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f7f4ff93-fad0-3d72-a224-c19302dff9e0@redhat.com>
Date: Thu, 21 Nov 2019 17:37:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <015ab947-57ba-6d73-d99d-2e3263226c02@gmx.de>
Content-Language: en-US
X-MC-Unique: 5xThmW5dNAeCzMUWaF46YA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 9:19 AM, Helge Deller wrote:
> On 20.11.19 23:20, Aleksandar Markovic wrote:
>> On Wed, Nov 20, 2019 at 10:13 PM Aleksandar Markovic
>> <aleksandar.m.mail@gmail.com> wrote:
>>>
>>> On Wed, Nov 20, 2019 at 3:58 PM Helge Deller <deller@gmx.de> wrote:
>>>>
>>>> Improve strace output of various syscalls which either have none
>>>> or only int-type parameters.
>>>
>>> It would be nice if you included a history of the patch (after the line
>>> "---", as it is customary for single patch submission). You changed
>>> only ioctl() in v2, right?
>=20
> Yes. Will add history in next round.
>=20
>>> I missed your v2, but responded with several hints to v1.
>=20
> Yes, I saw all your mails.
> Thanks for your feedback!
>=20
>> userfaultfd(), membarrier(), mlock2()... - all could be included into
>> your patch.
>=20
> I think there are quite some more which I didn't included.
> That's why I wrote "*various*" and not "*all*" in my changelog.
> I'm debugging other code, and the ones I fixed are the ones I
> actually tested with my code.

If you don't have handy way to test the other syscalls, I'll rather=20
restrict your patch to the one you tested, at least you are certain you=20
didn't introduced regressions. Unless their implementation is trivial,=20
of course.


