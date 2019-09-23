Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E36C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57936207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57936207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQSk-0001fb-9M
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 11:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCQRW-0000x2-SK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCQRV-0003H0-39
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:40:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCQRU-0003GX-RL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:40:01 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E28D5C049E32
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 15:39:59 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k184so6894374wmk.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pcPFpcKUi523Ys3CU2Lb1ssw8BTF69fob0LEa6188aQ=;
 b=AN2/VFXxpS8dupgyLlGbh8grx+RDPGWlUKLIpk4aKJKXMnMzaMARSog/Hc2QqrKf7d
 5ad2Su0suFhW0ed8AO068VW3BB7+gz1X1/ckjFrUBVA+veHno3c0qDwTsVgLmETJ1FeP
 dKFoWz/BlQGEIsT5JcodXyMeRVu5qYegO7ZqZeH12Lgs1eucLakCexoMWaKbmiawUrO7
 E9IBF4GHwmYNxWPYRe+D+CnyaTtFytx4TG8Fsusi90i+h5Yq0dHYNkXmdvS8rwds/XlD
 paQ1FSx3OzHvky/QAYVjB5/FtZkM5UTrxoc5qIxOQSmTl7jCV6j8qEvSBcouMe9iWCgS
 UYYA==
X-Gm-Message-State: APjAAAXRJ6QP7rV00c9gYkmDS0IestIMCTuF/CFEKNl3kIZsFOva4o8x
 n8cF3+oP5Qjfmer0dWCf1PoDRqGU+9d3J6cPNsO4eo3HMk9IrSOXkbV81cYcA3RTM2A7Q455I9X
 cQLwn7u0M+oiWV3U=
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr211585wmg.73.1569253198709;
 Mon, 23 Sep 2019 08:39:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyLfkCfndxXJagQdjKTPWPdLI8DL0lZOQ3ev31709icnPk/Ge3gUiC27t1Pnn35/IGK5R9NZA==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr211567wmg.73.1569253198521;
 Mon, 23 Sep 2019 08:39:58 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z189sm17971177wmc.25.2019.09.23.08.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 08:39:57 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] hw/char/bcm2835_aux: Provide full 16550 UART
 support
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190820123417.27930-1-philmd@redhat.com>
 <CAFEAcA_6uBtREzj2UaSwDp_VWd=oPsD-dARcOPeJdcMpO5kaHw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <93b7cd93-e03d-d0c5-7cae-7f571a9b8ca1@redhat.com>
Date: Mon, 23 Sep 2019 17:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6uBtREzj2UaSwDp_VWd=oPsD-dARcOPeJdcMpO5kaHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 9/23/19 3:26 PM, Peter Maydell wrote:
> On Tue, 20 Aug 2019 at 13:34, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>> Since there has been some activity on the list asking about
>> Rasberry PI USB support, I had a look a some previous unfinished
>> work and rebased it to share, in case it helps hobbyist interested
>> in improving these machines.
>>
>> This series is some proof-of-concept on improving the AUX UART
>> support. See the commit description for various TODO/questions.
>=20
> Apologies for not having got round to looking at this
> RFC patchset sooner...

No worry, this patch is not very important.

> I think my question here would be -- is using the 16650 emulation
> really the right thing? The BCM2835 documentation says
> "The implemented UART is *not* a 16650 compatible UART. However
> as far as possible the first 8 control and status registers are
> laid out *like* a 16550 UART." That suggests to me that it would
> be better to just improve our model of this hardware rather than
> to replace it with a 16550 model which isn't what the hardware
> really is.

Some registers are the same as the 16550, some others only implement
bits (identically placed). None provide extra bit (a new bit not present
in the 16550, for that they used new registers).

My idea was to reduce/reuse the chardev code.
I think a correct way is using the "hw/register.h" API to mask the
unimplemented bits.

This patch reduces a lot of [LCR/LSR/MCR/MSR] "register unimplemented"
when booting Linux, but from the emulation point of view they are
harmless, so we can ignore this patch for now.

Thanks,

Phil.

