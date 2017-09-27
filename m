Received: from eggs.gnu.org ([2001:4830:134:3::10]:54334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dx5B9-0007PC-8N
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dx5B4-0003XE-N5
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dx5B4-0003WT-HN
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:46:34 -0400
Date: Wed, 27 Sep 2017 13:46:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170927054630.GA9292@lemon.lan>
References: <20170926133622.14991-1-alex.bennee@linaro.org>
	<d907bbdd-ee5c-7c6d-b89d-a07a97c8bbc6@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d907bbdd-ee5c-7c6d-b89d-a07a97c8bbc6@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests/docker/run: don't source
 /etc/profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Tue, 09/26 13:17, Philippe Mathieu-Daud=E9 wrote:
> On 09/26/2017 10:36 AM, Alex Benn=E9e wrote:
> > The usual behaviour of /etc/profile is to set the default PATH for
> > users. This runs into problems when we have updated PATH in our
> > dockerfile e.g. to access a cross-compiler in a non-standard
> > location. It shouldn't be needed anyway as we inherit the env from th=
e
> > image when it was setup.
> >=20
> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Queued, thanks.

Fam
