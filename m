Received: from eggs.gnu.org ([2001:4830:134:3::10]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fLskS-00008t-4d
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fLskN-0006nI-9h
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:05:52 -0400
Date: Thu, 24 May 2018 18:05:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180524180537.07bd8d80.cohuck@redhat.com>
In-Reply-To: <c22ba5bf-70f0-9769-c29b-099e44c0676f@linux.ibm.com>
References: <20180522221655.78979-1-pasic@linux.ibm.com>
	<20180522221655.78979-2-pasic@linux.ibm.com>
	<20180523113708.50b21a77.cohuck@redhat.com>
	<a3ab7dfd-4cc1-5632-1590-bce4a40f063e@linux.ibm.com>
	<20180523164640.225908a9.cohuck@redhat.com>
	<5de50b20-a331-78ea-a7f4-6fdd995ed083@linux.ibm.com>
	<20180523185957.41af37b2.cohuck@redhat.com>
	<d99ca544-de44-422f-8bcd-cc9b53fd047b@linux.ibm.com>
	<20180524091608.1c4e8b00.cohuck@redhat.com>
	<8bb3b068-15d3-cb3e-724d-ca7589750175@linux.ibm.com>
	<c22ba5bf-70f0-9769-c29b-099e44c0676f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 1/2] vfio-ccw: add force
 unlimited prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Thu, 24 May 2018 17:42:38 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/24/2018 12:29 PM, Halil Pasic wrote:
> >=20
> >=20
> > On 05/24/2018 09:16 AM, Cornelia Huck wrote: =20
> >> On Wed, 23 May 2018 19:28:31 +0200
> >> Halil Pasic <pasic@linux.ibm.com> wrote:
> >> =20
> >>> On 05/23/2018 06:59 PM, Cornelia Huck wrote: =20
> >>>> On Wed, 23 May 2018 18:23:44 +0200
> >>>> Halil Pasic <pasic@linux.ibm.com> wrote: =20
> >>>>> On 05/23/2018 04:46 PM, Cornelia Huck wrote: =20
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)=
) {
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(vcdev->force_=
orb_pfch)) {
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 warn_report("vfio-ccw requires PFCH flag set");
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sch_gen_unit_exception(sch);
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 css_inject_io_interrupt(sch);
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return IOINST_CC_EXPECTED;
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sch->orb.ctrl0 |=3D ORB_CTRL0_MASK_PFCH;
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 WARN_ONCE(vcdev->warned_force_orb_pfch, "PFCH flag forced"); =20
> >>>>>>>> This message should probably mention vfio-ccw as well as the sub=
channel
> >>>>>>>> id? =20
> >>>>>>> I was thinking about this. I think all it would make sense to hav=
e a common
> >>>>>>> prefix for all reports coming form vfio-ccw (QEMU). But then I wa=
s like, that
> >>>>>>> is a separate patch.
> >>>>>>>
> >>>>>>> Maybe something like:
> >>>>>>> vfio-ccw (xx.xx.xxxx): specific message
> >>>>>>>
> >>>>>>> OTOH we don't seem to do that elsewhere (git grep -e 'warn\|error=
_report\|error_setg' -- hw/s390x/).
> >>>>>>> AFAIR the error_setg captures context (like, src, line, func) but=
 does not
> >>>>>>> necessarily report it. Another question is if this should be exte=
nded to
> >>>>>>> hw/s390x/s390-ccw.c
> >>>>>>>
> >>>>>>> What do you think? =20
> >>>>>> I'm not sure that makes sense, especially as not everything might
> >>>>>> explicitly refer to a certain subchannel.
> >>>>>>
> >>>>>> Let's just add the subchannel id here? In this case, this is reall=
y a
> >>>>>> useful piece of information (which device is showing this behaviou=
r?) =20
>=20
> I'm doing the changes right now. And while doing it occurred to to me that
> a device number is probably preferable over the subchannel id, ie. cssid.=
ssid.devno
> is probably better that cssid.ssid.schid. What we really want to tell is,
> which device is affected and not over which subchannel is this device tal=
king.
>=20
> Agree, disagree?

A good argument can be made for both cases: While the admin may care
about the device, we work on the subchannel level. So choose whatever
you think makes most sense, but label it clearly :)
