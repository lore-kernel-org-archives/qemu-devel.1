Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97074C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311AB20868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311AB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZK39-0001yK-PU
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34566)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hZIkA-000792-SO
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hZIk9-0005hK-ME
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:33:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hZIk9-0005b2-Ct
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:33:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC7EE883BA;
 Fri,  7 Jun 2019 17:32:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E54F611AB;
 Fri,  7 Jun 2019 17:32:14 +0000 (UTC)
Date: Fri, 7 Jun 2019 18:32:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190607173211.GP28838@redhat.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
 <20190605142300.GB8956@redhat.com>
 <8736knnclp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8736knnclp.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 07 Jun 2019 17:33:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, James Hogan <jhogan@kernel.org>,
 Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 David Gibson <david@gibson.dropbear.id.au>, Laszlo Ersek <lersek@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Greg Kurz <groug@kaod.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Paul Durrant <paul.durrant@citrix.com>, Stafford Horne <shorne@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 07:52:50PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Tue, May 28, 2019 at 08:12:24PM +0200, Markus Armbruster wrote:
> >> We have a bunch of headers without multiple inclusion guards.  Some =
are
> >> clearly intentional, some look accidental.  Too many for me to find =
out
> >> by examining each of them, so I'm asking their maintainers.
> >>=20
> >> Why do I ask?  I'd like to mark the intentional ones and fix the
> >> accidental ones, so they don't flunk "make check-headers" from "[RFC=
 v4
> >> 0/7] Baby steps towards saner headers" just because they lack multip=
le
> >> inclusion guards.
> >>=20
> >> Just in case: what's a multiple inclusion guard?  It's
> >>=20
> >>     #ifndef UNIQUE_GUARD_SYMBOL_H
> >>     #define UNIQUE_GUARD_SYMBOL_H
> >>     ...
> >>     #endif
> >>=20
> >> with nothing but comments outside the conditional, so that the heade=
r
> >> can safely be included more than once.
> >
> > Any opinions on using the less verbose syntax instead:
> >
> >   #pragma once
> >
> > It is not portable C, but we explicitly only care about GCC or CLang,
> > so portability isn't an issue for us.
>=20
> I doubt its worth the churn.  But I'm content to go with the flow here.

Since the collective response was effectively "Meh", lets just
pretend i didn't raise this suggestion :-)


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

