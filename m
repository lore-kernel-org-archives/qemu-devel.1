Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA302C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A426A2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qptBH0BM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A426A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaZY-00009f-EW
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyaYw-00080A-8s
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyaYv-000413-C0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:10:46 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:35687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyaYv-00040f-6d
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:10:45 -0500
Received: by mail-ot1-x336.google.com with SMTP id r16so13415811otd.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 04:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FRa4gje+Vl0O2SQA5tbHlY1gx2bs78tkOVajKaxhL+0=;
 b=qptBH0BMuWb957c/NcVwMRe7oUR3PA0JLEpL5kL2YW19BK+7L1F/6CMpkCFFJYKNVE
 KYLcwTjhhTZrYOt96UBRAXUwqsN6q835F6a6wpptpIgf7/qbcJpdk018ht/uxxYF7Hzq
 zM9d9poy/TXb+4jNrxhppRWRDY8o8H+hGWy3IdYZX1qQ1WcPjgvwco/xH8XD0/zn5OJi
 mEHR4et3g3Rbq61dK6DGrfdbL+a37spE+22x6bAj61u8UYC9kRlV2nBomlo/0EjUQCmq
 QF1Ns/eKyPFFthRzQiogZrR7ItmZJNwGOnywwjk6PyNZfNGr/FeeAikzcVSdT+0lIZtj
 Z+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FRa4gje+Vl0O2SQA5tbHlY1gx2bs78tkOVajKaxhL+0=;
 b=N3UdyLD6RXicAdwSJ2RpOu0O8p2ectk2O6qnC4kBeUd6mqEo5J97rMRg8u7AqHf0Cr
 iiAuidMofIWsywbXxuI9UtD+llh78faR/TYPcSC987AYbKhFPOMeLM+5jMxAlJQWJzwZ
 D82DVUlt4Bd7k9EX3GEiTHyEg4wh4BkHuzF26L5xBKYXnUcuxr5U/jxWM/ma7MY8oxtw
 t3L/h6H9C5ac7yzdeO8TxzAfHlY+kpYWCkT+5eDoZPf+6uTwrHhVjcnVKuwZbYH+3Kyu
 XlZxUjpaN9xxi8l2pOep8dacVTc6TBz0duqJv3lAntW3rXTJR9hppfPLxyBGUi0L3MTj
 6HzQ==
X-Gm-Message-State: APjAAAWQEAHfhx2x9tnehQZX1y7R69MHNd1yP0z3sFm9hqI2g3wGuFiA
 cmavRzDNIyQNlsRKU2icCBD+c75kF/rYOF9d4gj0QQ==
X-Google-Smtp-Source: APXvYqze48UfmhEm0HzUbU58XkH5BU+jrnt1OXzqpNJV8fqXQvd6h+R82lYwoPYw00UHZKQ86i9hlShv0emmQ1hVE/c=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr16866879otq.221.1580731844328; 
 Mon, 03 Feb 2020 04:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20200123070913.626488-1-mst@redhat.com>
 <20200123070913.626488-18-mst@redhat.com>
 <CAFEAcA98iqJkTp4F6qmO5f4VYNhE3Fs4toBuV1qNtujAo6=OJg@mail.gmail.com>
 <20200203013334-mutt-send-email-mst@kernel.org>
 <CALQyB5EtG2SZ2EBpwXkcAEzkpMNJxjw5s-ZmNJGK-cV9FFKogw@mail.gmail.com>
In-Reply-To: <CALQyB5EtG2SZ2EBpwXkcAEzkpMNJxjw5s-ZmNJGK-cV9FFKogw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 12:10:33 +0000
Message-ID: <CAFEAcA8c3wQ3AS9JD_NPvbG8pr000LGkRs8NwMSg5CY7dPiWXA@mail.gmail.com>
Subject: Re: [PULL v3 17/18] i386:acpi: Remove _HID from the SMBus ACPI entry
To: Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 12:03, Corey Minyard <cminyard@mvista.com> wrote:
>
> I checked a few days ago and someone had already beat me to it.

Yeah, we had a discussion on IRC about it and came to the
conclusion that this was a fix. To avoid future confusion,
my suggestion would be that commit messages that fix bugs
should explicitly say they fix bugs they refer to; "See $BUG"
implies to me a looser connection like "this is another bug in
this area" or "this partially addresses that bug" or
"this bug report mentioned this issue in passing while
describing a different bug".

thanks
-- PMM

