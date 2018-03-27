Received: from eggs.gnu.org ([2001:4830:134:3::10]:35038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1f0oos-0002Bl-Ux
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1f0ooo-0003fP-Lx
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:39:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54130
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
	id 1f0ooo-0003dh-En
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:39:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2RDabxS088706
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:39:17 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gyky4j6g0-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:39:17 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
	Tue, 27 Mar 2018 09:39:16 -0400
Date: Tue, 27 Mar 2018 19:09:08 +0530
From: satheesh rajendran <sathnaga@linux.vnet.ibm.com>
References: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
	<20180327124000.GJ4005@redhat.com>
	<20180327131619.GA27591@localhost.localdomain>
	<20180327132011.GO4005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180327132011.GO4005@redhat.com>
Message-Id: <20180327133908.GB31240@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hmp.c: Revert hmp_info_cpus output format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, satheesh rajendran <sathnaga@linux.vnet.ibm.com>, mihajlov@linux.vnet.ibm.com

On Tue, Mar 27, 2018 at 02:20:11PM +0100, Daniel P. Berrang=E9 wrote:
> Re-adding qemu-devel address - please don't drop the mailing list from
> CC's when replying to messages on the list.
Sorry, Missed intially, had resent it but was too late :-(.

>=20
> On Tue, Mar 27, 2018 at 06:46:19PM +0530, satheesh rajendran wrote:
> > On Tue, Mar 27, 2018 at 01:40:00PM +0100, Daniel P. Berrang=E9 wrote:
> > > On Tue, Mar 27, 2018 at 06:08:00PM +0530, sathnaga@linux.vnet.ibm.c=
om wrote:
> > > > From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > > >=20
> > > > This commit 137b5cb6ab565cb3781d5337591e155932b4230e
> > > > refactors info cpus output and changes output format from
> > > > 'thread_id' to 'thread-id', this would break parsing
> > > > of output in above layers like libvirt, test framework etc.
> > >=20
> > > Libvirt doesn't use HMP, only QMP, so this shouldn't have broken li=
bvirt
> > > afaik.  HMP is not intended to be a stable API so these kind of cha=
nges
> > > should be expected.
> >=20
> > Am sure avocado test framework uses this output for parsing to extrac=
t threadid
>=20
> If avocado is relying on the HMP then it should be updated to use QMP,
> as HMP is not a stable API for automation.
>=20
Sure, Thanks, will change it.

> > and in libvirt atleast I checked below code uses it, I hope keeping t=
he
> > format same as previous won't affect anything?
> >=20
> > in src/qemu/qemu_monitor_text.c
> > int
> > qemuMonitorTextQueryCPUs(qemuMonitorPtr mon,
> >                          struct qemuMonitorQueryCpusEntry **entries,
> >                          size_t *nentries)
> > ...
>=20
> This libvirt code is only executed when managing QEMU versions < 0.15,
> so not affected.
>
Okies :-)

Regards,
-Satheesh
=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20
