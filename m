Received: from eggs.gnu.org ([209.51.188.92]:38637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gygDp-00045o-I5
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gygDm-0002E1-SM
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:08:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gygDl-00027T-Ds
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:08:45 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1QH0Kj5048337
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 12:08:38 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qw7sb7y8v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 12:08:37 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Tue, 26 Feb 2019 17:08:36 -0000
Date: Tue, 26 Feb 2019 14:08:30 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20190225162325.24008-1-maxiwell@linux.ibm.com>
	<20190225232009.GB30778@kermit.br.ibm.com>
	<20190226032103.GJ6872@umbus.fritz.box>
	<20190226142126.jxosththzad6h6dd@maxibm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226142126.jxosththzad6h6dd@maxibm>
Message-Id: <20190226170830.GA16569@kermit.br.ibm.com>
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
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, "open list:sPAPR" <qemu-ppc@nongnu.org>

Hi, Maxiwell.

On Tue, Feb 26, 2019 at 11:21:26AM -0300, Maxiwell S. Garcia wrote:
> On Tue, Feb 26, 2019 at 02:21:03PM +1100, David Gibson wrote:
> > On Mon, Feb 25, 2019 at 08:20:09PM -0300, Murilo Opsfelder Araujo wro=
te:
> > > Hi, Maxiwell.
> > >
> > > On Mon, Feb 25, 2019 at 01:23:25PM -0300, Maxiwell S. Garcia wrote:
> > > > This adds a handler for ibm,get-vpd RTAS calls, allowing pseries
> > > > guest to collect host information. It is disabled by default to
> > > > avoid unwanted information leakage. To enable it, use:
> > > > =E2=80=98-M pseries,vpd-export=3Don=E2=80=99
> > >
> > > The patch for setting host-serial and host-model already landed Gib=
son's
> > > ppc-for-4.0 branch:
> > >
> > >   commit 9e584f45868f6945c1282c938278038cba0e4af2
> > >   Author: Prasad J Pandit <pjp@fedoraproject.org>
> > >   Date:   Mon Feb 18 23:43:49 2019 +0530
> > >
> > >       ppc: add host-serial and host-model machine attributes (CVE-2=
019-8934)
> > >
> > >
> > > QEMU should only return host-serial and host-model from the host if=
 the
> > > following combination of parameters are provided:
> > >
> > >   -M host-serial=3Dpassthrough,host-model=3Dpassthrough,vpd-export=3D=
on
> > >
> > > If host-serial or host-model are set with a user-string, ibm,get-vp=
d should
> > > honor these values and return them, not exposing host information b=
y accident.
> > >
> > > I'm not even sure if we need vpd-export=3D<bool> setting. Its logic=
 could be
> > > derived from the presence of host-serial=3Dpassthrough and host-mod=
el=3Dpassthrough
> > > options.
> > >
> > > What do you think?
> >
> > That's an excellent point - I hadn't thought through the fact that
> > this is the same information exposed by those properties.  I do indee=
d
> > think that exposing the same information set in those properties - an=
d
> > thereby avoiding the new machine option - would be a better plan.
> >
>
> I saw that the patch was applied. So I will work in another patch
> to use these properties and remove the export-vpd option.
>
> Another thing that I thought the fact that 'host-serial' and 'host-mode=
l'
> nodes in Device Tree are not in accordance with LoPAPR document. What
> you think in use only get-vpd to get these information and remove
> nodes from device tree?

Both "system-id" and "model" properties are described in the section "3.3=
.2.1
Root Node Properties" of the "Device Tree Bindings: Linux on Power Archit=
ecture
Reference" document:

  https://members.openpowerfoundation.org/wg/SYSSW/document/1455

--
Murilo
