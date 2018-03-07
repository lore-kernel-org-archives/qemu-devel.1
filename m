Received: from eggs.gnu.org ([2001:4830:134:3::10]:50028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etW9z-0006ue-7r
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etW9v-0007tb-7n
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:18:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etW9v-0007tR-3L
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:18:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36EB78182D16
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 10:18:51 +0000 (UTC)
Date: Wed, 7 Mar 2018 10:18:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307101837.GG20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180306154625.23910-1-berrange@redhat.com>
	<152035274652.1398.7213039081791775077@bdbb90650ae5>
	<20180306162247.GR6163@redhat.com>
	<20180307012430.GC13844@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307012430.GC13844@lemon.usersys.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] trace: only permit standard C types and
 fixed size integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, Mar 07, 2018 at 09:24:30AM +0800, Fam Zheng wrote:
> On Tue, 03/06 16:22, Daniel P. Berrang=C3=A9 wrote:
> > RFE for patchew...
> >=20
> > Now we're sending separate email alerts for each build job, can we
> > make patchew include the job name in the subject line, so it is
> > immediately obvious which job failed without needing to read the
> > body.
>=20
> Yes, doable. Do we still want the original subject (The "Re: ..." part)=
? If so,
> any idea what is a good format for the full subject line?

Perhaps take the original Subject, and prefix it. eg something like
this:

 Subject: s390-build failed (Re: [Qemu-devel] [PATCH] trace: only permit =
standard C types and...)


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
