Received: from eggs.gnu.org ([2001:4830:134:3::10]:50070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evQz3-000359-4L
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evQz0-0001Hi-E2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:11:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1evQz0-0001HD-A2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:11:34 -0400
Date: Tue, 13 Mar 2018 01:11:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180312171122.GC8326@lemon.usersys.redhat.com>
References: <20180312120849.20073-1-marcandre.lureau@redhat.com>
	<CAJ+F1CJM2mk8BKUm=kkKwTJJSjqNT7Hd0pdLM_=ZTMzxnb6FHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJM2mk8BKUm=kkKwTJJSjqNT7Hd0pdLM_=ZTMzxnb6FHw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: make docker-test-debug@fedora run
 sanitizers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Mon, 03/12 15:11, Marc-Andr=E9 Lureau wrote:
> Hi Fam,
>=20
> It would be great if patchew could run the debug/sanitizer build.
> Unfortunately, except x86 target, the run is full of ASAN leaks or
> warnings.
>=20
> Do you think patchew could learn to do regression testing? By that I
> mean that patchew could compare a patchset output with the current
> master (that output should be cached for multiple tests). The output
> to compare here would be the errors reported by ASAN during the build.
> (eventually, this could be used for other metrics some day). If so,
> would you be willing to help me implementing it?

The question is can we simply rely on the exit code of cmp or diff for th=
at kind
of comparison? If there is any out-of-order texts, that simple diff won't=
 work.

Anything more intelligent/sensible should go as a policy, and patchew sho=
uld
continue focus on mechanisms.

I'll send a pull for the patch. Thanks!

Thanks.
