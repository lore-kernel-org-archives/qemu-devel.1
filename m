Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E33C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 21:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586BE21848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 21:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586BE21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAhxd-0001nZ-I8
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 17:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dan.streetman@canonical.com>) id 1iAhwi-0001Lj-PT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 17:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dan.streetman@canonical.com>) id 1iAhwh-0003vq-Dt
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 17:57:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53307)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
 id 1iAhwh-0003uB-8d
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 17:57:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <dan.streetman@canonical.com>) id 1iAhwf-00020v-4V
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 21:57:05 +0000
Received: by mail-io1-f72.google.com with SMTP id e6so1903701ios.8
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 14:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=70jwlhXsk8hW6JRjE/2NrhQaUp6LGL9oV7Kgj7o79MM=;
 b=DflQq4CkrCL+xwf+gX7seMXnmFivrrLqHhyXGhlrpulJSo074DQ4dyyY5lDIShuahc
 SyKkA1uCYCZMbm18I/hz+he8ZO6u1OCWBl8+I6ecYLo8MobBFiFJOiz7xiapieGhwlGf
 VfBPi7ZjVgg8NC158ukjSX4qn/ty8y9NAmlPM7aCVL42p1Dd061oTA4zzaGWZsk/3Hj0
 qhPHk8qq+wiO3JtPKhm6M9mc9d2IIUY8MySR5eVK4CCnyofYLIVZ2LKqrU0bmoY3WxnA
 eNd/h9fy1RK5qYVexwoQq9TTFYpa3iyPuanSKPeke16pniZJ7X30iZ+9C6peV2H4jiRt
 mbDA==
X-Gm-Message-State: APjAAAVR6wm5LWZ0b/rfwDEuNlfY0hLitklDl95cXKjH4ZpOyuvAC+p7
 UDzJlPPhbHMt58mSSU4fKQLJmplN754E0/kfN2oP7qCfYAC6xLcek0LZ/+GUaA3tRZKN7E2X4k1
 QqwNKCVwnPigj62bnmbTreeH8TpTebyZnDfM70MzKCIc+SFcd
X-Received: by 2002:a5d:9557:: with SMTP id a23mr7974822ios.165.1568843824006; 
 Wed, 18 Sep 2019 14:57:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzEBfp3GPIcqYPSPjZduHykqfK9X0OIEp250r5DBbLqley50LjmH/EHQDV2fFea5atu4kj6RZ1acMK2FDlTt8k=
X-Received: by 2002:a5d:9557:: with SMTP id a23mr7974791ios.165.1568843823671; 
 Wed, 18 Sep 2019 14:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190917172422.5134-1-dan.streetman@canonical.com>
 <87woe5z6mi.fsf@linaro.org>
In-Reply-To: <87woe5z6mi.fsf@linaro.org>
From: Dan Streetman <dan.streetman@canonical.com>
Date: Wed, 18 Sep 2019 17:56:27 -0400
Message-ID: <CAOZ2QJNgiB0ZoLAOUGjdFfWa+Hwkbqe=E+KQeOaUMEdvU0-ofw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
Subject: Re: [Qemu-devel] [PATCH] hw/arm: set machine 'virt' as default
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 18, 2019 at 4:34 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Dan Streetman <dan.streetman@canonical.com> writes:
>
> > From: Dan Streetman <ddstreet@canonical.com>
> >
> > There is currently no default machine type for arm so one must be speci=
fied
> > with --machine.  This sets the 'virt' machine type as default.
>
> We should really have a FAQ entry for why we don't have a default for
> ARM. In short unlike PC's every ARM device is different so it pays to be
> precise about what you want when you invoke QEMU. Because any given
> kernel/image is only likely to work on the machine it's built for.

well, that's the problem, I have no idea at all what I want; and "I"
doesn't really apply completely in this situation, as the call to run
qemu comes from deep inside a test suite, and can run on multiple
archs, and could even be run by other people on other systems/archs.

This is what I have (tentatively) come up with to handle this in the test s=
uite:
https://github.com/systemd/systemd/pull/13409/files#diff-2ea30ffea3b108e0f9=
c50846cfdcd4e5R197

To be fair, it's unlikely that other people would run this on an arm
system, unless they were a bit more familiar with arm, and maybe would
know what machine type to pick.  Similarly for the testbeds that I
handle for this test suite, I know that 'virt' seems to work.

>
> Why is virt special? It's just one of the many machines we emulate and
> while it's probably the most popular these days for "something that
> boots a Linux distro" why not -machine sba (when that comes)?

I am certainly not the right person to pick what the default should
be, but I do think there should be *some* default.  If 'virt' is the
most popular and/or has the widest kernel support, then it probably
makes sense to make that the default.

I would guess that users of qemu-system-aarch64 (or -arm) fall into 2 group=
s:

1. people who know about arm and know exactly what machine they want to use
2. people who don't know about arm and have no idea what machine to use

group #1 of course can still pick whatever machine they want.  I'm in
group #2, and I suspect that like most others in the group, I did:

$ qemu-system-aarch64 ...
qemu-system-aarch64: No machine specified, and there is no default
Use -machine help to list supported machines
$ qemu-system-aarch64 -M ?
...shows long list of machines that i'm unfamiliar with...
virt-2.10            QEMU 2.10 ARM Virtual Machine
virt-2.11            QEMU 2.11 ARM Virtual Machine
virt-2.12            QEMU 2.12 ARM Virtual Machine
virt-2.6             QEMU 2.6 ARM Virtual Machine
virt-2.7             QEMU 2.7 ARM Virtual Machine
virt-2.8             QEMU 2.8 ARM Virtual Machine
virt-2.9             QEMU 2.9 ARM Virtual Machine
virt-3.0             QEMU 3.0 ARM Virtual Machine
virt                 QEMU 3.1 ARM Virtual Machine (alias of virt-3.1)
virt-3.1             QEMU 3.1 ARM Virtual Machine

(aha! those "virt" machines look generic enough that they'll work...)
$ qemu-system-aarch64 -M virt ...

I honestly don't know if it would be better to have a FAQ on why there
is no default, or just to set a default.  Personally, I'd prefer just
having a default.

If you do decide against a default, I would suggest at least printing
the url to the FAQ entry on why arm doesn't have a default, instead of
just asking users to pick one out of the -M ? list.


>
> >
> > Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> > ---
> >  hw/arm/virt.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index d74538b021..e9fe888ca2 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -78,6 +78,7 @@
> >          mc->desc =3D "QEMU " # major "." # minor " ARM Virtual Machine=
"; \
> >          if (latest) { \
> >              mc->alias =3D "virt"; \
> > +            mc->is_default =3D 1; \
> >          } \
> >      } \
> >      static const TypeInfo machvirt_##major##_##minor##_info =3D { \
>
>
> --
> Alex Benn=C3=A9e
>

