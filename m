Received: from eggs.gnu.org ([2001:4830:134:3::10]:58239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmjP-0000zn-Ss
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmjK-00066D-VC
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:06:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fcmjK-000662-Pa
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:06:34 -0400
Date: Tue, 10 Jul 2018 15:06:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180710070628.GN17581@lemon.usersys.redhat.com>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180709152117.21585-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 00/10] various docker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Mon, 07/09 16:21, Alex Benn=E9e wrote:
> Hi,
>=20
> The addition of the cross compilers for check-tcg broke the ability to
> run "make docker-test".  In truth this was probably already broken as
> it attempts to run every single test with every single docker image
> which isn't something that gets done on a regular basis.
>=20
> Anyway the patches clean up the ability to do that in a sane way
> although it still takes a long time to run the full test set.
>=20
> To help with running a better subset I've expanded the individual
> tests so you can now run a line like:
>=20
>   make docker-test-build TARGET_LIST=3Daarch64-softmmu J=3D30
>=20
> To make sure your favourite architecture still builds everywhere.
>=20
> There is now also a docker-test-unit which just runs the unit tests
> although we have to do a little re-factoring to make sure we don't
> attempt to run "make check" steps when the docker image isn't capable
> of it. This is also needed to make sure the other test-FOO build tests
> don't choke on the check step.
>=20
> Finally there is a minor tweak for .gitignore and a fix for docker.py
> throwing backtraces when we attempt to calculate SID_AGE. A cleaner
> re-factoring can be left for a future release.

Thanks for the clean ups!

Looks good in general. The only thing I notice is the test-unit script.

Fam
