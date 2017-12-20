Received: from eggs.gnu.org ([2001:4830:134:3::10]:42544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRhj6-00055M-I1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRhj5-0001YI-9g
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:00:16 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:49282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@weiser.dinsnail.net>)
	id 1eRhj4-0001XD-Vn
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:00:15 -0500
Date: Wed, 20 Dec 2017 16:51:14 +0100
From: Michael Weiser <michael.weiser@gmx.de>
Message-ID: <20171220155114.GD15475@weiser.dinsnail.net>
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-5-michael.weiser@gmx.de>
	<898e3dec-fa7d-1aed-e9d4-4c2557e0f45d@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898e3dec-fa7d-1aed-e9d4-4c2557e0f45d@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] configure: Add
 aarch64_be-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Hello Laurent,

On Wed, Dec 20, 2017 at 03:55:03PM +0100, Laurent Vivier wrote:

> > diff --git a/configure b/configure
> > index 9c8aa5a98b..03d95340d8 100755
> > --- a/configure
> > +++ b/configure
> > @@ -657,7 +657,7 @@ case "$cpu" in
> >      cpu="arm"
> >      supported_cpu="yes"
> >    ;;
> > -  aarch64)
> > +  aarch64|aarch64_be)
> >      cpu="aarch64"
> >      supported_cpu="yes"
> This switch is for host CPU. Do you want to add aarch64_be as a
> supported host architecture?

No, that's a project for another day, I guess and certainly doesn't
belong into that patch. Dropped.

> >    ;;
> > @@ -6345,7 +6345,7 @@ if test "$linux" = "yes" ; then
> >    s390x)
> >      linux_arch=s390
> >      ;;
> > -  aarch64)
> > +  aarch64|aarch64_be)
> >      linux_arch=arm64
> This is also for the host.

Same here.
-- 
Thanks,
Michael
