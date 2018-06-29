Received: from eggs.gnu.org ([2001:4830:134:3::10]:43853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrqd-00006d-LX
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrqa-0007yK-Hl
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:45:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYrqa-0007xR-D6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:45:52 -0400
Date: Fri, 29 Jun 2018 12:45:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629114547.GM27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625111935.26108-1-alex.bennee@linaro.org>
	<20180625111935.26108-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625111935.26108-7-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 06/10] travis: add gcovr summary for
 GCOV build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, famz@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Mon, Jun 25, 2018 at 12:19:31PM +0100, Alex Benn=C3=A9e wrote:
> This gives a more useful summary, sorted by descending % coverage,
> after the tests have run. The final numbers will give an idea if our
> coverage is getting better or worse.
>=20
> To keep the width sane we need to post process the file that the old
> gcovr tool generates. This is done with a mix of sed, awk and column
> in the scripts/coverage-summary.sh script.
>=20
> As quite a lot of lines don't get covered at all we filter out all the
> 0% lines. If the file doesn't appear it is not being exercised.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>   - pushed finagling into scripts/coverage-summary.sh
>     - dropped r-b as a big change
> ---
>  .travis.yml                 |  3 +++
>  scripts/coverage-summary.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100755 scripts/coverage-summary.sh

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
