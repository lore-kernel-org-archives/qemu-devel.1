Received: from eggs.gnu.org ([2001:4830:134:3::10]:53388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfvA-0004jP-4I
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfv5-0006XF-VD
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:21:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSfv5-0006Qr-My
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:21:11 -0500
Date: Fri, 30 Nov 2018 10:21:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130102106.GH8101@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
	<20181130095450.GC8101@redhat.com>
	<0070dd1f-eb02-53a9-ca20-a98a50cf0bce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0070dd1f-eb02-53a9-ca20-a98a50cf0bce@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] test: replace gtester with a
 TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Fri, Nov 30, 2018 at 10:56:01AM +0100, Paolo Bonzini wrote:
> On 30/11/18 10:54, Daniel P. Berrang=C3=A9 wrote:
> > FYI, for docs about the TAP protocol see:
> >=20
> >    https://testanything.org/tap-specification.html
> >=20
> > I've always liked the TAP protocol approach to test output where you =
print
> > an ok/not ok  status for each piece of the test, as opposed to assert=
ion
> > style tests where you just abort at the first piece that fails.=20
>=20
> FWIW, this is not what this series does.  Each ok/not ok line
> corresponds to one assertion-style test.

Oh sure, that's the way they've integrated it into the glib test APIs.
I just meant that in terms of the output format, I like its flexibility
in this manner.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
