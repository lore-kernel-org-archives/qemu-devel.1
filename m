Received: from eggs.gnu.org ([2001:4830:134:3::10]:51598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cveEq-0005Nr-Lv
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 02:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cveEn-00062r-C0
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 02:16:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47854
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cveEn-00062i-6K
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 02:16:13 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v356E0cx070768
	for <qemu-devel@nongnu.org>; Wed, 5 Apr 2017 02:16:12 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29msknb7wd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 02:16:11 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 5 Apr 2017 02:16:11 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA21F688@DGGEMA505-MBS.china.huawei.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA21F457@DGGEMA505-MBS.china.huawei.com>
	<149136531491.1924.11146384618293052077@loki>
	<33183CC9F5247A488A2544077AF19020DA21F625@DGGEMA505-MBS.china.huawei.com>
	<149136966442.1924.13997608075876307088@loki>
	<33183CC9F5247A488A2544077AF19020DA21F688@DGGEMA505-MBS.china.huawei.com>
Date: Wed, 05 Apr 2017 01:16:04 -0500
Message-Id: <149137296462.1924.7432819972453249661@loki>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/81] Patch Round-up for
 stable 2.8.1, freeze on 2017-03-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

Quoting Gonglei (Arei) (2017-04-05 00:52:02)
> >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael Roth [mailto:mdroth@linux.vnet.ibm.com]
> > > > Sent: Wednesday, April 05, 2017 12:09 PM
> > > > To: Gonglei (Arei); qemu-devel@nongnu.org
> > > > Cc: qemu-stable@nongnu.org
> > > > Subject: RE: [Qemu-stable] [PATCH 00/81] Patch Round-up for stable =
2.8.1,
> > > > freeze on 2017-03-27
> > > >
> > > > Quoting Gonglei (Arei) (2017-04-04 21:01:54)
> > > > > Hi,
> > > > >
> > > > > I'd like to ask when QEMU 2.8.1 release? According to the previous
> > planning,
> > > > > It should release in Mar 30.
> > > >
> > > > It's already been released :)
> > > >
> > > >
> > https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg06332.html
> > > >
> > > Thanks for your feedback!
> > >
> > > I missed that mail :(   But why don't I find the v2.8.1 tag in QEMU t=
ree?
> > =

> > Where are you pulling from? From a repo I haven't updated recently:
> > =

> > mdroth@loki:~/w/qemu.git$ git remote get-url origin
> > git://git.qemu.org/qemu.git
> > mdroth@loki:~/w/qemu.git$ git fetch origin
> > remote: Counting objects: 3198, done.
> > remote: Compressing objects: 100% (1725/1725), done.
> > remote: Total 2502 (delta 1963), reused 962 (delta 772)
> > Receiving objects: 100% (2502/2502), 607.53 KiB | 791.00 KiB/s, done.
> > Resolving deltas: 100% (1963/1963), completed with 424 local objects.
> > From git://git.qemu.org/qemu
> >    b64842d..1fde6ee  master     -> origin/master
> >  * [new branch]      stable-2.8 -> origin/stable-2.8
> >  * [new tag]         v2.8.1     -> v2.8.1
> >  * [new tag]         v2.9.0-rc3 -> v2.9.0-rc3
> >  * [new tag]         v2.9.0-rc0 -> v2.9.0-rc0
> >  * [new tag]         v2.9.0-rc1 -> v2.9.0-rc1
> >  * [new tag]         v2.9.0-rc2 -> v2.9.0-rc2
> > ...
> > =

> > If you're pulling from the github mirror I do see that it hasn't been u=
pdated
> > yet with stable-2.8 branch or tag. That process was previously automated
> > AFAIK,
> > but maybe something has changed since the recent server switch-over. Wi=
ll
> > look
> > into it more tomorrow.
> > =

> Yes, I pull it from github mirror since the firewall of my firm.
> And I notice that the latest tag is v2.8.0, no v2.8.1 and v2.9.0-rcX:
> =

> linux-arei:/mnt/sdb/gonglei/qemu # git tag | tail
> v2.7.0-rc3
> v2.7.0-rc4
> v2.7.0-rc5
> v2.7.1
> v2.8.0
> v2.8.0-rc0
> v2.8.0-rc1
> v2.8.0-rc2
> v2.8.0-rc3
> v2.8.0-rc4

Thanks for confirming. I've pinged the admins about it, I'm sure it'll
get sorted out soon.

The tags might be missing on the github mirror, but the master branch seems
up to date at least. I've also pushed stable-2.8 branch and v2.8.1 to my
tree in case you need to grab them in the meantime:

  https://github.com/mdroth/qemu/releases/tag/v2.8.1

> =

> Thanks,
> -Gonglei
>=20
