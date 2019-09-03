Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B2FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F10823402
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUTil/mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F10823402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i58Kq-0002kP-RD
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 08:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i58KA-0002CU-6T
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i58K9-00053R-0a
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:54:18 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i58K8-00053D-Mj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:54:16 -0400
Received: by mail-ot1-x343.google.com with SMTP id y39so6563747ota.7
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5xd3EaRn2/q47I0oNhUyeFQqlRFbIiY9Dujex2TLBtE=;
 b=MUTil/mWWKOPRn6ZshL2JxTs0dGLnHI1Gtko++MOKsNzgFnn3GjPb4Mwa+qjn+3QgU
 SuE1gqIuSiFLZDEknNuHr7rXM2JCrs6f/0oo8m79U68DnbfL9EOqKQs6fE57KyliXVro
 +Wq8lLXuPVFFXw5njKbu+T55O29HHhijETIIWRxQ3z6kCslsWO7TRY6RC4KNFshQzuEK
 FLsfvfXRZ24Z7tAgFnA3zTPXvHHsGh2a/5HBgPtpF5rbcYlGzyTWpjG1AvOAP2GpgRbX
 kyE8JEouyLqZE6RCubN1sCvu2CYh+1uutaq4R5Lf21N4IH6K4AxtapXyVE3p32qWFC2i
 NkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5xd3EaRn2/q47I0oNhUyeFQqlRFbIiY9Dujex2TLBtE=;
 b=IeAR2S/AHB7IIowyds7u63dIPX/o/AUyYd7x29ReYhZz8u2oR+jcbKijoh3oP7a6Yz
 1YX09BxmbUm2wkNiqQHUtQTI1tcF9RFdiDwTPvFGXGfakzXRLXQApOo2ROJViaiNlmQB
 xOmkHIHZkxRC8tG89nLgZWviUApZ4myoUUNwUK6xWeQ0dkpf/IzGfS30dtFxTc0Q+3CM
 3QlFgVDgrGhIxoRoyVK6C7h/7q+KmKn6aAETyULZSTwh8FtqUeu0Fgdjrxbok1hJLhI0
 xljG2mDuf1R41qE9JrhMez2Bey/YXWkCzbeHvg12omZR1mpXM9RJ6F59d38EKqru9tN8
 gIYA==
X-Gm-Message-State: APjAAAU/g9XOXpMeJ6d7vTk5wxt976Y9S0PZrWT38wzM2Kd/08lfXfnQ
 dOguLNoZV99GI30L33HR8nKFH7ZzwSF5izLy8zdQEA==
X-Google-Smtp-Source: APXvYqzHAM6kwDdY4+1qSKhVCUq5cJcXglD27KYJ6Z4mUsH17PtOdENwelfZpdR8EfqeSPiCeZjXKejgwkeavmpg1ec=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr28991001otp.232.1567515255849; 
 Tue, 03 Sep 2019 05:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190823143249.8096-1-philmd@redhat.com>
 <20190823143249.8096-4-philmd@redhat.com>
 <da63a29a-c60d-7f85-aa4d-27d750f4d33c@redhat.com>
In-Reply-To: <da63a29a-c60d-7f85-aa4d-27d750f4d33c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 13:54:04 +0100
Message-ID: <CAFEAcA8xJCBKWYwEd4vhDoFcZCKyzFgaZxv5i=D=h40LLoG9FA@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 3/6] hw/arm: Use sysbus_init_child_obj
 for correct reference counting
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
>
> On 8/23/19 4:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > As explained in commit aff39be0ed97:
> >
> >   Both functions, object_initialize() and qdev_set_parent_bus()
>
> Commit aff39be0ed97 was not about qdev_set_parent_bus(), so the first
> sentence sounds somewhat misleading here. Maybe rephrase the commit
> message without that reference to aff39be0ed97 ?
>
> >   increase the reference counter of the new object, so one of the
> >   references has to be dropped afterwards to get the reference
> >   counting right. Otherwise the child object will not be properly
> >   cleaned up when the parent gets destroyed.
>
> Well, the parent here (the machine) currently never gets destroyed ...
> so unless you've got a patch in your pipe to fix that, too, you should
> maybe also rephrase this part of the commit message.

How about just making the commit message:

Both object_initialize() and qdev_set_parent_bus() increase the
reference counter of the new object, so one of the references has
to be dropped afterwards to get the reference counting right.
In machine model code this refcount leak is not particularly
problematic because (unlike devices) machines will never be
created on demand via QMP, and they are never destroyed.
But in any case let's use the new sysbus_init_child_obj() instead
to get the reference counting here right.

?

thanks
-- PMM

