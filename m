Received: from eggs.gnu.org ([209.51.188.92]:38469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1goBFg-0004ml-QE
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1goBFc-0001u8-S3
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:03:18 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1goBFc-0001mG-Ko
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:03:16 -0500
Received: by mail-ua1-f65.google.com with SMTP id t8so5937441uap.0
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
	<20190128153750.GE5756@localhost.localdomain>
	<20190128161257.GC3437@redhat.com>
In-Reply-To: <20190128161257.GC3437@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 28 Jan 2019 20:02:49 +0200
Message-ID: <CAMRbyyst4FU35HpdQ8kLuqD5Jzam=HmzcpauGnPDy1dHuNnphw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH] qmp: Deprecate query-nodes
 option of query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-block <qemu-block@nongnu.org>, libvir-list@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, Milan Zamazal <mzamazal@redhat.com>

On Mon, Jan 28, 2019 at 6:13 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Mon, Jan 28, 2019 at 04:37:50PM +0100, Kevin Wolf wrote:
> > Am 28.01.2019 um 16:15 hat Anton Kuchin geschrieben:
> > > This option is broken since a6baa60807 in v2.9 and returns mostly
> > > zeroes instead of real stats because actual querring of BlockStats
> > > that resides in blk is missing.
> > >
> > > And it makes no sense because with this option BlockDriverState-s
> > > are iterated but BlockAcctStats belong to BlockBackend and not BDS
> > > since 7f0e9da6f13 in v2.5
> > >
> > > Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
> >
> > Isn't query-nodes the only way to get wr_highest_offset for the protoco=
l
> > layer? oVirt depends on this, as far as I know.
>

We do, thanks for caring!

Libvirt just invokes 'query-blockstats' with no arguments, so is not
> relying on 'query-nodes' working. Given that libvirt doesn't use it,
> it doesn't seem like this is relevant for oVirt unless they were
> using QMP passthrough from libvirt.


We don't use QMP passthrough. We use only libvirt public APIs.

You can see what we use here:
https://github.com/oVirt/vdsm/blob/master/lib/vdsm/virt/drivemonitor.py

Nir



> That this has been broken
> since v2.9 though rather suggests oVirt doesn't use it.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
