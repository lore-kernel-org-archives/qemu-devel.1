Received: from eggs.gnu.org ([2001:4830:134:3::10]:45680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYxJi-0006Fd-Qj
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYxJf-0004yy-Jx
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYxJf-0004xa-9J
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D66C883BC
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 17:36:14 +0000 (UTC)
Date: Fri, 29 Jun 2018 14:36:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629173608.GP7451@localhost.localdomain>
References: <20180628154502.GO3513@redhat.com>
	<20180628195227.GH7451@localhost.localdomain>
	<20180629085353.GA5301@work-vm> <20180629101917.GC27016@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180629101917.GC27016@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] CPU model versioning separate from machine type
 versioning ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On Fri, Jun 29, 2018 at 11:19:17AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 29, 2018 at 09:53:53AM +0100, Dr. David Alan Gilbert wrote:
[...]
> > We're going to have to say something like:
> >   'For the new XYZ vulnerability make sure you're using
> >   Haswell-3.2 or later, SkyLake-2.6 or later, Westmere-4.8 or later
> >   .....'
> >=20
> > which all gets a bit confusing.
>=20
> The kernel has a /sys/devices/system/cpu/vulnerabilities dir
> that lists status of various flaws.
>=20
> I have been thinking about whether libvirt should create a
> 'virt-guest-validate' command that looks at guest XML and
> reports whether any of the config settings are vulnerable
> or otherwise diverging from best practice in some way.
>=20
> QEMU itself would perhaps have a 'query-vulnerabilities'
> monitor command to report whether the current config is
> satisfactory or not.

Makes sense to me.  I wanted to make QEMU emit warnings on
obviously insecure configurations.  Adding a
query-vulnerabilities command would be the QMP counterpart of
that.

--=20
Eduardo
