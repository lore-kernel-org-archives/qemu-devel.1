Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F491C742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E0320863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E0320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlode-0000ez-L8
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 02:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hlodT-0000G9-7t
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hlodS-0008TH-8x
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hlodS-0008Sc-3a
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:02:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72EEF87621;
 Fri, 12 Jul 2019 06:02:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AA80600D1;
 Fri, 12 Jul 2019 06:02:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B35171138648; Fri, 12 Jul 2019 08:02:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <3c8b83fe-120b-40e6-84d5-5a3b88e46ee3@ilande.co.uk>
 <CAFEAcA9KjJUE7R0OYfM9AT=Ydu8eXBYJR=sGoGog25xrpRMZig@mail.gmail.com>
 <914f608a-5128-87a5-1c08-e20db88ad216@ilande.co.uk>
 <CAFEAcA9=KKtbR624rV77cu41zUTyu2N8-+1Gjmg-rQwdS1htuw@mail.gmail.com>
 <20190708094107.GD3082@redhat.com>
Date: Fri, 12 Jul 2019 08:02:18 +0200
In-Reply-To: <20190708094107.GD3082@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9=22's?=
 message of "Mon, 8 Jul 2019 10:41:07 +0100")
Message-ID: <87wognhjth.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 12 Jul 2019 06:02:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Parallel make build fails on fast machine
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Sat, Jul 06, 2019 at 09:35:30PM +0100, Peter Maydell wrote:
>> On Sat, 6 Jul 2019 at 11:28, Mark Cave-Ayland
>> <mark.cave-ayland@ilande.co.uk> wrote:
>> >
>> > On 06/07/2019 11:16, Peter Maydell wrote:
>> > > If you just do 'make' rather than 'make install' does it fail the sa=
me way?
>> >
>> > Interesting. A quick test shows that "make V=3D1 -j2" works fine, it's=
 just "make V=3D1
>> > -j2 install" which is failing.
>>=20
>> Mmm. I suspect most people just do the plain make (with the make install
>> phase either never or as a second command afterwards), so missing-depend=
ency
>> bugs between the install targets and the build targets are probably more
>> likely to lurk around. We should stil fix them, though, assuming we
>> can track them down...
>
> The main 'install' target depends on 'all':
>
> install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-loca=
lstatedir \
          $(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
          recurse-install
>
>
> but I think still allows 'install-doc', 'install-datadir' and
> 'install-localstatedir'  to parallelize wrt 'all'. I guess the fix is to
> make each of those 'install-xxx' targets depend on 'all' instead.

Additionally, recurse-install can run in parallel with all, which is
wrong.  I just posted "[PATCH for-4.1] Makefile: Fix "make install" when
"make all" needs work" for that.

