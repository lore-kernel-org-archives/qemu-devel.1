Received: from eggs.gnu.org ([2001:4830:134:3::10]:53993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiXr-0005F7-KH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOiXn-00026l-N4
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:48:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOiXn-00026U-IL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:48:31 -0400
Date: Fri, 1 Jun 2018 12:48:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601114826.GR3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-14-berrange@redhat.com>
	<871sdr1sx1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871sdr1sx1.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 13/14] travis: improve python version
 test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>

On Thu, May 31, 2018 at 09:17:30PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Daniel P. Berrange <berrange@redhat.com> writes:
>=20
> > Currently travis declares ancient python 2.4 is desired. Update that =
to
> > 2.6 which is the oldest version any targetted distros still needs. If=
 we
> > just list a python 3 version at the top level this will double the
> > number of travis jobs we run which is unreasonable.
> >
> > So arbitrarily pick the clang test matrix entries to build with pytho=
n
> > 3.0 and 3.6, to extend coverage of python versions, without increasin=
g
> > job count or build time.
>=20
> I'm sorry I didn't get to this when you posted it. However I'd like to
> know what the minimum build configuration we can get which will still
> ensure that the python is exercised? Would a
> TARGET_LIST=3D"x86-64-softmmu" be good enough?

Most important stuff to exercise is the QAPI code generator and the
trace tool backends, as those the main python pieces users will hit
during build. So yes, it is sufficient to just have 1 target arch


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
