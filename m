Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E76C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC41206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC41206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYmX-0003BT-6i
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:28:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYie-00006U-MH
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYid-00038a-DR
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:24:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYYid-00036r-4k
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:24:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 817AD30821C2;
	Wed,  5 Jun 2019 16:24:30 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 13A155D9D6;
	Wed,  5 Jun 2019 16:23:50 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:23:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190605162348.GN8956@redhat.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<20190605142300.GB8956@redhat.com>
	<a6739318-7837-6273-7afa-b19f941ee8aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6739318-7837-6273-7afa-b19f941ee8aa@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 05 Jun 2019 16:24:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 06:18:38PM +0200, Laszlo Ersek wrote:
> On 06/05/19 16:23, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, May 28, 2019 at 08:12:24PM +0200, Markus Armbruster wrote:
> >> We have a bunch of headers without multiple inclusion guards.  Some =
are
> >> clearly intentional, some look accidental.  Too many for me to find =
out
> >> by examining each of them, so I'm asking their maintainers.
> >>
> >> Why do I ask?  I'd like to mark the intentional ones and fix the
> >> accidental ones, so they don't flunk "make check-headers" from "[RFC=
 v4
> >> 0/7] Baby steps towards saner headers" just because they lack multip=
le
> >> inclusion guards.
> >>
> >> Just in case: what's a multiple inclusion guard?  It's
> >>
> >>     #ifndef UNIQUE_GUARD_SYMBOL_H
> >>     #define UNIQUE_GUARD_SYMBOL_H
> >>     ...
> >>     #endif
> >>
> >> with nothing but comments outside the conditional, so that the heade=
r
> >> can safely be included more than once.
> >=20
> > Any opinions on using the less verbose syntax instead:
> >=20
> >   #pragma once
> >=20
> > It is not portable C, but we explicitly only care about GCC or CLang,
> > so portability isn't an issue for us.
>=20
> I don't feel strongly about this particular question, so if folks prefe=
r
> "#pragma once", I won't complain. I'd just like to report that section =
6
> of "HACKING" appears the opposite of "we explicitly only care about GCC
> or CLang".

Heh, yeah that doc does require some updating, as we certainly don't
require conformance to the vanilla C standard any more.  We now explicitl=
y
request "-std=3Dgnu99" as the conformance level which allows many GNU
extensions to the standard.

commit 7be41675f7cb16be7c8d2554add7a63fa43781a8
Author: Thomas Huth <thuth@redhat.com>
Date:   Mon Jan 7 11:25:22 2019 +0100

    configure: Force the C standard to gnu99
   =20
    Different versions of GCC and Clang use different versions of the C s=
tandard.
    This repeatedly caused problems already, e.g. with duplicated typedef=
s:
   =20
     https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
   =20
    or with for-loop variable initializers:
   =20
     https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
   =20
    To avoid these problems, we should enforce the C language version to =
the
    same level for all compilers. Since our minimum compiler versions is
    GCC v4.8, our best option is "gnu99" for C code right now ("gnu17" is=
 not
    available there yet, and "gnu11" is marked as "experimental"), and "g=
nu++98"
    for the few C++ code that we have in the repository.


The HACKING docs predate this commit, and when reviewing, we failed to
notice we needed to update HACKING to match our new policy.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

