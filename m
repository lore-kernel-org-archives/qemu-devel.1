Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11583C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4DC206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="mLlQsYPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4DC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52063 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGjyf-0002qp-Vk
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 08:47:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hGjxH-0002Dc-Jv
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hGjxC-0001ex-Bv
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:46:23 -0400
Received: from forwardcorp1p.mail.yandex.net
	([2a02:6b8:0:1472:2741:0:8b6:217]:51712)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hGjxB-0001d7-Un
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:46:18 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E61492E0DF9;
	Wed, 17 Apr 2019 15:46:13 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	xV6ZUyKEr5-kDe0ExYm; Wed, 17 Apr 2019 15:46:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555505173; bh=FsQyFHs6zni8dLxGmZgMdYG9PAbSYfUfGqMJYe1Fp/U=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=mLlQsYPiEPnIzUH3JZyAJHoMYhJitqAw6ZvxJuax/XTTeMl/RvSBFO4D0MFR41vvc
	07dJyXENhAf8fyKUMKlyQ8QXhuW6ACrWKdeRaDaWpgQ7yu/uSJ67+K3t3sZcIw920q
	I5hUu0PUST396DhDE4+HkpTm5MuUV0+dk9IPFC1s=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net ([::1])
	by mxbackcorp1o.mail.yandex.net with LMTP id B4bDp2fk
	for <yury-kotov@yandex-team.ru>; Wed, 17 Apr 2019 15:46:08 +0300
Received: by vla1-9d3c37294942.qloud-c.yandex.net with HTTP;
	Wed, 17 Apr 2019 15:46:07 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <111121554372069@iva7-0f652523820f.qloud-c.yandex.net>
References: <156671554283778@vla1-1374b6242101.qloud-c.yandex.net>
	<20190404095212.GC2678@work-vm>
	<111121554372069@iva7-0f652523820f.qloud-c.yandex.net>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 17 Apr 2019 15:46:12 +0300
Message-Id: <880271555505167@vla1-9d3c37294942.qloud-c.yandex.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
Subject: Re: [Qemu-devel] [RFC PATCH] QEMU may write to system_memory before
 guest starts
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417124612.hrAVVmjEPo5iJJjOLnHJYpQ3IYZls3qfDg2jUHZeI7U@z>

Ping

04.04.2019, 13:01, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> I saw Catherine Ho's patch series and it seems ok to me, but in this RF=
C I asked
> about a way how to detect other writes which may not be covered by part=
icular
> fixes.
> Perhaps this is excessive caution...
>
> Regards,
> Yury
>
> 04.04.2019, 12:52, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
>> =C2=A0* =D0=AE=D1=80=D0=B8=D0=B9 =D0=9A=D0=BE=D1=82=D0=BE=D0=B2 (yury-=
kotov@yandex-team.ru) wrote:
>>> =C2=A0=C2=A0Ping
>>
>> =C2=A0Is this fixed by Catherine Ho's patch series?
>>
>> =C2=A0Dave
>>
>>> =C2=A0=C2=A021.03.2019, 19:27, "Yury Kotov" <yury-kotov@yandex-team.r=
u>:
>>> =C2=A0=C2=A0> Hi,
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> 19.03.2019, 14:52, "Dr. David Alan Gilbert" <dgilbert@r=
edhat.com>:
>>> =C2=A0=C2=A0>> =C2=A0* Peter Maydell (peter.maydell@linaro.org) wrote=
:
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0On Tue, 19 Mar 2019 at 11:03, Dr. David A=
lan Gilbert
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0<dgilbert@redhat.com> wrote:
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0> * Peter Maydell (peter.maydell@linaro.o=
rg) wrote:
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0> > I didn't think migration distinguishe=
d between "main memory"
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0> > and any other kind of RAMBlock-backed=
 memory ?
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0> In Yury's case there's a distinction be=
tween RAMBlock's that are mapped
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0> with RAM_SHARED (which normally ends up=
 as MAP_SHARED) and all others.
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0> You can set that for main memory by usi=
ng -numa to specify a memdev
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0> that's backed by a file and has the sha=
re=3Don property.
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0> On x86 the ROMs end up as separate RAMB=
lock's that aren't affected
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0> by that -numa/share=3Don - so they don'=
t fight Yury's trick.
>>> =C2=A0=C2=A0>>>
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0You can use the generic loader on x86 to =
load an ELF file
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0into RAM if you want, which would I think=
 also trigger this.
>>> =C2=A0=C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0OK, although that doesn't worry me too much - si=
nce in the majority
>>> =C2=A0=C2=A0>> =C2=A0of cases Yury's trick still works well.
>>> =C2=A0=C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0I wonder if there's a way to make Yury's code to=
 detect these cases
>>> =C2=A0=C2=A0>> =C2=A0and not allow the feature; the best thing for th=
e moment would seem to
>>> =C2=A0=C2=A0>> =C2=A0be to skip the aarch test that uses elf loading.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> Currently, I've no idea how to detect such cases, but t=
here is an ability to
>>> =C2=A0=C2=A0> detect memory corruption. I want to update the RFC patc=
h to let user to map some
>>> =C2=A0=C2=A0> memory regions as readonly until incoming migration sta=
rt.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> E.g.
>>> =C2=A0=C2=A0> 1) If x-ignore-shared is enabled in command line or mem=
ory region is marked
>>> =C2=A0=C2=A0> =C2=A0=C2=A0=C2=A0(something like ',readonly=3Don'),
>>> =C2=A0=C2=A0> 2) Memory region is shared (,share=3Don),
>>> =C2=A0=C2=A0> 3) And qemu is started with '-incoming' option
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> Then map such regions as readonly until incoming migrat=
ion finished.
>>> =C2=A0=C2=A0> Thus, the patch will be able to detect memory corruptio=
n and will not affect
>>> =C2=A0=C2=A0> normal cases.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> How do you think, is it needed?
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> I already have a cleaner version of the RFC patch, but =
I'm not sure about 1).
>>> =C2=A0=C2=A0> Which way is better: enable capability in command line,=
 add a new option for
>>> =C2=A0=C2=A0> memory-backend or something else.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0Dave
>>> =C2=A0=C2=A0>>
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0thanks
>>> =C2=A0=C2=A0>>> =C2=A0=C2=A0-- PMM
>>> =C2=A0=C2=A0>> =C2=A0--
>>> =C2=A0=C2=A0>> =C2=A0Dr. David Alan Gilbert / dgilbert@redhat.com / M=
anchester, UK
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> Regards,
>>> =C2=A0=C2=A0> Yury
>> =C2=A0--
>> =C2=A0Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

