Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F356CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 12:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE2F206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 12:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRiN4AA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE2F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaIYe-00050u-Pe
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 08:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jaIY1-0004Pm-69
 for qemu-devel@nongnu.org; Sun, 17 May 2020 08:37:41 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jaIXz-0007D4-Ks
 for qemu-devel@nongnu.org; Sun, 17 May 2020 08:37:40 -0400
Received: by mail-io1-xd41.google.com with SMTP id s10so7617571iog.7
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B2i5Ui8wrwTaOu5yJ1Z2IjCSpY1xpDbioENcjtQhPZ8=;
 b=tRiN4AA/WzUfwNFBw9sJMrQi6SkAwxnfp52RduhTFVRP+uNmEfqqjbIo8qSjef7rGg
 PTDn3CDEhTRIjQ0RytFcxcFqS/89+RoCw/RxJPX5kBj+FVb/b2wdq1x5nNHmP0qOAgM6
 HKR1+w+c/eFE5CZ5MljFsWGj/36Jmvyz5gK2727oSXtopK2BE6ITuIZxpWuouvMoxaJS
 Jekb6bI/bccWnvKQ7Q/StEfVc0+x9ueX4advJIL6slOw080EaowIiFLt+pgTH/5fNT6B
 0MxD2wTyjPxAYThDp0jixAWEZPxULZIJt+zMnqrdJbehsWbueIGoPt1uCPWzB7/Jkjl9
 My1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B2i5Ui8wrwTaOu5yJ1Z2IjCSpY1xpDbioENcjtQhPZ8=;
 b=LUc4XHvp0Qi4MyrG95eTvbJuMsBzVjuO/Id8Z7tJ1Se9h7korR7kwMA/VU+BXbtJQf
 SYmHN0erZ5AdxIt6ZrDJT6/UrpZ710bBcuFdXOaL1+AUarj5VvBe0FtpyFUmZUxob6ss
 nLPrSn5YLqZAfiZKGEmGZkoTUQdzedsuh5INaxC+qxZ2Y3R0LeInBA5obegdAf2iP8vc
 69Y30l7d8euRVMCdzBoFoEX64DIUcwmlfFQHKhiWnLZKEg4XqLqiF0suc5nOpcBqFW7W
 HgyLnsZGJoGQiIUVJSkhugp0083v0WTRPitAFkMUWiU07wWx5Y6P1cZQSwXkKGkcJJ55
 bsUw==
X-Gm-Message-State: AOAM531rIXoS38s/qfWI9rua7CzsKBAI6jbUoeevPUFKAV+P1X36kq9d
 25l8QPf7HXpKkIzpfQ7y6NOlhDawALPbc1Yuwjs=
X-Google-Smtp-Source: ABdhPJwJua8b+Li+jaazYmGxSvyX9SEVcMIhzRDsGPCKilfT5IXBz9Eibl/iw2sNlWcGVtu4tgdfPsfg3r19c58AeKU=
X-Received: by 2002:a02:b70b:: with SMTP id g11mr11611134jam.0.1589719058065; 
 Sun, 17 May 2020 05:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
 <CACXAS8D9CAo3oGKHdA0qvxs9g9rTJMdYKtJrhw7QqHA6jvtYYg@mail.gmail.com>
 <81bfbfd669c652657421f66a30d144d02d8fa79d.camel@bt.com>
 <CAEgYsbHejSdBiL0o-AOLURhcMw+BHyFeZskmAV4w1cN6V46N3A@mail.gmail.com>
 <CACXAS8D5YLs2BMHBR39h_XEsMZ4n7XpDE+FSdKBLDgxFGpwzbQ@mail.gmail.com>
 <3926d33de12c70af150c9e9e2d75bda69e971546.camel@bt.com>
 <34b47695-c61e-360a-ffc4-6171e25a7c0a@ilande.co.uk>
 <feaccbcfcd5a36d1024e91e40bef6eb6f359a628.camel@bt.com>
In-Reply-To: <feaccbcfcd5a36d1024e91e40bef6eb6f359a628.camel@bt.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 17 May 2020 14:37:26 +0200
Message-ID: <CACXAS8DqO8CSkkSbD5aivGxL8xVB-FS5Bm0TL3ad+OLsvzcuxg@mail.gmail.com>
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
To: jasper.lowell@bt.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=atar4qemu@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: tony.nguyen@bt.com, Peter Tribble <peter.tribble@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 17, 2020 at 9:57 AM <jasper.lowell@bt.com> wrote:
>
> I've written up a basic implementation of the SAB 82532 ESCC2 device
> and have written a patch for OpenBIOS to add it to the device tree. I
> still have the 16550A UART acting as ttya to avoid having to write an
> OpenBIOS device driver.

Great progress! Are you planning to contribute your escc2 to the upstream?

> OpenBSD and Solaris both identify the device correctly and attach it.
>
> Interestingly, it looks like Solaris entered an interrupt handler to
> deal with an event for the SAB 82532 and it probed a few status
> registers. Given that I couldn't encourage Solaris to do anything
> outside of attach the device for the 16550A, I was thinking this might
> be a good sign.
>
> There really shouldn't be an interrupt though as the reset state of the
> SAB 82532 is to have all interrupts masked. Solaris probes these
> interrupt status registers while "configuring" the sunhme device.
>
> Attempting to configure interface hme0...
> 140070@1589698603.268942:escc2_mem_read channel a addr 0x38 value 0x4
> 140070@1589698603.269011:escc2_irq_update value 0x0
> 140070@1589698603.269015:escc2_mem_read channel a addr 0x3a value 0x80
> 140070@1589698603.269017:escc2_irq_update value 0x0
> 140070@1589698603.269018:escc2_mem_read channel a addr 0x3b value 0x0
> 140070@1589698603.269076:escc2_mem_read channel a addr 0x38 value 0x0
> WARNING: Power off requested from power button or SC, powering down the
> system!
> 140070@1589698611.270845:escc2_mem_read channel a addr 0x38 value 0x0
> 140070@1589698619.271758:escc2_mem_read channel a addr 0x38 value 0x0
>
> I've noticed that removing the sunhme code for sun4u.c in QEMU prevents
> the spurious interrupt from happening for the serial device along with
> prevent the unexpected power off request (the power off request was not
> introduced by my code). I haven't investigated why the presence of
> sunhme causes these events.
>
> I modified OpenBIOS to use ttyb for stdin/stdout and assigned that to
> the 16550A so that ttya could be aliased to the SAB 82532. Outside of
> the spurious interrupt handler being called, I'm getting the same
> behaviour where Solaris identifies, attaches, and then ignores the
> device. Doesn't look like my guess was on the mark.
>
> I'll be looking at getting an OpenSolaris-like kernel built with prom
> debugging output for console/tty related files like
> usr/src/uts/common/io/consconfig_dacf.c. The illumos kernel is probably
> suitable for this because it's still maintained and appears to be
> suffering from the same console problems. I don't have a SPARC64
> machine immediately available and I'm unfamiliar with the build system
> behind these distributions, so it might be a while before this happens.
>
> I'm out of ideas.

We can use the strategy I used 10 years back for sun4m: boot the
proprietary firmware first to reduce the number of possible emulation
bugs. The proprietary firmware is known to boot Solaris.

Regards,
Artyom

