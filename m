Received: from eggs.gnu.org ([2001:4830:134:3::10]:42703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8RTg-00025F-PG
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8RTe-0002tK-2G
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:21:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f8RTd-0002sK-Ur
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:20:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BE378DC30
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:20:57 +0000 (UTC)
Date: Tue, 17 Apr 2018 15:20:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180417142050.GG15421@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1520839658-20499-1-git-send-email-thuth@redhat.com>
	<2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
	<7413bf34-63ec-837d-d418-af2cfd1038d7@redhat.com>
	<87efjeaqd2.fsf@dusky.pond.sub.org>
	<20180417140540.GD15421@redhat.com>
	<21d78c43-a6d9-95d8-ff3e-f80a9ce6b0c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d78c43-a6d9-95d8-ff3e-f80a9ce6b0c0@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On Tue, Apr 17, 2018 at 04:14:02PM +0200, Paolo Bonzini wrote:
> On 17/04/2018 16:05, Daniel P. Berrang=C3=A9 wrote:
> >> For what it's worth, my "[RFC PATCH 00/32] Command line QAPIfication=
"
> >> replaces the original parsing art by getopt_long_only().
> >>
> >> Completing that work will take some time, but once it's done, we can
> >> (and I think we should) prefer double-dash for consistency.
> > Since our existing parser accepts single & double-dash already, is it
> > worth explicitly deprecating single-dash usage right now. So that whe=
n
> > your code comes along ready to merge, we're already able to say
> > "i told you so" and drop single-dash support at that same time.
>=20
> Serious questions: is _anyone_ of you actually using double-dash suppor=
t
> in daily invocations of QEMU?

I rarely invoke QEMU myself, usually just let libvirt do it. So mostly
i just using qemu-img/nbd/etc which expect double-dash. I didn't actually
know QEMU supported double-dash until a year or so ago.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
