Received: from eggs.gnu.org ([2001:4830:134:3::10]:46661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fco82-0005Cp-4B
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fco7y-0002Hx-9D
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:36:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fco7y-0002Hl-50
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:36:06 -0400
Date: Tue, 10 Jul 2018 16:36:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180710083602.GA5652@lemon.usersys.redhat.com>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-2-alex.bennee@linaro.org>
	<20180710065716.GK17581@lemon.usersys.redhat.com>
	<87601nedac.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87601nedac.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 01/10] tests/.gitignore: don't
 ignore docker tests
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

On Tue, 07/10 08:54, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > On Mon, 07/09 16:21, Alex Benn=E9e wrote:
> >> This was being a little over enthusiastic hiding files.
> >
> > What is "this" that hides test-* and calls for this patch?
>=20
> I thought that was implicit from the first line, this is the .gitignore=
.

Indeed you're right. Maybe that line should be more specific, but I have =
no
strong opinion.

Fam

>=20
> >
> >>
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> ---
> >>  tests/.gitignore | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/tests/.gitignore b/tests/.gitignore
> >> index 08e2df1ce1..72c18aaab0 100644
> >> --- a/tests/.gitignore
> >> +++ b/tests/.gitignore
> >> @@ -9,6 +9,7 @@ qht-bench
> >>  rcutorture
> >>  test-*
> >>  !test-*.c
> >> +!docker/test-*
> >>  test-qapi-commands.[ch]
> >>  test-qapi-events.[ch]
> >>  test-qapi-types.[ch]
> >> --
> >> 2.17.1
> >>
>=20
>=20
> --
> Alex Benn=E9e
