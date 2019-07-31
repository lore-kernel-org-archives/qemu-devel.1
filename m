Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E76C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADC4206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADC4206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsr1E-0003J7-7f
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38319)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pmathieu@redhat.com>) id 1hsr0W-0002id-U6
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1hsr0U-0005OE-T6
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:59:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hsr0U-0005My-9P
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:59:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so61385555wmj.5
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 08:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GEBZu5cSpffuEdvDGxVxgzmDlm4HDdGoJ5sXd7LyXd8=;
 b=FMx4U8+Ud37cWWqIKAnZJYt333WjIXiN1fdfW78UqBCNe2qNErnuvDwrggh2D+peEQ
 8ZeJ/sHTJHXfpIVE3BUrvtM2OBKCkO//6XKJK6MaOVV4AKmnbOb4d726yIyD2Z7BzvYr
 +/itXecVwFvNV3xfhHqLxB7qN/h6NpwHGuEEWx46bTIYzBpU16yPCM/atmZ8vHpYzxZI
 l6EfKJ6ImiXQ2pMVHQXeS4FUB0gQ+lhBT7t4FCXvhEMYvY7wRR+FUq8Tm06HWJw1ennL
 gWb4U3Mrfsyvfc3G/bSmiPpZx4e1SqiwMxinb2urzAPPBVzpCrSo218uz46ttFVvfVBU
 axkw==
X-Gm-Message-State: APjAAAXWHzTgfSbvif6MABUqUv7jCpv4gONFtyajXWyqSjKqymgF56i0
 BzUyWlHKa9UuJwMhaIxe94FgQ/Rhd2otXIOqFiM4gA==
X-Google-Smtp-Source: APXvYqwuhA8yM5y80xinFfsEgg5HACcfzWSubmZDBaV8/BLvkhQlUX0Jbl2lPHGfyqNLx2cmwiwaQNDc/huuUhzCg2E=
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr38900246wmg.155.1564588752291; 
 Wed, 31 Jul 2019 08:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190731075652.17053-1-thuth@redhat.com>
 <20190731075652.17053-8-thuth@redhat.com>
 <f2399005-cead-a147-37a5-600fda7eaea5@redhat.com>
 <b9bbf556-e2fc-8634-2238-9c1c5ead7a35@redhat.com>
 <18d71b10-6be2-b76e-54d6-76c0395ca700@redhat.com>
In-Reply-To: <18d71b10-6be2-b76e-54d6-76c0395ca700@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 31 Jul 2019 17:59:01 +0200
Message-ID: <CAP+75-Vrr5JcNd1tFhossrNDNEaJV4U4a+iyyDH2rgE5P6tV9g@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 7/8] hw/misc: Add a config switch for
 the "unimplemented" device
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 5:55 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 7/31/19 1:50 PM, Thomas Huth wrote:
> > On 31/07/2019 13.47, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 7/31/19 9:56 AM, Thomas Huth wrote:
> >>> The device is only used by some few boards. Let's use a proper Kconfi=
g
> >>> switch so that we only compile this code if we really need it.
> >>
> >> I'd prefer having the UnimpDevice user-creatable and always present as=
 a
> >> core device...
> >
> > Why? This is a sysbus device that needs to be wired up in code, so I
> > don't see a reason for making this user-creatable right now.
>
> Right now no.
>
> > Anyway, that's a different subject, so this should not be part of this
> > patch.
>
> Fair enough.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Err, you missed MUSCA and MPS2.

