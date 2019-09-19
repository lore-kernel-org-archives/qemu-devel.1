Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E53C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D53720578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2+nXNKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D53720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsqw-0000QJ-1c
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAspI-0007cN-Vx
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAspH-0006Wr-DV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:34:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAspG-0006WZ-Uk
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568885650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5dwYcTBkOPj+bSGejxMzGg5pIIImeWzH0jVxCFPvPh8=;
 b=f2+nXNKFs0suInqqjGd06XRan1WoCWw9m6M0bTeWoB78+LOULYHs2vE0LPvjat7aiFH7SH
 r43ueQ7q5kIFOPUn1N5CaqmcoVsCDqKVhvjoM+4TNFMg+ufHZw91+065QIT4NV9AlQAqMs
 z+rGR5CV0V9n/LpqbnVoFtORKeTi4KM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-eiMq9zsgM-ScfR_hfRRKLQ-1; Thu, 19 Sep 2019 05:34:09 -0400
Received: by mail-wr1-f69.google.com with SMTP id n18so800350wro.11
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 02:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n8JEz9fxOdZkaLKvjodEKMVK5kdAC1E1R+iijd76PA8=;
 b=kt6E1r3JWdt7BpE9sIRnV/yjyIbt05QhjnfAnsv5O8/YlMYF5BDi1wUooSUB4fumn3
 yBvscHBIsTUWO19jrzCcMGv3xryaTKE94BhoR7Ht53ZP8y0tthbu5J9ELhlVhLOW6Hd9
 dsq5j97FG4z7a7/PsO4X5KDn3xU89J/ra+4dxhro3igQKpOCgvC4pYzIB5GUSCML918t
 3rCjTirxnRv9q5yoip7umMK7CFMfKqQz6ToRIPqT+xHJc2By1K3abGh3r3jP5jZ552CP
 Xwcrwm6TKnGAcd+ozkw/3Zu4nkbh0yeerX2HvyrUCvs2/R5KCi1nNzPJxmV7NCibmI4E
 cVSw==
X-Gm-Message-State: APjAAAXMRgk6NKhEXIcUxdJDskTzDw9t8Qg89GrIFGCBTprsWVREl4Nr
 HonjedsAhdhdyJi9H3Fsa1aqD0v0ZEJ76Q0gkYcP6CwnAP0dAMiCK9bNis6CicfI+PTf1YAUCU1
 xjLYgRucqM3k5zVE=
X-Received: by 2002:a1c:a796:: with SMTP id q144mr2005743wme.15.1568885647508; 
 Thu, 19 Sep 2019 02:34:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw7HbUBsORa2tJTqx3dk6vyKvatf3AyfHlBKpgQxQTkdiAmU34bZeBxkt9EV4ahPbn6TrArRA==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr2005724wme.15.1568885647276; 
 Thu, 19 Sep 2019 02:34:07 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id q10sm16895703wrd.39.2019.09.19.02.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 02:34:06 -0700 (PDT)
To: Dan Streetman <dan.streetman@canonical.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190917172422.5134-1-dan.streetman@canonical.com>
 <87woe5z6mi.fsf@linaro.org>
 <CAOZ2QJNgiB0ZoLAOUGjdFfWa+Hwkbqe=E+KQeOaUMEdvU0-ofw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bb9bf110-1e5d-22e2-16d5-40a495c7ee84@redhat.com>
Date: Thu, 19 Sep 2019 11:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOZ2QJNgiB0ZoLAOUGjdFfWa+Hwkbqe=E+KQeOaUMEdvU0-ofw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: eiMq9zsgM-ScfR_hfRRKLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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

