Received: from eggs.gnu.org ([2001:4830:134:3::10]:47349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJvR7-0000LA-Cf
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJvR3-0004wN-FZ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:01:33 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2359 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eJvR3-0004vX-4L
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 01:01:29 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 29 Nov 2017 06:01:17 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4A8E65@DGGEMA505-MBS.china.huawei.com>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
	<33183CC9F5247A488A2544077AF19020DA4A8D0F@DGGEMA505-MBS.china.huawei.com>
	<20171129055545.GC2374@rkaganip.lan>
In-Reply-To: <20171129055545.GC2374@rkaganip.lan>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "rkagan@virtuozzo.com" <rkagan@virtuozzo.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, longpeng <longpeng2@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhaoshenglong <zhaoshenglong@huawei.com>



> -----Original Message-----
> From: rkagan@virtuozzo.com [mailto:rkagan@virtuozzo.com]
> Sent: Wednesday, November 29, 2017 1:56 PM
> To: Gonglei (Arei)
> Cc: Eduardo Habkost; Denis V. Lunev; longpeng; Michael S. Tsirkin; Denis
> Plotnikov; pbonzini@redhat.com; rth@twiddle.net; qemu-devel@nongnu.org;
> huangpeng; Zhaoshenglong
> Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by def=
ault
>=20
> On Wed, Nov 29, 2017 at 01:57:14AM +0000, Gonglei (Arei) wrote:
> > > On Tue, Nov 28, 2017 at 11:20:27PM +0300, Denis V. Lunev wrote:
> > > > On 11/28/2017 10:58 PM, Eduardo Habkost wrote:
> > > > > On Fri, Nov 24, 2017 at 04:26:50PM +0300, Denis Plotnikov wrote:
> > > > >> Commit 14c985cffa "target-i386: present virtual L3 cache info fo=
r
> vcpus"
> > > > >> introduced and set by default exposing l3 to the guest.
> > > > >>
> > > > >> The motivation behind it was that in the Linux scheduler, when w=
aking
> up
> > > > >> a task on a sibling CPU, the task was put onto the target CPU's
> runqueue
> > > > >> directly, without sending a reschedule IPI.  Reduction in the IP=
I count
> > > > >> led to performance gain.
> > > > >>
> >
> > Yes, that's one thing.
> >
> > The other reason for enabling L3 cache is the performance of accessing
> memory.
>=20
> I guess you're talking about the super-smart buffer size tuning glibc
> does in its memcpy and friends.  We try to control that with an atomic
> test for memcpy, and we didn't notice a difference.  We'll need to
> double-check...
>=20
> > We tested it by Stream benchmark, the performance is better with
> L3-cache=3Don.
>=20
> This one: https://www.cs.virginia.edu/stream/ ?  Thanks, we'll have a
> look, too.
>=20
Yes. :)

Thanks,
-Gonglei
