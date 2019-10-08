Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC2C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173A82070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173A82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHu6r-0007qI-8t
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 14:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHu4z-0006iI-F6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHu4v-0006NO-Ve
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHu4v-0006Ll-P6; Tue, 08 Oct 2019 14:19:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FBBDA44ADC;
 Tue,  8 Oct 2019 18:19:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA73B19C7F;
 Tue,  8 Oct 2019 18:19:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A1811138648; Tue,  8 Oct 2019 20:19:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2] Makefile: Remove generated files when doing
 'distclean' (and 'clean')
References: <20191008082815.8267-1-thuth@redhat.com>
 <CAL1e-=gYkhM99Ee0LxZJ5dCjeEdC08G4_Tm3WCZpCSWvJ=b26Q@mail.gmail.com>
 <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
 <20191008124113.GE1192@redhat.com>
Date: Tue, 08 Oct 2019 20:19:13 +0200
In-Reply-To: <20191008124113.GE1192@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9=22's?=
 message of "Tue, 8 Oct 2019 13:41:13 +0100")
Message-ID: <8736g3drry.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 08 Oct 2019 18:19:20 +0000 (UTC)
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Given that we're aiming to convert to meson, how much effort do we really
> want to put into fixing this inconsistency ?
>
> I'd argue the best way to fix "clean" and "distclean" is to delete them
> entirely. Instead enforce that builddir !=3D srcdir when running configur=
e,
> so cleaning up simply means deleting the builddir sub-tree entirely.

I don't wish to belittle anybody's efforts at improving make targets
clean and distclean, but like Daniel, I've long given up on them[*].  My
"make distclean" is "rm -rf BUILD-DIR", and my "make clean" is "nuke-bld
BUILD-DIR", where nuke-bld is the script below.

#!/bin/sh -e

if [ $# -gt 1 ]
then
    echo "Usage: $0 [bld-dir]" >&2
    exit 1
fi

[ $# -eq 1 ] && cd "$1"

if [ ! -e config.status ]
then
    echo "$0: not a build tree" >&2
    exit 1
fi

rm -f .config.status
mv config.status .config.status
rm -r *
mv .config.status config.status
./config.status


[*] Along with .gitignore.

