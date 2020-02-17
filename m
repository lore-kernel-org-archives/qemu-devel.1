Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5716C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717CF20658
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w/lJnWmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717CF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kBg-0007DP-KI
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3kB4-0006oV-CT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3kB3-0002rN-87
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:27:26 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3kB3-0002qm-19
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:27:25 -0500
Received: by mail-oi1-x242.google.com with SMTP id a22so17365967oid.13
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 09:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pOlgU/AEoqJzvSIScV6bXKV0p3MUwxdTMDZQHvg3Viw=;
 b=w/lJnWmqaxB8O2G0g9nOf/vl6ltCznRqK0Yt4OkjqNVUFgEW7uYBJaqh3zH/cRzoiR
 pVoOgoofEdIhjlfBYcnHurZiPzJDdc5xKmsx3yyRv6eCPeuohyLTWf7gAgjLubRMtzjk
 lVqhDSvS+WQCdW5P6FL7Su2HtksNnoqa0v7c6ZFZRrnmRlO9W/94TMhcDEHzXomSGwjO
 OD1RWyOPt4VrK5trby++JmtvUuN3RSZs8p6Rpfykp4F0JZApd3FyDQCoJ6Q4imwZhtn7
 jLBig3/mDUGjYc7mJVMhNJoUgztTqOJFNOO1fq42rE8EObtRXG4KzBpK+Ph3AXWbEotG
 D4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pOlgU/AEoqJzvSIScV6bXKV0p3MUwxdTMDZQHvg3Viw=;
 b=BSzhkzte6g31OFBewXVe0NRtfUbSJyaAV8OYI6Sa2NP0RPJLGnnHtlMWafIlRHfC3Q
 horBvbyDXX1wPYoX7MKDgBTzNs155vWSbXOf+UAH/t91OOLPaYHtq9wJOmUfySQ8ZJ/b
 qjf7N/7UXYGmvXmtqlnuNiYNt+r6pqrK4cnXO3iSnDnD/+lWSTjMBFHLf38bkZFqjE3/
 OjyapqGdMC6rbNFfMyG2ltIyh6H52Z1zdXEpdQ0Ch6Nx6+U/ZWdHhRpnbYmABEkUqNzu
 eJNHRco7dVNiOpRIOy32I4oFtKYttNuhAz+CiAJWz+6iJsw79l91W7y6/wOECP6bOmUi
 OUkw==
X-Gm-Message-State: APjAAAUk5FV2xCt+Zc8Dd5r1X1693jPaW+4kJ5l5E9TjxiJfKket+sgF
 fxNLfEG1CQZUIiiwvhW/N9GG80EiqFwnt/dEWIgy4Q==
X-Google-Smtp-Source: APXvYqxlkLxPkvqHkjB/R7HffSWkQ0t1HnI3K21U45wiImMKRUAfBHmTxWDD+0d7/IDQl4ATU5ZBjSMdRs0HZ78T1Y0=
X-Received: by 2002:a05:6808:289:: with SMTP id z9mr93718oic.48.1581960444122; 
 Mon, 17 Feb 2020 09:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
 <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
 <e530629d-c029-1d7c-b5b7-cdbbeb397a4d@redhat.com>
 <CAFEAcA-KzWv=_kZUPNE6yyUSA36XY+q91ihJ_xh4euJ9RsyaLA@mail.gmail.com>
 <c2ae28d4-3864-dfc6-2033-93bbd7aa865e@redhat.com>
 <b9f520ba-d279-6a46-1142-e82f415f3e8a@redhat.com>
In-Reply-To: <b9f520ba-d279-6a46-1142-e82f415f3e8a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 17:27:13 +0000
Message-ID: <CAFEAcA8AD30UPqDxZ6myimhsYsgRu9A8pTCnq7WoAXewKUDN8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 17:20, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Quick check with TYPE_BITBAND which is a SysBus device, we have:
>
> static void bitband_realize(DeviceState *dev, Error **errp)
> {
>      BitBandState *s =3D BITBAND(dev);
>
>      if (!s->source_memory) {
>          error_setg(errp, "source-memory property not set");
>          return;
>      }
>
>      address_space_init(&s->source_as, s->source_memory, "bitband-source"=
);
> }
>
> Do we need the equivalent:
>
> static void bitband_unrealize(DeviceState *dev, Error **errp)
> {
>      BitBandState *s =3D BITBAND(dev);
>
>      address_space_destroy(&s->source_as);
> }
>
> Or instead mark the device user_creatable=3Dfalse because of the link to =
a
> TYPE_MEMORY_REGION?

I don't believe that this device is user-creatable. The
base class sysbus_device_class_init() sets user_creatable
to false by default for all sysbus devices, and a sysbus
device which wants to opt into being user-created has to
set it to true.

Also the device's type name string is "ARM,bitband-memory"
and the -device option at least does not like the comma
in the middle of the name, so I don't know how you'd
create it on the command line even if it wasn't marked
not user-creatable.

thanks
-- PMM

