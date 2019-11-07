Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E185DC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6142178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJPtjIOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6142178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShva-0004Dx-Sh
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iShui-0003Oj-Bo
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iShug-0001tI-Nu
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:33:28 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:36754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iShug-0001sQ-Hb
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:33:26 -0500
Received: by mail-oi1-x231.google.com with SMTP id j7so1958136oib.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 05:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=i+RcGmsMAg5FId+iPS7U5MX0kTyX4WzklBsRpdxYx9U=;
 b=lJPtjIOOAYeAXg+i+fMrzIjtt+PhxJYXoTo4p35GP8G2dSOxmYa04yTa5A+bzl95dq
 pgeECcEoWhrDfHp0IuK4K/hmrwuAFaxfXygdd9hlaAaMK/RCq0Kghvv4OohedIjTiYZY
 BdyjhN6Fo+Obic1z7ZJULR/07Nh5n3B/z55qphaFcozTpHnFJl/GTiduisK4f9HNVbJm
 QH4B2kAdYkq53gRWVLGFAcBowhXyLpt7bUXbRSTIW7WhtOf/kvlmZJZwcVjzzF6Ut5l6
 ylmbseCB9J8tLIQz3PbekIRAp9Syczp3aSxPV8OMg6vK/mI6slWyYIfGLrx6C7uLOVG0
 Jd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=i+RcGmsMAg5FId+iPS7U5MX0kTyX4WzklBsRpdxYx9U=;
 b=sM0FOHBs5eeFsaf7o2GqApQeNPNt42g67NdP2iJj3SoLxkjXZKH18+0zuNxjo8UgKE
 /QTBivOHBLUOjstPgRwt8Cih98MJ3UsIx94EMrTduJytFS7S7t01i/JGuzMVlnMt5J3r
 70xn0LsuomgfcI/fdxWAFhvLj8lVtmVmCcy+fFePTevgqMD1jJUsu0FWiS/EuuWurL5c
 Rp8C785d/QTOUmXtHqsZDxZy0+o+nLa0cC/zFC1p1nPn/anL1RMxAHl9lkjAacU6q3TU
 oUzMGMZupPDzH7nRkE1VSVxaPWo78LLkFGiDCvwyX87xontrlVV54JAL2gWVxdTZQvVl
 pjMQ==
X-Gm-Message-State: APjAAAXEmEKu1bmHRZleQl3USQO+nZ82a3Oj/PhsaF7Ua2i3TT2FpDgg
 AztVVG+pah+b+18ZemBx8PLSIcERv9jtUrlR6FU=
X-Google-Smtp-Source: APXvYqxR95lCw7+AMnj6302OOorTj83K+akow/9IwxjchJxbI2GsAgbXvo4zOlrLClZ9tOF+04NdyuNo1FluBI/X1jc=
X-Received: by 2002:a05:6808:9ae:: with SMTP id
 e14mr3388245oig.79.1573133605344; 
 Thu, 07 Nov 2019 05:33:25 -0800 (PST)
MIME-Version: 1.0
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
In-Reply-To: <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 7 Nov 2019 14:33:14 +0100
Message-ID: <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
Subject: Re: Looking for issues/features for my first contribution
To: Rajath Shashidhara <rajaths@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 7, 2019 at 11:37 AM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Thursday, November 7, 2019, Rajath Shashidhara <rajaths@cs.utexas.edu>=
 wrote:
>>
>> Hi all,
>>
>> I am a Computer Science graduate student at The University of Texas at A=
ustin (UT, Austin). I am looking forward to contributing to qemu !
>>
>> This semester, I am taking a class in Virtualization (https://github.com=
/vijay03/cs378-f19) and contributing to a virtualization related open-sourc=
e project is a significant part of the course.
>> I would be interested in contributing a patchset to qemu - possibly a se=
lf-contained feature or a reasonably complex bug fix that can be completed =
in under a month's time. I did look at both the bugtracker and the QEMU Goo=
gle Summer of Code 2019 page [https://wiki.qemu.org/Google_Summer_of_Code_2=
019] for ideas. However, I would be interested in hearing from the communit=
y and I would be delighted if somebody can be suggest a suitable project !
>>
>
> Hello, Rajath!
>
> Thank you for expressing interest in QEMU open source project.
>
> There is certainly a place for you and your contributions in QEMU, and yo=
u are very welcomed!
>
> It looks to me the following project would fit your description:
>
> 'Implement emulation of DS3231 real time clock in QEMU'
>
> Datasheet:
>
> https://datasheets.maximintegrated.com/en/ds/DS3231.pdf
>
> The steps needed to complete it (in my opinion):
>
> - collect datasheets of as many as possible RTC chips already emulated in=
 QEMU (there are around of dozen of them, see folder hw/rtc)
>

I did a quick Google search on datasheets of existing RTC
implemtations, and the result is:

DS1338: https://datasheets.maximintegrated.com/en/ds/DS1338-DS1338Z.pdf
M41T80: https://www.st.com/resource/en/datasheet/m41t80.pdf
M48T59: http://www.elektronikjk.pl/elementy_czynne/IC/M48T59V.pdf
MC146818: https://www.nxp.com/docs/en/data-sheet/MC146818.pdf
PL031: http://infocenter.arm.com/help/topic/com.arm.doc.ddi0224c/real_time_=
clock_pl031_r1p3_technical_reference_manual_DDI0224C.pdf
TWL92230: https://datasheet.octopart.com/TWL92230C-Texas-Instruments-datash=
eet-150321.pdf
Zynq RTC: https://www.xilinx.com/support/documentation/user_guides/ug1085-z=
ynq-ultrascale-trm.pdf
(chapter 7)

Aleksandar

> - do a comparative analysis of selected RTC implementations in QEMU
>
> - get to know general QEMU device model
>
> - design and implement DS3231 emulation
>
> I can give you (unfortunately constrained by tight time limits) some help=
 and guidance. But there are other people in community too (more knowledgab=
le in the area than me).
>
> I salute your initiative!
>
> Yours,
> Aleksandar
>
>
>
>>
>> I am an advanced C programmer with both professional and academic backgr=
ound in systems design & implementation - especially OS & Networks. Given m=
y background, I feel fairly confident that I can pickup the QEMU codebase q=
uickly.
>>
>> Eagerly looking forward to hearing from the community !
>>
>> Thanks,
>> Rajath Shashidhara
>>
>>

