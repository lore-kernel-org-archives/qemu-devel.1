Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D055C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD27822CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="efiDnadE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD27822CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C2b-0000YH-1P
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BqG-0001BE-9w
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BqE-0003Zb-4l
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:39:39 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:53602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i5BqD-0003Xo-Oi
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:39:38 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E5EC62E14E7;
 Tue,  3 Sep 2019 19:39:33 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 I8RybooL9R-dXq4PZXn; Tue, 03 Sep 2019 19:39:33 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1567528773; bh=2szCSgLlIWabVJKgtNdCtPaq6C+ksw4hrE1w0AcSqzA=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=efiDnadEh36UroyDWutgM3cPJavz7TG1oj8sQgiw5GWHxZD5azVKJUNOi7dKw1HGF
 ha7XjTbX6CddxidRnb5WIh2c/2a1cwbspuYb2zdCSNxefrSYwyvwMjTnsrdHM/V8+c
 0LffYQJOyyMy7p/dRLCq+ZykynrS2vGMnoSvvSEE=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net (localhost [::1])
 by mxbackcorp1g.mail.yandex.net with LMTP id LEfJgzei1Q-bWm1jA4X
 for <yury-kotov@yandex-team.ru>; Tue, 03 Sep 2019 19:39:23 +0300
Received: by iva5-c4dd0484b46b.qloud-c.yandex.net with HTTP;
 Tue, 03 Sep 2019 19:39:23 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>
In-Reply-To: <20190903112548.GF2744@work-vm>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-2-yury-kotov@yandex-team.ru>
 <fb324ab9-b7a2-d56e-a0d1-9f4ae86791ce@redhat.com>
 <1097381566920178@vla1-6bb9290e4d68.qloud-c.yandex.net>
 <ff0428a4-6600-7b41-e246-7858e58e5507@redhat.com>
 <20190903112548.GF2744@work-vm>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 03 Sep 2019 19:39:33 +0300
Message-Id: <2870661567528763@iva5-c4dd0484b46b.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Add x-validate-uuid
 capability
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.09.2019, 14:25, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Eric Blake (eblake@redhat.com) wrote:
>> =C2=A0On 8/27/19 10:36 AM, Yury Kotov wrote:
>> =C2=A0> 27.08.2019, 17:02, "Eric Blake" <eblake@redhat.com>:
>> =C2=A0>> On 8/27/19 7:02 AM, Yury Kotov wrote:
>> =C2=A0>>> =C2=A0This capability realizes simple source validation by U=
UID.
>> =C2=A0>>> =C2=A0It's useful for live migration between hosts.
>> =C2=A0>>>
>>
>> =C2=A0>>
>> =C2=A0>> Any reason why this is marked experimental? It seems useful e=
nough that
>> =C2=A0>> we could probably just add it as a fully-supported feature (d=
ropping the
>> =C2=A0>> x- prefix) - but I'll leave that up to the migration maintain=
ers.
>> =C2=A0>>
>> =C2=A0>
>> =C2=A0> I thought that all new capabilities have x- prefix... May be i=
t's really
>> =C2=A0> unnecessary here, I'm not sure.
>>
>> =C2=A0New features that need some testing or possible changes to behav=
ior need
>> =C2=A0x- to mark them as experimental, so we can make those changes wi=
thout
>> =C2=A0worrying about breaking back-compat. But new features that are o=
utright
>> =C2=A0useful and presumably in their final form, with no further
>> =C2=A0experimentation needed, can skip going through an x- phase.
>>
>> =C2=A0>
>> =C2=A0>> In fact, do we even need this to be a tunable feature? Why no=
t just
>> =C2=A0>> always enable it? As long as the UUID is sent in a way that n=
ew->old
>> =C2=A0>> doesn't break the old qemu from receiving the migration strea=
m, and that
>> =C2=A0>> old->new copes with UUID being absent, then new->new will alw=
ays benefit
>> =C2=A0>> from the additional safety check.
>> =C2=A0>>
>> =C2=A0>
>> =C2=A0> In such case we couldn't migrate from e.g. 4.2 to 3.1
>>
>> =C2=A0I don't know the migration format enough to know if there is a w=
ay for
>> =C2=A04.2 to unconditionally send a UUID as a subsection such that a r=
eceiving
>> =C2=A03.1 will ignore the unknown subsection. If so, then you don't ne=
ed a
>> =C2=A0knob; if not, then you need something to say whether sending the
>> =C2=A0subsection is safe (perhaps default on in new machine types, but=
 default
>> =C2=A0off for machine types that might still be migrated back to 3.1).=
 That's
>> =C2=A0where I'm hoping the migration experts will chime in.
>
> Right; the migration format can't ignore chunks of data; so it does nee=
d
> to know somehow; the choice is either a capability or wiring it to the
> machine type; my preference is to wire it to the machine type; the
> arguments are:
> =C2=A0=C2=A0=C2=A0=C2=A0a) Machine type
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Pro: libvirt doesn't need to =
do anything
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Con: It doesn't protect old m=
achine types
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
It's not really part of the guest state
>
> =C2=A0=C2=A0=C2=A0=C2=A0b) Capability
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Pro: Works on all machine typ=
es
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Con: Libvirt needs to enable =
it
>
> So, no strong preference but I think I prefer (a).

IIUC the (a) option requires to add a piece of code to every machine type=
.
This is much more complicated than adding a capability.
If you don't mind, I suggest to keep the current version.

>
> Dave
>
>> =C2=A0--
>> =C2=A0Eric Blake, Principal Software Engineer
>> =C2=A0Red Hat, Inc. +1-919-301-3226
>> =C2=A0Virtualization: qemu.org | libvirt.org
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury

