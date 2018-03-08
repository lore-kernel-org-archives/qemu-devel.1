Received: from eggs.gnu.org ([2001:4830:134:3::10]:38234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etnpP-0001aT-Go
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 00:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etnpK-0006P5-79
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 00:10:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etnpK-0006Ol-1Q
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 00:10:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAD464072444
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 05:10:39 +0000 (UTC)
Date: Thu, 8 Mar 2018 13:10:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180308051027.GB32252@xz-mi>
References: <20180306053320.15401-1-peterx@redhat.com>
	<20180306053320.15401-10-peterx@redhat.com>
	<20180307123650.GD20201@redhat.com>
	<20180307124038.GE20201@redhat.com>
	<b0b86cba-7b55-0877-755a-7a3586807820@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0b86cba-7b55-0877-755a-7a3586807820@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 9/9] chardev: tcp: postpone TLS work
 until machine done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Mar 07, 2018 at 04:06:53PM +0100, Paolo Bonzini wrote:
> On 07/03/2018 13:40, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Mar 07, 2018 at 12:36:50PM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> >> On Tue, Mar 06, 2018 at 01:33:20PM +0800, Peter Xu wrote:
> >>> TLS handshake may create background GSource tasks, while we won't k=
now
> >>> the correct GMainContext until the whole chardev (including fronten=
d)
> >>> inited.  Let's postpone the initial TLS handshake until machine don=
e.
> >>>
> >>> For dynamically created tcp chardev, we don't postpone that by chec=
king
> >>> the init_machine_done variable.
> >>
> >> Not sure I see the need for this one - we've already postponed the
> >> acceptance of a client in the patch 7.
> >=20
> > Opps, meant to remove this comment, in favour of the later comment - =
ignore
> > this bit.
>=20
> Since time is ticking for soft freeze, I'll queue the series without
> this patch.

Thanks Paolo.

Note that Dan's pull is still not merged yet, and this series will
need that one.

I'll try to see whether I can prepare a good version for the last TLS
patch before you start to test your next pull request.

--=20
Peter Xu
