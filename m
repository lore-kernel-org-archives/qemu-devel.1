Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD2FC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454D220815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="MCWWQNIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454D220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSd56-0001EA-KO
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 03:51:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hSd4F-0000uR-4O
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hSd4D-00032O-LA
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:50:43 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:56906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hSd4C-0002zK-Un
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:50:41 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::301])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 016B32E0DA9;
	Mon, 20 May 2019 10:50:35 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	Qw54XxU6E8-oY0SpnU4; Mon, 20 May 2019 10:50:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1558338634; bh=3+EKDGKBozVB+kAJuaZ6v1LpMVWaDUkhhOzRC5gCxno=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=MCWWQNIZkotYO4w4TA4DyvsEaVGFrAcJzNgElk85CRh9S5jG5LyOUPR/cCnxIOxE/
	agHRI7Z06a7V7TQ9FcXGc+o47T12XsG1D8NoiAuIaoFFD+FvCeaYdCV0ptNwZidWNV
	l6reQ4jeLmiyHkCsAtjT5m9kBFcGbkZYWz6io2dk=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net ([::1])
	by mxbackcorp1g.mail.yandex.net with LMTP id r1gqr4z1
	for <yury-kotov@yandex-team.ru>; Mon, 20 May 2019 10:50:24 +0300
Received: by iva6-8a76e93b6298.qloud-c.yandex.net with HTTP;
	Mon, 20 May 2019 10:50:23 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Eduardo Habkost <ehabkost@redhat.com>
In-Reply-To: <20190517182525.GM4189@habkost.net>
References: <156671554283778@vla1-1374b6242101.qloud-c.yandex.net>
	<20190404095212.GC2678@work-vm>
	<111121554372069@iva7-0f652523820f.qloud-c.yandex.net>
	<880271555505167@vla1-9d3c37294942.qloud-c.yandex.net>
	<460551557826929@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190517182525.GM4189@habkost.net>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 20 May 2019 10:50:33 +0300
Message-Id: <444881558338623@iva6-8a76e93b6298.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1619::183
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
	Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's to detect those cases in the future, yes.

17.05.2019, 21:25, "Eduardo Habkost" <ehabkost@redhat.com>:
> My memory is failing here: do we still need to fix a bug where
> there are unexpected writes to system_memory, or this is just a
> request to include a mechanism to help us detect those cases in
> the future?
>
> On Tue, May 14, 2019 at 12:42:14PM +0300, Yury Kotov wrote:
>> =C2=A0Ping ping
>>
>> =C2=A017.04.2019, 15:46, "Yury Kotov" <yury-kotov@yandex-team.ru>:
>> =C2=A0> Ping
>> =C2=A0>
>> =C2=A0> 04.04.2019, 13:01, "Yury Kotov" <yury-kotov@yandex-team.ru>:
>> =C2=A0>> =C2=A0I saw Catherine Ho's patch series and it seems ok to me=
, but in this RFC I asked
>> =C2=A0>> =C2=A0about a way how to detect other writes which may not be=
 covered by particular
>> =C2=A0>> =C2=A0fixes.
>> =C2=A0>> =C2=A0Perhaps this is excessive caution...
>> =C2=A0>>
>> =C2=A0>> =C2=A0Regards,
>> =C2=A0>> =C2=A0Yury
>> =C2=A0>>
>> =C2=A0>> =C2=A004.04.2019, 12:52, "Dr. David Alan Gilbert" <dgilbert@r=
edhat.com>:
>> =C2=A0>>> =C2=A0=C2=A0* =D0=AE=D1=80=D0=B8=D0=B9 =D0=9A=D0=BE=D1=82=D0=
=BE=D0=B2 (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0Ping
>> =C2=A0>>>
>> =C2=A0>>> =C2=A0=C2=A0Is this fixed by Catherine Ho's patch series?
>> =C2=A0>>>
>> =C2=A0>>> =C2=A0=C2=A0Dave
>> =C2=A0>>>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A021.03.2019, 19:27, "Yury Kotov" <yury-kot=
ov@yandex-team.ru>:
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> Hi,
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> 19.03.2019, 14:52, "Dr. David Alan Gilb=
ert" <dgilbert@redhat.com>:
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0* Peter Maydell (peter.maydell@l=
inaro.org) wrote:
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0On Tue, 19 Mar 2019 at 11=
:03, Dr. David Alan Gilbert
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0<dgilbert@redhat.com> wro=
te:
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0> * Peter Maydell (peter.=
maydell@linaro.org) wrote:
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0> > I didn't think migrat=
ion distinguished between "main memory"
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0> > and any other kind of=
 RAMBlock-backed memory ?
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0> In Yury's case there's =
a distinction between RAMBlock's that are mapped
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0> with RAM_SHARED (which =
normally ends up as MAP_SHARED) and all others.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0> You can set that for ma=
in memory by using -numa to specify a memdev
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0> that's backed by a file=
 and has the share=3Don property.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0> On x86 the ROMs end up =
as separate RAMBlock's that aren't affected
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0> by that -numa/share=3Do=
n - so they don't fight Yury's trick.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0You can use the generic l=
oader on x86 to load an ELF file
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0into RAM if you want, whi=
ch would I think also trigger this.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0OK, although that doesn't worry =
me too much - since in the majority
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0of cases Yury's trick still work=
s well.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0I wonder if there's a way to mak=
e Yury's code to detect these cases
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0and not allow the feature; the b=
est thing for the moment would seem to
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0be to skip the aarch test that u=
ses elf loading.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> Currently, I've no idea how to detect s=
uch cases, but there is an ability to
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> detect memory corruption. I want to upd=
ate the RFC patch to let user to map some
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> memory regions as readonly until incomi=
ng migration start.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> E.g.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> 1) If x-ignore-shared is enabled in com=
mand line or memory region is marked
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> =C2=A0=C2=A0=C2=A0(something like ',rea=
donly=3Don'),
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> 2) Memory region is shared (,share=3Don=
),
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> 3) And qemu is started with '-incoming'=
 option
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> Then map such regions as readonly until=
 incoming migration finished.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> Thus, the patch will be able to detect =
memory corruption and will not affect
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> normal cases.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> How do you think, is it needed?
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> I already have a cleaner version of the=
 RFC patch, but I'm not sure about 1).
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> Which way is better: enable capability =
in command line, add a new option for
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> memory-backend or something else.
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0Dave
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0thanks
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>>> =C2=A0=C2=A0-- PMM
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0--
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0Dr. David Alan Gilbert / dgilber=
t@redhat.com / Manchester, UK
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0>
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> Regards,
>> =C2=A0>>>> =C2=A0=C2=A0=C2=A0> Yury
>> =C2=A0>>> =C2=A0=C2=A0--
>> =C2=A0>>> =C2=A0=C2=A0Dr. David Alan Gilbert / dgilbert@redhat.com / M=
anchester, UK
>
> --
> Eduardo

Regards,
Yury

