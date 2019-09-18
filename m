Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C262AC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB63214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpzYIFRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB63214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWvK-0002HH-3M
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAWnj-0003B3-S4
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAWnj-0004pz-09
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:03:07 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833]:38485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iAWni-0004pQ-NF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:03:06 -0400
Received: by mail-qt1-x833.google.com with SMTP id j31so8170212qta.5
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V2MFLc6nPWIQyl/mz789miBwMoFARwcqBDfpLGr0qdc=;
 b=qpzYIFRwfLfZbcmnj4kEBFzXxGoKMoS+xwsrnHrYPof2O+EEmmrsBp6yEHfjhd4Q9U
 giz+n4g6E3GoJ+tD3cMfUNH3ov1GCR4p87Ofqfy5EQ2bHeGfmdstqtAGj8Mx9mgYI46u
 gmwwljwKCuf2Se6LVrdhJAlbZ/dQNaZB2JU7YNNQKC4pnK8zojajQD+5ADXY+lIJmNBY
 iBdRD4xaNfwDfya7KaELNBtgJcEWlgok1un6vi1mTPW6Uw4B7NcApdLL4Js1dCm6Z2xv
 M5oUyfuDm2Ws+0kJtw09yW4Xay9jyRZ0GcJmjphr4GXvALMjiv4HQry7yZ/iXw3wg55Z
 GzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V2MFLc6nPWIQyl/mz789miBwMoFARwcqBDfpLGr0qdc=;
 b=JSIv7f79qoufJizz8UWx2WkuhEgoGGtBetRjLFxrVoYzl62tzXI8DMbLN0ZGs5hhYs
 phGJtcckUgWoEWC0BrGxqoWY7LF7pn8i14hHDXc7nGMYJ+ZUkiZLyYEl8aUNCglXRT42
 s1PLz0JbDRDmEXqfoBKSbrvC6oyeIetZ2UGN2PxL6GHwaqw9RqDFAPiEN360JCKE7FUE
 BlhfDiMj1gmFk34lGI3Q7m1HkuVlR3nJiWKBtso9cLwRkXIE7QD75YqvQ3vwG+b6Gwm7
 xn+ur/K9R5GL3PwT1zrMNold+ZGlZtrFElNchTO7HEVtE9jFLdQD+JoHHuxlvWHQfURp
 4kkg==
X-Gm-Message-State: APjAAAUAsfdAoe0bT0bvKX60veyUgZM1HmfokquosUc2mHPT6ukWex40
 5HXQ1EgQpgJMxu/+eTFuNI1nGVhjsJML2E77xGo=
X-Google-Smtp-Source: APXvYqwIAe9iLoTZWujgzb4sW5oWY+Ned7c42fXCN7i2Z9Me4v5rKe8GI/oy03CWaMpFJ9g1N5ItcCbQQt/y65rQS5A=
X-Received: by 2002:aed:3576:: with SMTP id b51mr3348078qte.378.1568800985464; 
 Wed, 18 Sep 2019 03:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QVMjw_zm16MRo25Gq0J9w=9vrKDZtaH=WGwjSJiDAVm9Q@mail.gmail.com>
 <20190918082825.nnrjqvicqwjg3jq6@steredhat>
In-Reply-To: <20190918082825.nnrjqvicqwjg3jq6@steredhat>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 18 Sep 2019 11:02:54 +0100
Message-ID: <CAJSP0QXCJY4+5P9zU4670dfwjmKEUagB9gFrqF3H9cCPZPbzbA@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::833
Subject: Re: [Qemu-devel] [libvirt] Call for volunteers: LWN.net articles
 about KVM Forum talks
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
Cc: libvir-list@redhat.com, qemu-devel <qemu-devel@nongnu.org>,
 kvm <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 18, 2019 at 9:28 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Tue, Sep 17, 2019 at 02:02:59PM +0100, Stefan Hajnoczi wrote:
> I volunteer for "Libvirt: Never too Late to Learn New Tricks" by
> Daniel Berrange.

Hi Stefano,
Paolo has already volunteered for that.  Is there another talk you are
interested in covering?

Stefan

