Received: from eggs.gnu.org ([209.51.188.92]:44958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grOJq-0004w4-3B
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grOJp-0004bb-7g
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:36:54 -0500
Date: Wed, 6 Feb 2019 15:36:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190206153639.61a5411c.cohuck@redhat.com>
In-Reply-To: <20190202005610.24048-3-crosa@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
	<20190202005610.24048-3-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/20] Acceptance tests: show avocado
 test execution by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>

On Fri,  1 Feb 2019 19:55:52 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> The current version of the "check-acceptance" target will only show
> one line for execution of all tests.  That's probably OK if the tests
> to be run are quick enough and they're always the same.
>=20
> But, there's already one test alone that takes on average ~5 seconds
> to run, we intend to adapt the list of tests to match the user's build
> environment (among other choices).

Btw: What are our expectations regarding execution time for tests?
Especially if we continue adding tests, and architecture-specific tests
are bound to be slower if run on a foreign architecture via tcg.

Would a make check-acceptance-quick command make sense? ("I only want
to verify quickly that I didn't break too much, so run the quicker
tests only, probably only for my host architecture")

>=20
> Because of that, let's present the default Avocado UI by default.
> Users can always choose a different output by setting the AVOCADO_SHOW
> variable.
>=20
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .travis.yml            | 2 +-
>  tests/Makefile.include | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
