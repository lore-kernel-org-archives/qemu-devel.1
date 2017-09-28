Received: from eggs.gnu.org ([2001:4830:134:3::10]:58646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxSxK-0005RX-4d
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxSxG-0001LY-2L
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:09:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxSxF-0001JB-Si
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:09:53 -0400
Date: Thu, 28 Sep 2017 15:09:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170928070949.GA26066@lemon.lan>
References: <20170925075458.18047-1-famz@redhat.com>
	<CAAdtpL5j_9qh2bmzpmx3ULgCFr8TkMF4AgUZF=7Ka66=3diD3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAAdtpL5j_9qh2bmzpmx3ULgCFr8TkMF4AgUZF=7Ka66=3diD3A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Don't mount ccache db if NOUSER=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, 09/27 23:07, Philippe Mathieu-Daud=E9 wrote:
> On Mon, Sep 25, 2017 at 4:54 AM, Fam Zheng <famz@redhat.com> wrote:
> > With NOUSER=3D1 the container runs code as root, which may create
> > privileged files that will not be be accssible next time. Skip ccache
> > dir mount in this case.
> >
> > Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> Acked-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Queued, thanks.

Fam
