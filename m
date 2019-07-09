Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FFDC73C5C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 21:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FAC2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 21:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIML+XK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FAC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hky6L-00029m-Tq
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 17:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48669)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hkxoM-0003O2-0C
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 17:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hkxoK-0007gW-4O
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 17:38:05 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hkxoJ-0007bw-JG
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 17:38:03 -0400
Received: by mail-qk1-x743.google.com with SMTP id s145so297802qke.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LTWeooGzb1CtqHD2t1EFQjkp7Pg5xW/NHkJhzv44BZA=;
 b=lIML+XK1kzgsm2hXb4D51mdVaPg2RymaGBxFreIcrsONoJ6gqjeB3UI+QtnkFL5QJM
 DTpUcR2J+UBYk9t0cwJyzntcsoHy7HQxOCoQ8EWRErb46hXK59nmLZufvsFFrfk8jVh8
 Eg4JNXzReZvwEZcRARn8gTmFmH4d/QxGoX7/k7W+O5ZpiYO95NZPKN3sCZ+I+2cbFNi2
 mtrT2vWetA0r9BGPnYbfgpd3xUBjiZ3aDdwGkE9VVVFNArNMFH7APKXs8VnJNnSoc4gx
 skKjaHlJEzCYkvimLZ2dAP1CJCe3iUiGut3wvpT8TG4F+sqG4cAqzMeDv2vx+rT5F7jz
 ohaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LTWeooGzb1CtqHD2t1EFQjkp7Pg5xW/NHkJhzv44BZA=;
 b=VfWipFOWdjJ9jLG2QTTy11bOhmdedGyVNcAN5Pi91JIo24BHIV7Wtfb4vFvpBy4oRf
 op3vyBGhYBp2/TylXe1MH93WwXtzNR0wd9sqhslFl2yQEDek/Ge5URz7azHxwAgYzgwG
 xTMQttQ5FCD1oJymvOrGiduVQUwdCE7G+jeE6rS+nls9HlA8R4XbmqnKOXTmKEpYHtOK
 y+YY3P0x03rjpwBQOMahXQAwWtUh1ZtVIuqpgoGvvbohfH3hUE4AJ0es+1MkMl7FHrWF
 tm0JGLhdhX6HoA9PlSnq4w21O+48rmyD1wY5g2i6kFv91PtWt+RAYT03FSCVk49Sc8s2
 FXFA==
X-Gm-Message-State: APjAAAVM1MszX1r4xk0ZHob950O4WkU/2zT4pxZKR23U1sBfsmFsreqO
 meMudJ7qgCgMeUYmirU7Uq8DxoO8RJ4fN/BqpHg=
X-Google-Smtp-Source: APXvYqzGNHMszZGb0R8SnCmZMDChLz6qrgxQqHy8PHGRPkp1G7ACok8beHTQyWYJX5DDOYTzKyio4V3U5SHhEyQscBk=
X-Received: by 2002:a37:6dc7:: with SMTP id
 i190mr18897269qkc.489.1562708280834; 
 Tue, 09 Jul 2019 14:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190628120118.78920-1-mrolnik@gmail.com>
 <7213c712-5405-5fa8-bb2b-858f4d48ac54@redhat.com>
In-Reply-To: <7213c712-5405-5fa8-bb2b-858f4d48ac54@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 10 Jul 2019 00:37:24 +0300
Message-ID: <CAK4993jCNdFVFcZ8_BnQgY-22yheEb537RaGS9zy8LUKKMkdnQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v24 0/7] QEMU AVR 8 bit cores
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
Cc: Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe.

I am working on it.

On Tue, Jul 2, 2019 at 6:55 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> Hi Michael,
>
> On 6/28/19 2:01 PM, Michael Rolnik wrote:
> > This series of patches adds 8bit AVR cores to QEMU.
> > All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully
> tested yet.
> > However I was able to execute simple code with functions. e.g fibonacci
> calculation.
> > This series of patches include a non real, sample board.
> > No fuses support yet. PC is set to 0 at reset.
>
> I see in this thread you test some binary:
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg02291.html
>
>
> https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR=
_ATMega2560_GCC/demo.elf
>
> Can you add a test that uses your binary and check it does something?
> That would help maintaining your work over time.
>
> Avocado tests can be quite simple, i.e.:
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06515.html
>
> Since you added support for the USART, you can also add some
> assembler instructions to use it to this test:
>
>
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dtests/boot-serial-test.c;=
h=3D24852d4c7d0b3fc08fb0dab35f32372a0b2c46db;hb=3DHEAD
>
> Thanks!
>
> Phil.
>


--=20
Best Regards,
Michael Rolnik
