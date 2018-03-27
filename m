Received: from eggs.gnu.org ([2001:4830:134:3::10]:59016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f0oWR-0002zP-2G
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f0oWL-0007DE-VV
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:20:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f0oWL-0007Co-R2
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:20:13 -0400
Date: Tue, 27 Mar 2018 14:20:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180327132011.GO4005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
	<20180327124000.GJ4005@redhat.com>
	<20180327131619.GA27591@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327131619.GA27591@localhost.localdomain>
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
To: qemu-devel@nongnu.org, satheesh rajendran <sathnaga@linux.vnet.ibm.com>

Re-adding qemu-devel address - please don't drop the mailing list from
CC's when replying to messages on the list.

On Tue, Mar 27, 2018 at 06:46:19PM +0530, satheesh rajendran wrote:
> On Tue, Mar 27, 2018 at 01:40:00PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Tue, Mar 27, 2018 at 06:08:00PM +0530, sathnaga@linux.vnet.ibm.com=
 wrote:
> > > From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > >=20
> > > This commit 137b5cb6ab565cb3781d5337591e155932b4230e
> > > refactors info cpus output and changes output format from
> > > 'thread_id' to 'thread-id', this would break parsing
> > > of output in above layers like libvirt, test framework etc.
> >=20
> > Libvirt doesn't use HMP, only QMP, so this shouldn't have broken libv=
irt
> > afaik.  HMP is not intended to be a stable API so these kind of chang=
es
> > should be expected.
>=20
> Am sure avocado test framework uses this output for parsing to extract =
threadid

If avocado is relying on the HMP then it should be updated to use QMP,
as HMP is not a stable API for automation.

> and in libvirt atleast I checked below code uses it, I hope keeping the
> format same as previous won't affect anything?
>=20
> in src/qemu/qemu_monitor_text.c
> int
> qemuMonitorTextQueryCPUs(qemuMonitorPtr mon,
>                          struct qemuMonitorQueryCpusEntry **entries,
>                          size_t *nentries)
> ...

This libvirt code is only executed when managing QEMU versions < 0.15,
so not affected.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
