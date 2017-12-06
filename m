Received: from eggs.gnu.org ([2001:4830:134:3::10]:37484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eMVu6-0008Ox-NN
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eMVu3-0002IO-IJ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:22:10 -0500
Received: from [45.249.212.255] (port=36729 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eMVu3-0002EI-6N
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:22:07 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 6 Dec 2017 09:21:55 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4CA201@DGGEMA505-MBS.china.huawei.com>
References: <20171205063313.GB4102@yangzhon-Virtual>
	<20171205120623.GB31150@stefanha-x1.localdomain>
	<5f9f2835-5811-3ee0-9049-0d2cddc08958@redhat.com>
	<CAJSP0QVn0Uq_XO-22cz1JzbgEaFfwwX9yXBk1eKKkMfknADFmQ@mail.gmail.com>
	<876e5376-d729-72d7-3c04-3c6f52b745de@redhat.com>
	<20171205163109.GC6712@stefanha-x1.localdomain>
In-Reply-To: <20171205163109.GC6712@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] About the light VM solution!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>


> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+arei.gonglei=3Dhuawei.com@nongnu.org] On
> Behalf Of Stefan Hajnoczi
> Sent: Wednesday, December 06, 2017 12:31 AM
> To: Paolo Bonzini
> Cc: Yang Zhong; Stefan Hajnoczi; qemu-devel
> Subject: Re: [Qemu-devel] About the light VM solution!
>=20
> On Tue, Dec 05, 2017 at 03:00:10PM +0100, Paolo Bonzini wrote:
> > On 05/12/2017 14:47, Stefan Hajnoczi wrote:
> > > On Tue, Dec 5, 2017 at 1:35 PM, Paolo Bonzini <pbonzini@redhat.com>
> wrote:
> > >> On 05/12/2017 13:06, Stefan Hajnoczi wrote:
> > >>> On Tue, Dec 05, 2017 at 02:33:13PM +0800, Yang Zhong wrote:
> > >>>> As you know, AWS has decided to switch to KVM in their clouds. Thi=
s
> news make almost all
> > >>>> china CSPs(clouds service provider) pay more attention on KVM/Qemu=
,
> especially light VM
> > >>>> solution.
> > >>>>
> > >>>> Below are intel solution for light VM, qemu-lite.
> > >>>>
> http://events.linuxfoundation.org/sites/events/files/slides/Light%20weigh=
t%2
> 0virtualization%20with%20QEMU%26KVM_0.pdf
> > >>>>
> > >>>> My question is whether community has some plan to implement light
> VM or alternative solutions? If no, whether our
> > >>>> qemu-lite solution is suitable for upstream again? Many thanks!
> > >>>
> > >>> What caused a lot of discussion and held back progress was the appr=
oach
> > >>> that was taken.  The basic philosophy seems to be bypassing or
> > >>> special-casing components in order to avoid slow operations.  This
> > >>> requires special QEMU, firmware, and/or guest kernel binaries and
> causes
> > >>> extra work for the management stack, distributions, and testers.
> > >>
> > >> I think having a special firmware (be it qboot or a special-purpose
> > >> SeaBIOS) is acceptable.
> > >
> > > The work Marc Mari Barcelo did in 2015 showed that SeaBIOS can boot
> > > guests quickly.  The guest kernel was entered in <35 milliseconds
> > > IIRC.  Why is special firmware necessary?
> >
> > I thought that wasn't the "conventional" SeaBIOS, but rather one with
> > reduced configuration options, but I may be remembering wrong.
>=20
> Marc didn't spend much time on optimizing SeaBIOS, he used the build
> options that were suggested.  An extra flag can be added in
> qemu_preinit() to skip slow init that's unnecessary on optimized
> machines.  That would allow a single SeaBIOS binary to run both full and
> lite systems.
>=20
What's options do you remember? Stefan. Or any links about that
thread? I'm Interesting with this topic.

Thanks,
-Gonglei
