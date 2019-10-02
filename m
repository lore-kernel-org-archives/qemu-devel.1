Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5D2C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE2221920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE2221920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFeQD-0004Wf-ST
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 09:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iFePW-000439-Ln
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iFePV-0006gf-6T
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:11:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52760)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iFePQ-0006aN-H1; Wed, 02 Oct 2019 09:11:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1186210C094F;
 Wed,  2 Oct 2019 13:11:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-20.ams2.redhat.com [10.36.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A172C60C18;
 Wed,  2 Oct 2019 13:11:02 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <30b22415-a46a-6810-4f9f-d108084cd7bb@redhat.com>
Date: Wed, 2 Oct 2019 15:11:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 02 Oct 2019 13:11:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2019 13.57, Max Reitz wrote:
> On 02.10.19 06:46, Thomas Huth wrote:
>> [...]
>> Max, I can understand that you are a little bit annoyed that this "mak=
e
>> check with iotests" caused some extra hurdles for you. But honestly,
>> removing that again would be quite egoistic by you. Try to put yoursel=
f
>> into the position of a "normal", non-blocklayer-maintainer QEMU
>> developer. For me, iotests were a *constant* source of frustration.
>> Often, when I ran them on top of my latest and greatest patches, to
>> check whether I caused a regression, the iotests simply failed. Then I
>> had to start debugging - did my patches cause the break, or is "master=
"
>> broken, too? In almost all cases, there was an issue in the master
>> branch already, either because they were failing on s390x, or because =
I
>> was using ext4 instead of xfs, or because I was using an older distro
>> than you, etc... . So while the iotests likely worked fine for the
>> limited set of systems that you, Kevin and the other hard-core block
>> layer developers are using, it's constantly broken for everybody else
>> who is not using the very same setup as you. The only way of *not*
>> getting upset about the iotests was to simply completely *ignore* them=
.
>> Is it that what you want?
>=20
> It usually worked fine for me because it=E2=80=99s rather rare that non=
-block
> patches broke the iotests.
>=20
> I have to admit I actually didn=E2=80=99t think of other people wanting=
 to run
> the iotests; but to be honest, your mail doesn=E2=80=99t sound like you=
 want to
> run the iotests either.

I *want* to run them. Occasionally - when I have new patches that might
affect anything related to the block layer. But then I don't want to be
in the situation where I first have to debug multiple other problems
with the iotests first that are not related to my new patches.

> (The reason I didn=E2=80=99t think of it is because non-block patches r=
arely
> break them, so I wouldn=E2=80=99t run the iotests if I were a non-block
> maintainer.  Sorry.)

Well, "rarely" is relative. They've been broken *completely* two times
in the 4.1 development time frame, and IIRC at least once in the 4.0
time frame.

[...]
> Maybe my main problem is that I feel like now I have to deal with all o=
f
> the fallout, even though adding the iotests to make check wasn=E2=80=99=
t my idea
> and neither me nor Kevin ever consented.  (I don=E2=80=99t know whether=
 Kevin
> consented implicitly, but I don=E2=80=99t see his name in bdd95e47844f2=
d8b.)
>=20
> You can=E2=80=99t just give me more responsibility without my consent a=
nd then
> call me egoistic for not liking it.

Ok, sorry for that. I guess one part of my frustration was also that the
patches to enable the iotests during "make check" have been on the list
for weeks - or rather months - and I never ever got much feedback from
you or Kevin on them. If you told me right in the beginning about your
concerns, we would not be at this point now. Also partly my bad, I
guess, since I could have reached out to you on IRC to discuss it, but
at that point in time, I rather thought that you just don't really care.
Thus it's good to have some conversation now, helps a lot to understand
the different expectations. Maybe we can also have a discussion about
this at KVM forum, I think it's easier to clarify some points of view
verbally there instead of using mails.

>> Or maybe let me phrase it differently: Do you consider the iotests as
>> something that is more or less "private" to the hard-core block layer
>> developers, and it's ok if others completely ignore them and break the=
m
>> by accident (and you also don't expect the normal developers to fix th=
e
>> iotests afterwards)?
>=20
> Well, that=E2=80=99s how it=E2=80=99s always worked, and that didn=E2=80=
=99t frustrate me.

Ok ... you're the maintainer, so if that's really the way you prefer, I
can send a patch to remove the iotests from "make check" again.

> Honestly, it looks to me like you don=E2=80=99t even want to run the io=
tests.  I
> interpret most of what you=E2=80=99ve written as:
>=20
> - I don=E2=80=99t want to not run the iotests, because then people will=
 hit me
>   for making them fail.
>=20
> - But they fail all the time, so I always need a baseline for what is
>   expected to sometimes fail and what isn=E2=80=99t.  That=E2=80=99s ve=
ry annoying.
>   Let=E2=80=99s introduce a baseline in the form of auto/qcow2, and the=
n let
>   everyone verify that it works.
>=20
> So to me it looks like we=E2=80=99ve just added all tests that never fa=
il to
> auto.  But if they never fail, then it=E2=80=99s like we haven=E2=80=99=
t run the tests
> at all.

I disagree. First, the complete iotest failures that have been merged
during the 4.1 development time frame to the master branch would have
been prevented, I think, so it's certainly not that "they never fail".

Second, yes, the basic idea was to start with a small set of tests in
the auto group which was already working, and then to increase that set
over time, once other tests run more stable, too. But you know the
iotests better than me, if you think that most of them can hardly
brought into the right shape, then this was likely just wishful thinking
by me.

> You have to decide: Either let me deal with the problems, but then I
> have every right to be egoistic about it =E2=80=93 or you help me deal =
with them.

Since I'm not assigned to the block layer, I could only help
occasionally, so that's likely not enough for solving your frustration.
Thus I'll send a patch to remove the iotests from "make check" again.

 Thomas

