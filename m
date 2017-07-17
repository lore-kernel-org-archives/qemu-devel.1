Received: from eggs.gnu.org ([2001:4830:134:3::10]:50336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXF0F-0005gk-MX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXF0C-0007hy-LZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:00:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dXF0C-0007hJ-FF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:00:32 -0400
Date: Tue, 18 Jul 2017 07:00:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170717230025.GD2585@lemon>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 00/23] Current Travis Queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On Mon, 07/17 15:48, Alex Benn=E9e wrote:
> Hi,
>=20
> This is the current status of the travis/next patch queue. The
> includes updates from Paolo to allow parallelism while testing in the
> docker environment. I've extended the travis image so we can actually
> run our travis.py script in the Travis image.
>=20
> There are also a number of updates from Phillipe which add a bunch of
> additional cross compile targets to our shippable setup. The cachinfo
> patch is temporary and won't make the pull as it is already queued in
> Richard's tcg-next.
>=20
> I'm currently trying to catch one of our Travis hangs in the act
> (postcopy-test) but it seems to be very much a heavy load race
> condition which annoyingly stops happening once you try and get
> debugging tools on it. This is the reason I've updated the travis
> docker image to include the debug tools ;-)
>=20
> As long as there are no screams of outrage I'll roll a pullreq for
> softfreeze tomorrow.

Renaming of debian to debian9 seems backward incompatible. We don't care =
that
much, but I'd like to see a commit message justifying the change. Otherwi=
se it
looks good to go (minus the cachinfo patch, of course).

Fam
