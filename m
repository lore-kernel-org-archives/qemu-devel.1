Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26083C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 15:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4E420725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 15:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJZiGzoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4E420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibRHA-000106-Vq
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 10:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibRGN-0000aP-Gn
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 10:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibRGM-0004ID-Dm
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 10:35:55 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ibRGM-0004Gw-5T
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 10:35:54 -0500
Received: by mail-wr1-x443.google.com with SMTP id c14so16382475wrn.7
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 07:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w4pneJda0ki2zuLcE/nBxWqJUWdH24PCVaOH6J0LYfs=;
 b=UJZiGzooO88sT0e79vHiPI5hP9vM1mbRuQhI+S8qG7fSzU5gjDrXfkG5cAmCU1SGns
 TV496ZN+qIMIbEj8Q9DS1TKy+DM2Lfj69+LiPg/wGFzrXxX1svGYda8Us5S4yccqgpbt
 kmf1t9eo4he9KjhkkHfKUcqyY++/3+7UurW7xfFAA8aagmbcho2hhE0ttjhexB9eVokr
 11ASiyqjf1FiyIL3IcrJL90HEuNqftAJ8t2jeHn5Lp1C4i2bX1feyADt9h/bN6Tjwr8O
 kX68JDujJ5BzZxL0l6xnRsRKYaQm6SmOeYkblcAnWQXRJa9Hxmf/0vChKJ2UoNGVp67S
 gEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w4pneJda0ki2zuLcE/nBxWqJUWdH24PCVaOH6J0LYfs=;
 b=UNP7MgGKQADwQj+jHaQ2ucosv3+SLPF9Ww1Au2mN6h2ZxlLuV53e0+2EzKzJ9Q/qpD
 X3N57vkLgLVffM3osHyCouTeluLYzvXqbLt+JSqMfM1GnWxycTndfdKcFtgR1yQSqfKH
 YnVKETLTV5g55BG/c4nqNKKmVRrd2vXaJhWZWiGdYmAXvvIgSUL5LOBU5Pv/JSfGwJL0
 ZfQd1M51yhBNOCI9mVKfJmeHkPJhDimFt7j4aI92IRqtPi5w+vXL/e5Ojsgj+kuBS6AO
 W+MlgDr91u0pfqgyfKkKdIEFfYlm54tOH+F9QWcwN12I8UazpHyrw9sm3HioSQGEC2Ly
 XRoA==
X-Gm-Message-State: APjAAAW6rP7nBDXBfrg4zlr7xe1R3KiZQZpW7lzxgeP+AHAUrNMj4A9t
 YgANGLARzm5+mRbZn39Ij0w4GVAOuz5Vt5yPzuI=
X-Google-Smtp-Source: APXvYqxPmkGuYGOFN3ImhNQSjovs1eAdrkeqMlExxVkarDMmeizRAF7rczmBEbIF/KtKwJseTZR4YkW0D3ZyGzKXWuc=
X-Received: by 2002:a5d:6350:: with SMTP id b16mr824104wrw.132.1575214552867; 
 Sun, 01 Dec 2019 07:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
 <CAL1e-=hoxa3md+N4xraW99GyqG=nuPO48jaEc75=F+uyJBRYEQ@mail.gmail.com>
In-Reply-To: <CAL1e-=hoxa3md+N4xraW99GyqG=nuPO48jaEc75=F+uyJBRYEQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 1 Dec 2019 19:35:39 +0400
Message-ID: <CAJ+F1CKwMntHSCnZpUUbaXn675BNaiYhrczG4NaSNz8naZa01w@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar

On Sun, Dec 1, 2019 at 4:15 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Sunday, December 1, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gma=
il.com> wrote:
>
>>
>> - "RFC: mips/cps: fix setting saar property"
>>
>> Perhaps I should have used FIX instead of RFC, because this should
>> actually be a real fix. However I could use someone help to exercise
>> the code path.
>>
>
> Marc-Andr=C3=A9, hi.
>
> There is a work in progress on fixing this. Can we in MIPS submit the fix=
 independently, since it involves some additional pieces of code that are r=
eally deeply mips-specific? We acknowledge the bug, and want to develop the=
 real solution. Can you simply skip this RFC patch in your series, since th=
e issues will be handled separately in our patch, hopefully soon after the =
merge window is open?
>
> For all other mips parts of your series, you have my "reviewed-by"s , in =
case I forgot to send them explicitely.
>

This is a one-liner, and it is required to achieve the goal of the
series, to remove PROP_PTR.

If you prefer, I can instead comment the line with a FIXME, since it
is apparently broken anyway?

If you manage to get your fix merged earlier, then this patch can be
dropped. Else, is it a problem for the later fixes?

thanks


--=20
Marc-Andr=C3=A9 Lureau

