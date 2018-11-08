Received: from eggs.gnu.org ([2001:4830:134:3::10]:48669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKnZj-0002bl-MV
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKnZi-0004as-Oz
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:54:35 -0500
Date: Thu, 8 Nov 2018 14:54:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181108165417.GL12503@habkost.net>
References: <20181106110548.4209-1-luc.michel@greensocs.com>
	<20181106110548.4209-2-luc.michel@greensocs.com>
	<28f0188a-e8fb-ad21-0c1d-9aaa5b81d261@redhat.com>
	<CAP+75-XPStesboG8yybAaknYHg0k6nxwsihJdEVeHJnOJHNKNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAP+75-XPStesboG8yybAaknYHg0k6nxwsihJdEVeHJnOJHNKNQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Luc Michel <luc.michel@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Nov 08, 2018 at 05:23:14PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On Thu, Nov 8, 2018 at 5:17 PM Philippe Mathieu-Daud=E9 <philmd@redhat.=
com> wrote:
> > On 6/11/18 12:05, Luc Michel wrote:
> > > This commit adds the cpu-cluster type. It aims at gathering CPUs fr=
om
> > > the same cluster in a machine.
> > >
> > > For now it only has a `cluster-id` property.
> > >
> > > Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >   include/hw/cpu/cluster.h | 38 ++++++++++++++++++++++++++
> > >   hw/cpu/cluster.c         | 59 +++++++++++++++++++++++++++++++++++=
+++++
>=20
> Eduardo are you OK to cover these files in your "Machine core"
> MAINTAINER's section?

Yes, no problem.

--=20
Eduardo
