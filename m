Received: from eggs.gnu.org ([209.51.188.92]:46569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gz0m7-0003ii-VD
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gz0ll-0002m7-BS
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:05:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38236
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gz0lk-0002ec-Vk
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:05:13 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1RF0xdS008237
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 10:05:08 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qwva5261e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 10:05:07 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Wed, 27 Feb 2019 15:05:06 -0000
Date: Wed, 27 Feb 2019 12:04:49 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20190225162325.24008-1-maxiwell@linux.ibm.com>
	<20190225232009.GB30778@kermit.br.ibm.com>
	<20190226032103.GJ6872@umbus.fritz.box>
	<20190226142126.jxosththzad6h6dd@maxibm>
	<20190226170830.GA16569@kermit.br.ibm.com>
	<20190226191140.GA25467@kermit.br.ibm.com>
	<20190226231920.GS6872@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226231920.GS6872@umbus.fritz.box>
Message-Id: <20190227150449.GA9614@kermit.br.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org

Hi, David.

On Wed, Feb 27, 2019 at 10:19:20AM +1100, David Gibson wrote:
> On Tue, Feb 26, 2019 at 04:11:40PM -0300, Murilo Opsfelder Araujo wrote=
:
> > On Tue, Feb 26, 2019 at 02:08:30PM -0300, Murilo Opsfelder Araujo wro=
te:
> > > Hi, Maxiwell.
> > >
> > > On Tue, Feb 26, 2019 at 11:21:26AM -0300, Maxiwell S. Garcia wrote:
> > > > On Tue, Feb 26, 2019 at 02:21:03PM +1100, David Gibson wrote:
> > > > > On Mon, Feb 25, 2019 at 08:20:09PM -0300, Murilo Opsfelder Arau=
jo wrote:
> > > > > > Hi, Maxiwell.
> > > > > >
> > > > > > On Mon, Feb 25, 2019 at 01:23:25PM -0300, Maxiwell S. Garcia =
wrote:
> > > > > > > This adds a handler for ibm,get-vpd RTAS calls, allowing ps=
eries
> > > > > > > guest to collect host information. It is disabled by defaul=
t to
> > > > > > > avoid unwanted information leakage. To enable it, use:
> > > > > > > =E2=80=98-M pseries,vpd-export=3Don=E2=80=99
> > > > > >
> > > > > > The patch for setting host-serial and host-model already land=
ed Gibson's
> > > > > > ppc-for-4.0 branch:
> > > > > >
> > > > > >   commit 9e584f45868f6945c1282c938278038cba0e4af2
> > > > > >   Author: Prasad J Pandit <pjp@fedoraproject.org>
> > > > > >   Date:   Mon Feb 18 23:43:49 2019 +0530
> > > > > >
> > > > > >       ppc: add host-serial and host-model machine attributes =
(CVE-2019-8934)
> > > > > >
> > > > > >
> > > > > > QEMU should only return host-serial and host-model from the h=
ost if the
> > > > > > following combination of parameters are provided:
> > > > > >
> > > > > >   -M host-serial=3Dpassthrough,host-model=3Dpassthrough,vpd-e=
xport=3Don
> > > > > >
> > > > > > If host-serial or host-model are set with a user-string, ibm,=
get-vpd should
> > > > > > honor these values and return them, not exposing host informa=
tion by accident.
> > > > > >
> > > > > > I'm not even sure if we need vpd-export=3D<bool> setting. Its=
 logic could be
> > > > > > derived from the presence of host-serial=3Dpassthrough and ho=
st-model=3Dpassthrough
> > > > > > options.
> > > > > >
> > > > > > What do you think?
> > > > >
> > > > > That's an excellent point - I hadn't thought through the fact t=
hat
> > > > > this is the same information exposed by those properties.  I do=
 indeed
> > > > > think that exposing the same information set in those propertie=
s - and
> > > > > thereby avoiding the new machine option - would be a better pla=
n.
> > > > >
> > > >
> > > > I saw that the patch was applied. So I will work in another patch
> > > > to use these properties and remove the export-vpd option.
> > > >
> > > > Another thing that I thought the fact that 'host-serial' and 'hos=
t-model'
> > > > nodes in Device Tree are not in accordance with LoPAPR document. =
What
> > > > you think in use only get-vpd to get these information and remove
> > > > nodes from device tree?
> > >
> > > Both "system-id" and "model" properties are described in the sectio=
n "3.3.2.1
> > > Root Node Properties" of the "Device Tree Bindings: Linux on Power =
Architecture
> > > Reference" document:
> > >
> > >   https://members.openpowerfoundation.org/wg/SYSSW/document/1455
> >
> > I replied too early. As Maxiwell explained to me (thanks Max!), guest=
 can end up
> > having the following entries under /proc/device-tree/ (among other en=
tries):
> >
> >   $ cat host-serial
> >   12A3B4C
> >
> >   $ cat host-model
> >   1234-56A
> >
> >   $ cat system-id
> >   c7b62da9-3d0c-44f9-8edb-2318271f3c1a
> >
> >   $ cat model
> >   IBM pSeries (emulated by qemu)
> >
> > Where:
> >
> >   - host-serial/host-model: depend on "-M host-serial" and "-M host-m=
odel"
> >     machine options.
> >
> >   - system-id: created when "-uuid <val>" exists in qemu command line=
 options.
> >
> >   - model: hard-coded.
> >
> > With this patch, RTAS ibm,get-vpd call will return "system-id" and "m=
odel" from
> > the host, not from the guest. I found this confusing.
>
> Hrm.  I found the bit in LoPAPR describing how ibm,get-vpd operates,
> but not something describing the actual data that appears within it.
> Where's that described?  It'd be nice to check if those values are
> supposed to be describing the host or the guest.

Are you asking about the fields of the ibm,vpd property? They are describ=
ed in
Table 11.2 "LoPAPR VPD Fields" of this LoPAPR document:

  https://members.openpowerfoundation.org/wg/SYSSW/document/1461

Is that what you were looking for?

>
>
> > Perhaps we can trick ibm,get-vpd call to return "host-serial" and "ho=
st-model"
> > values from the guest, which will hold safe values after commit
> > 9e584f45868f6945c1282c938278038cba0e4af2 "ppc: add host-serial and ho=
st-model
> > machine attributes (CVE-2019-8934)".
>
> Well, if it is supposed to be host values, then yes, absolutely, we
> should be using the "host" values that the user supplies (if any).
>
> > What do you think?
> >
> > As to removing "host-serial" and "host-model", I am not entirely sure=
 for what
> > they are used. There should be a reason for them to exist.
> >
>
> --
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _oth=
er_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

--
Murilo
