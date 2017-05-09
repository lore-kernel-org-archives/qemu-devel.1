Received: from eggs.gnu.org ([2001:4830:134:3::10]:45250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d84In-0000zJ-J8
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d84Ik-0001zz-Ey
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d84Ik-0001zZ-8n
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:31:38 -0400
Date: Tue, 9 May 2017 20:31:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170509123134.GC23466@lemon.lan>
References: <20170508221759.15616-1-f4bug@amsat.org>
	<20170508221759.15616-3-f4bug@amsat.org>
	<20170509040115.GA18973@lemon.lan>
	<666da677-0975-a6fa-0d39-07d1d3165e97@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <666da677-0975-a6fa-0d39-07d1d3165e97@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/21] docker: add --include-file
 argument to 'build' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, 05/09 09:14, Philippe Mathieu-Daud=E9 wrote:
> >=20
> > Is it more useful if it's '--include-files' that accepts multiple fil=
es? Or
> > alternatively allow this option to be use multiple times:
> >=20
> >     -f foo -f bar -f ...
>=20
> I agree, since I'm not confident with Python so I tried to touch as lit=
tle
> as possible.
>=20
> One iter I'm thinking about do a consistent rename with the
> "dockerfiles/%.docker -> docker.d/%/Dockerfile" pattern and adding git
> symlinks to required EXTRA_FILES in each dir, to avoid the call to dock=
er.py
> and be able to build/push images on hub.docker.com directly.

Originally I thought about "$QEMU/tests/docker/dockerfiles/$IMAGE/Dockerf=
ile"
but that sounded too fussy.

"$QEMU/tests/docker/docker.d/$IMAGE/Dockerfile" is a bit better.

But I'm not sure doing that can allow us to remove the necessity of docke=
r.py -
it does more such as calling .pre and passing in env vars etc..

Fam