On 9/18/19 11:56 PM, Dan Streetman wrote:
> On Wed, Sep 18, 2019 at 4:34 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>> Dan Streetman <dan.streetman@canonical.com> writes:
>>
>>> From: Dan Streetman <ddstreet@canonical.com>
>>>
>>> There is currently no default machine type for arm so one must be speci=
fied
>>> with --machine.  This sets the 'virt' machine type as default.
>>
>> We should really have a FAQ entry for why we don't have a default for
>> ARM. In short unlike PC's every ARM device is different so it pays to be
>> precise about what you want when you invoke QEMU. Because any given
>> kernel/image is only likely to work on the machine it's built for.
>=20
> well, that's the problem, I have no idea at all what I want; and "I"
> doesn't really apply completely in this situation, as the call to run
> qemu comes from deep inside a test suite, and can run on multiple
> archs, and could even be run by other people on other systems/archs.
>=20
> This is what I have (tentatively) come up with to handle this in the test=
 suite:
> https://github.com/systemd/systemd/pull/13409/files#diff-2ea30ffea3b108e0=
f9c50846cfdcd4e5R197
>=20
> To be fair, it's unlikely that other people would run this on an arm
> system, unless they were a bit more familiar with arm, and maybe would
> know what machine type to pick.  Similarly for the testbeds that I
> handle for this test suite, I know that 'virt' seems to work.
>=20
>>
>> Why is virt special? It's just one of the many machines we emulate and
>> while it's probably the most popular these days for "something that
>> boots a Linux distro" why not -machine sba (when that comes)?

This was my first reaction too, why not use the SBSA machine as default?

> I am certainly not the right person to pick what the default should
> be, but I do think there should be *some* default.  If 'virt' is the
> most popular and/or has the widest kernel support, then it probably
> makes sense to make that the default.
>=20
> I would guess that users of qemu-system-aarch64 (or -arm) fall into 2 gro=
ups:
>=20
> 1. people who know about arm and know exactly what machine they want to u=
se
> 2. people who don't know about arm and have no idea what machine to use
>=20
> group #1 of course can still pick whatever machine they want.  I'm in
> group #2, and I suspect that like most others in the group, I did:
>=20
> $ qemu-system-aarch64 ...
> qemu-system-aarch64: No machine specified, and there is no default
> Use -machine help to list supported machines
> $ qemu-system-aarch64 -M ?
> ...shows long list of machines that i'm unfamiliar with...
> virt-2.10            QEMU 2.10 ARM Virtual Machine
> virt-2.11            QEMU 2.11 ARM Virtual Machine
> virt-2.12            QEMU 2.12 ARM Virtual Machine
> virt-2.6             QEMU 2.6 ARM Virtual Machine
> virt-2.7             QEMU 2.7 ARM Virtual Machine
> virt-2.8             QEMU 2.8 ARM Virtual Machine
> virt-2.9             QEMU 2.9 ARM Virtual Machine
> virt-3.0             QEMU 3.0 ARM Virtual Machine
> virt                 QEMU 3.1 ARM Virtual Machine (alias of virt-3.1)
> virt-3.1             QEMU 3.1 ARM Virtual Machine
>=20
> (aha! those "virt" machines look generic enough that they'll work...)
> $ qemu-system-aarch64 -M virt ...
>=20
> I honestly don't know if it would be better to have a FAQ on why there
> is no default, or just to set a default.  Personally, I'd prefer just
> having a default.
>=20
> If you do decide against a default, I would suggest at least printing
> the url to the FAQ entry on why arm doesn't have a default, instead of
> just asking users to pick one out of the -M ? list.

We can also go all the way around to educate users to use the -M flag,
by killing the 'default machine' on all targets.

Personally I also find the default ppc64 machine confusing.

On the X86 side there is a long discussion/debt about when to change the
default i440fx to q35, so having no default at all would fix this other
issue.

>>> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
>>> ---
>>>  hw/arm/virt.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index d74538b021..e9fe888ca2 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -78,6 +78,7 @@
>>>          mc->desc =3D "QEMU " # major "." # minor " ARM Virtual Machine=
"; \
>>>          if (latest) { \
>>>              mc->alias =3D "virt"; \
>>> +            mc->is_default =3D 1; \
>>>          } \
>>>      } \
>>>      static const TypeInfo machvirt_##major##_##minor##_info =3D { \
>>
>>
>> --
>> Alex Benn=C3=A9e
>>
>=20


