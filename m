Received: from eggs.gnu.org ([2001:4830:134:3::10]:47968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2wXr-00085V-Sw
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2wXn-0008DH-U4
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e2wXn-0008Cz-Mq
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:46:15 -0400
Date: Fri, 13 Oct 2017 17:46:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171013094612.GC2756@lemon>
References: <20171013011954.9975-1-famz@redhat.com> <87mv4v9yrb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87mv4v9yrb.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Don't allocate tty unless DEBUG=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, 10/13 10:35, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > The existence of tty in the container seems to urge gcc into colorize
> > the output, but the escape chars will clutter the report once turned
> > into email replies on patchew. Move -t to debug mode.
> >
> > Reported-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> I certainly improves my Emacs compilation-mode buffer when applied:
>=20
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>

Nice, thanks! I'll send a pull request soon.

Fam
