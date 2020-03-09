Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E3C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B9720873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7vv9C5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B9720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNKr-0000I4-Nt
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 14:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jBNIm-0005X1-1j
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jBNIk-0004TP-0C
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:38:55 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jBNIj-0004SV-Nb
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:38:53 -0400
Received: by mail-lj1-x243.google.com with SMTP id f10so11089687ljn.6
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x+g5J1w0OmqiClDOsCGofXUvS/N6rpssEiz/rhBpeNs=;
 b=u7vv9C5z20mmheCGX99CwWNjukQ1NnXDyBeG7NK6qvYLgZuFauABVYM3G2slENvjaz
 gw3N1ryJZhdejVbtor+sGtc1zc9eYw8lFTs3JuUGAQ1obJeTlkhhcbWQ1BT3p0o0v5uS
 oEo0+CCPjKBZoCseLrSXRLj3KyFgXCOoQw+GCAq28dsX5n0GVxdd3V8cIxy3fZ/eDWle
 6CU3/mhfjov1O9w/SSub7uzT1EjX1aph4fqXvm4dLVKPy3Mf7fyqHHRGJ4ut5W0uD6PR
 NNspZG74N1Cesy4Yz2xY6viZeKpB+Ozpie051r7QjYZdOX6HOdZ+yevvLZnAqo7fSh5n
 ZrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x+g5J1w0OmqiClDOsCGofXUvS/N6rpssEiz/rhBpeNs=;
 b=jtTI79UHQUTlhpehwZwEC5lJxIw5noCu0MDY0IxTQo+i07U80CUjPEaPCymm4bJeWq
 1c0UqhUBmyaOTd32m9r+8MBk8kGoNQ+9xTuUMCCWQJ3UbI+pFbgVtLJ4bhAiGpcxKyZa
 CTaaEqD/8yTRy8ouSE/XdGpkbLvZu90UuHKW2/GOxUdZhAU1PwI3mVXrG2Hv20f67YnM
 308hsTGmp1ol3AVBrPf2n3TxJFPIia/gJSxhaAOzr2ihYHuvaas+jmonBjWJRbUc/tLr
 Mk+H1gvItnFRbC3BhPaCh/sNMHYDTa/I6hpfvcWZZElMyMd3kxmti2/AyzxeTD/dyptI
 Ml+w==
X-Gm-Message-State: ANhLgQ20C8sUvnHkweLdgrNj22sHB4qZhtgkjPqHnvkivdoMxqde2D4F
 xjc6gOouR/Q/MoIbdGEBWsOr/d9cWhY9QEKQJ3o=
X-Google-Smtp-Source: ADFU+vu8j/PCWsfyCIXrsuGuKMo+UXZAukPpOJnYerD/4niczG7OZoeClOdJKey8Lv5SfNH9HXSB3g9UuxYIKax0aPE=
X-Received: by 2002:a2e:918f:: with SMTP id f15mr1998118ljg.246.1583779131783; 
 Mon, 09 Mar 2020 11:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200306140917.26726-1-jandryuk@gmail.com>
 <20200309100822.kf3hftjdnkmbl5vx@sirius.home.kraxel.org>
In-Reply-To: <20200309100822.kf3hftjdnkmbl5vx@sirius.home.kraxel.org>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 9 Mar 2020 14:38:40 -0400
Message-ID: <CAKf6xpvy_41mHYkr3YFCsb1PNYagMjV=OGDJcNr7fFmLpWst7w@mail.gmail.com>
Subject: Re: [PATCH] usb-serial: wakeup device on input
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 9, 2020 at 6:08 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Mar 06, 2020 at 09:09:17AM -0500, Jason Andryuk wrote:
> > Currently usb-serial devices are unable to send data into guests with
> > the xhci controller.  Data is copied into the usb-serial's buffer, but
> > it is not sent into the guest.  Data coming out of the guest works
> > properly.  usb-serial devices work properly with ehci.
> >
> > Have usb-serial call usb_wakeup() when receiving data from the chardev.
> > This seems to notify the xhci controller and fix inbound data flow.
> >
> > Also add USB_CFG_ATT_WAKEUP to the device's bmAttributes.  This matches
> > a real FTDI serial adapter's bmAttributes.
> >
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
>
> Added to usb patch queue.

Thanks.  Unfortunately, while this seemed okay in my early testing,
something is still off.  Typing at slow (human) speed, input seems
fine.  Pasting a large chunk of data into netcat has some of the data
dropped (not coming out of /dev/ttyUSB0 in the guest).  The VM kernel
reports "ttyUSB0: X input overrun(s)" with X seen between 1 and 8.
EHCI seems fine, even for chunks greater than the 384 byte buffer of
usb-serial.

As one example, pasting
Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0
looks to only have the following output in the guest
Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Acc1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0

Characters 62 & 63 don't make it through "c0Ac" -> "cc".  The guest
kernel does *not* report input overruns in this case.

Any ideas?

Thanks,
Jason

