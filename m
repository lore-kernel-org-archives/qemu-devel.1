Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A758C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F3D2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F3D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haiux-0007bV-Nk
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 11:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58326)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1haigG-0005y9-8L
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1haigC-0008HD-5b
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:27:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1haigB-00087v-VW
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:27:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B7883086226;
 Tue, 11 Jun 2019 15:27:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA625D704;
 Tue, 11 Jun 2019 15:27:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9398E1138648; Tue, 11 Jun 2019 17:26:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190607152646.4822-1-armbru@redhat.com>
 <CAFEAcA-2X2a_rNeg3Q4zmWgLDa=nfESMYR=rTE=+=1Mdsmw0kQ@mail.gmail.com>
Date: Tue, 11 Jun 2019 17:26:59 +0200
In-Reply-To: <CAFEAcA-2X2a_rNeg3Q4zmWgLDa=nfESMYR=rTE=+=1Mdsmw0kQ@mail.gmail.com>
 (Peter Maydell's message of "Mon, 10 Jun 2019 11:02:47 +0100")
Message-ID: <87a7eo16t8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 11 Jun 2019 15:27:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/12] Miscellaneous patches for 2019-06-07
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Jun 2019 at 19:21, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> The following changes since commit 0d74f3b4277a7ecb0ccb80c865797d11f8e46=
6f5:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull=
-request' into staging (2019-06-06 14:09:14 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-06-07
>>
>> for you to fetch changes up to 516741ebae8e2baef456c10897569725663157dd:
>>
>>   MAINTAINERS: Polish headline decorations (2019-06-07 16:30:59 +0200)
>>
>> ----------------------------------------------------------------
>> Miscellaneous patches for 2019-06-07
>>
>> ----------------------------------------------------------------
>> Markus Armbruster (11):
>>       qemu-common: Move tcg_enabled() etc. to sysemu/tcg.h
>>       qemu-common: Move qemu_isalnum() etc. to qemu/ctype.h
>>       Include qemu/module.h where needed, drop it from qemu-common.h
>>       Include qemu-common.h exactly where needed
>>       Normalize position of header guard
>>       scripts/clean-header-guards: Fix handling of trailing comments
>>       Clean up a few header guard symbols
>>       Supply missing header guards
>>       Clean up a header guard symbols (again)
>>       MAINTAINERS: Improve section headlines
>>       MAINTAINERS: Polish headline decorations
>>
>> Philippe Mathieu-Daud=C3=A9 (1):
>>       MAINTAINERS: Remove duplicate entries of qemu-devel@nongnu.org
>>
>
> Compile failure, I'm afraid, on OSX, NetBSD, FreeBSD and OpenBSD:
>
> /Users/pm215/src/qemu-for-merges/net/tap-bsd.c:68:9: error: implicit
> declaration of function 'TFR' is invalid in C99
> [-Werror,-Wimplicit-function-declaration]
>         TFR(fd =3D open(dname, O_RDWR));
>         ^
> /Users/pm215/src/qemu-for-merges/net/tap-bsd.c:68:9: error: this
> function declaration is not a prototype [-Werror,-Wstrict-prototypes]

Fortunately, this was the only one (I rustled up a cfarm machine to
check).  Unfortunately, I had to rebase to make it again mergable into
master.  Fresh pull request sent.  Thanks!

