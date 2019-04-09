Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC8C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638622084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti4oqaEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638622084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48631 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDxAI-0004My-8v
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 16:16:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hDx9Q-0003oj-R3
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hDx9P-0003fU-Sg
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:15:24 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:40314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hDx9P-0003dV-CC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:15:23 -0400
Received: by mail-lf1-x141.google.com with SMTP id a28so13302489lfo.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=y8ASMrbVuD7JfM5bdljEcwgykiBgUgiOoOCxb7xfDWw=;
	b=ti4oqaEqd5Ug0G4MS3HSA/rhB015qUQ8UpnvVoRVgE7nxl+aU6sbs4l6wVNutFE4m0
	Hr3PcuYaQcCBd+ALV16h+x8OFKlZxVX91ZkpEpVAgohXkDvEHlE7j/N33JEEFrQBAVT5
	xj9ouwj969bzMyYg5ZQAkOgTYwpnszH3NQBmeCsXGXQNBLJTTnmn/v+WpXTrRwq0DmQg
	+7gN7N7h3qQnEKXbYLHNffN2SYMfAsKVBekPIV+wmI2mLGG6ZF5/d4ybl3FM2tqoArZL
	OqaamMsSsBeWKV0dEdGqjnLgphmsxmJf3kcqVgA9OIEycwIG6raDmrWV3PhOdP3PjswQ
	98Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=y8ASMrbVuD7JfM5bdljEcwgykiBgUgiOoOCxb7xfDWw=;
	b=DsSZ/64LpzfZ7XZzmumeycc0QZjFpBPTTABZ7aZnnWryNC0qVPWBCdL0fpCFwXvScj
	ai20YBZszBJs3tU/gp1/ynLmoP4MFhVuBlxsMCT+3ueo66NBZIruy2BItgliNMM7j+t5
	DcSILLq5dtRdgXAq4voFnH0JcJ5vcHvEzGZXEPNl+s333EZS0tVac8y4ag0oFrNgBN4F
	DHsftLJIaudXREG1/Iv9vzjxC+H1SHhEQSv+9eFh2IOepju79gAlUT74Qvj0o+QAX9zF
	48fAe7QfQaPde0mGCn+fjwu/iBWHdETt+6MzRfH6JwlELbq2Zw8vefdsh2XW30r7dJkk
	Rpow==
X-Gm-Message-State: APjAAAU9cJ60x0ImNP9jmkr0CrqccQOhPxnh8Ld+4x2tt+yZfokR6XTC
	GQiGXcuU++7GKUzEQl0qnaiW/eLIW09eii3GRXs=
X-Google-Smtp-Source: APXvYqz0JQdFfaMHhG4z9MxXAOHQryncsBGMEtJlnH+76gkb6NlOkyORbnTqKnVZ6lp1+9jaf6n86KbBLC+8w4MraO4=
X-Received: by 2002:ac2:5326:: with SMTP id f6mr479352lfh.100.1554840922024;
	Tue, 09 Apr 2019 13:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190409174018.25798-1-armbru@redhat.com>
	<CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
In-Reply-To: <CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Apr 2019 13:13:48 -0700
Message-ID:
 <CAKmqyKNAT6a+a6MyhSh7RErUOyCPnEv-RKM4S-j12GS9dUMTYw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Alistair Francis <alistair.francis@wdc.com>,
	Markus Armbruster <armbru@redhat.com>, Sergio Lopez <slp@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409201348.RS2C6wJkxXapy3kqc4xJfHvvqd4xUJtBHX9J_-tb958@z>

On Tue, Apr 9, 2019 at 1:08 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 10 Apr 2019 at 00:40, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> > computation of @dt_size overflows to a negative number, which then
> > gets converted to a very large size_t for g_malloc0() and
> > load_image_size().  In the (fortunately improbable) case g_malloc0()
> > succeeds and load_image_size() survives, we'd assign the negative
> > number to *sizep.  What that would do to the callers I can't say, but
> > it's unlikely to be good.
> >
> > Fix by rejecting images whose size would overflow.
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> I think this patch is missing some attributions for the
> security researchers who found the issue initially.
> PJP's patch for this from a couple of weeks back has a
> reported-by credit:
> https://patchew.org/QEMU/20190322073555.20889-1-ppandit@redhat.com/

It seems like from that discussion that this patch is the correct approach.

I can add the attributions and send a PR for 4.0. I'll send it by EOD
unless anyone has any objections.

Alistair

>
> thanks
> -- PMM
>

