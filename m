Received: from eggs.gnu.org ([2001:4830:134:3::10]:37650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dKfpv-0006xO-DA
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dKfps-0001d0-9o
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:01:59 -0400
Message-ID: <1497337300.27606.7.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 13 Jun 2017 15:01:40 +0800
In-Reply-To: <20170602031507.29881-1-david@gibson.dropbear.id.au>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv5 0/4] Clean up compatibility
 mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbobroff@redhat.com

On Fri, 2017-06-02 at 13:15 +1000, David Gibson wrote:
> This is a rebased and revised version of my patches revising CPU
> compatiblity mode handling on ppc, last posted in November.=C2=A0=C2=A0=
Since
> then, many of the patches have already been merged (some for 2.9, some
> since).=C2=A0=C2=A0This is what's left.

As discussed yesterday on libvir-list, the current
implementation will abort() when the user attempts to use
a compat mode that's not valid for the host CPU, eg. on
a POWER8 host:

=C2=A0 $ qemu-system-ppc64 \
=C2=A0=C2=A0=C2=A0=C2=A0-nodefaults \
=C2=A0=C2=A0=C2=A0=C2=A0-M pseries,accel=3Dkvm \
=C2=A0=C2=A0=C2=A0=C2=A0-cpu host,compat=3Dpower9
=C2=A0 Unexpected error in ppc_set_compat() at target/ppc/compat.c:135:
=C2=A0 qemu-system-ppc64: Compatibility PVR 0x0f000005 not valid for CPU
=C2=A0 Aborted

We should probably report the error to the user in a slightly
less destructive fashion :)


[1] https://www.redhat.com/archives/libvir-list/2017-June/msg00476.html
--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
