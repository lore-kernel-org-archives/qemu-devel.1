Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35225C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE61206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE61206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoEd-0002Ky-6T
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHoDk-0001ta-Ky
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHoDj-0004ji-Ag
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:04:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iHoDj-0004jL-1M
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:04:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAE948665A;
 Tue,  8 Oct 2019 12:04:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C827860605;
 Tue,  8 Oct 2019 12:03:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B92901138648; Tue,  8 Oct 2019 13:57:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] netmap: support git-submodule build otption
References: <874l13qmvb.fsf@dusky.pond.sub.org>
 <20191004130242.27267-1-g.lettieri@iet.unipi.it>
 <CAFEAcA8ut__ruS4yEMT7-qCKu+BFihFwhaNoq7L1cdoqxpXx6g@mail.gmail.com>
 <87pnj8ltih.fsf@dusky.pond.sub.org>
 <CAFEAcA9KLDruPS6o85H5XJnQjoSXV2+-d=dnNGPvc80jiBthiQ@mail.gmail.com>
 <87zhicg2ce.fsf@dusky.pond.sub.org>
 <CAFEAcA9ydS1LR+dW+mT9gCPrevov_U9jKKrEKu2De_OTWeCETg@mail.gmail.com>
 <20191008091715.GC1192@redhat.com>
Date: Tue, 08 Oct 2019 13:57:07 +0200
In-Reply-To: <20191008091715.GC1192@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9=22's?=
 message of "Tue, 8 Oct 2019 10:17:15 +0100")
Message-ID: <875zkzlab0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 08 Oct 2019 12:04:02 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Oct 07, 2019 at 01:39:30PM +0100, Peter Maydell wrote:
>> On Mon, 7 Oct 2019 at 13:36, Markus Armbruster <armbru@redhat.com> wrote:
>> > If CI of QEMU code isn't useful, then I suspect the QEMU code isn't
>> > useful, period.  Giuseppe assures us the netmap QEMU code *is* useful.
>> > It followe we better make sure our CI covers it.
>>=20
>> It would be an interesting idea to have a requirement that
>> any new library dependency can't be introduced into QEMU
>> unless one of the systems we do builds on can be set up
>> so the new code is compiled...
>
> Being able to at least compile code successfully is a pretty low bar
> to cross in terms of CI, so I think that's reasonable in general.
>
> I would not stop in terms of libraries though. We should document our
> broader expectations for CI
>
> Compilation
>
>  - All new code must be compiled in one of[1] our CI systems.

I think we should hold old code to the same standard.  Anything that's
not compiled now either gets fixed or deprecated.  If it's still unfixed
at the end of the deprecation grace period, it goes.

>    This implies
>
>     - Libraries must be available in some OS we compile for

How do we track compliance?  It's not obvious to (ignorant) me what
features exactly each CI compile enables.  Without that, it's not
obvious whether any CI run enables use of a certain library.

>     - New host architectures must have cross compilers available

Native tool chain in CI also satisfies "must be compiled in CI".

>     - New OS distro targets must have VM test image support

Non-virtual host in CI also satisfies "must be compiled in CI".

> This is not far off what we unofficially expect already, so
> it shouldn't be too distruptive if we formally adopt it as a
> mandatory rule.

Feels like a no-brainer, to be honest.

> Testing
>
>  - All significant new features should have either unit or
>    functional or integration test coverage
>
>  ... something something something ...

Spot the weasel words!  ;-P

> We've not really set any expectations around CI beyond compile
> testing thus far. We've got a mix of unit testing & functional
> testing in the tests/ dir. We're increasingly getting stuff
> added there when major features are added. Making this mandatory
> is probably too large a step, but it is likely helpful if we
> at least set some recommendations / guidelines to push people
> in the direction we want to go longer term.

We've been pushing, but not evenly.  It's basically up to maintainers,
and their expectations on testing vary.

> Regards,
> Daniel
>
> [1] Having to say "one of" is not especially great. It would be very nice
>     to get to the point where we have either container images or VM images
>     and no matter what CI harness(es) we use, they always run with either
>     a container or VM image[2]. Even if we have bare metal machines avail=
able
>     we can still execute actual builds inside containers or VM images so
>     everyone uses a consistent environment for everything related to CI.
>
> [2] macOS is a problem/exception here given that we can't legally distrib=
ute
>     VM images, nor can we provide a cross compiler toolchain. For everyth=
ing
>     else we can make VM/container images though.

That makes Macs a secondary host at best.  If it breaks, it breaks.  If
somebody fixes it, nice, if not, *shrug*.  Don't expect git-bisect to
work.

