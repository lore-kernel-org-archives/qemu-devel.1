Received: from eggs.gnu.org ([2001:4830:134:3::10]:50031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eentR-0004Ck-DB
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eentM-0007F0-Ak
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:13:05 -0500
Received: from mail-co1nam03on0098.outbound.protection.outlook.com
	([104.47.40.98]:37026
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1eentL-0007DG-UL
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:13:00 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Thu, 25 Jan 2018 20:12:57 +0000
Message-ID: <CY4PR2101MB08663FFAC4CD385DDD4C31B1B6E10@CY4PR2101MB0866.namprd21.prod.outlook.com>
References: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
	<20180125110144.GD27269@stefanha-x1.localdomain>
In-Reply-To: <20180125110144.GD27269@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Updates based on feedback.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>

Hey Stefan,

Your welcome! Excited to help.

I have only tried Ubuntu and Windows guests. Is there a set you would recom=
mend to try out?

As for limitations, this set of patches allows for both bios and efi based =
boots (we have been using TianoCore). We will continue to submit patches ar=
ound performance tuning on the platform but basic functionality is up and r=
unning in this set. The VGA interrupt path can be improved and we are looki=
ng at options here to make this a smoother experience. And as mentioned in =
the update we don't have CPUID support fully implemented yet for migration =
scenarios. Was there a specific set of things you were wondering that I cou=
ld investigate or provide clarity on?

Thanks,
Justin

> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Thursday, January 25, 2018 3:02 AM
> To: Justin Terry (VM) <juterry@microsoft.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; rth@twiddle.net;
> ehabkost@redhat.com; crosthwaite.peter@gmail.com
> Subject: Re: [Qemu-devel] [PATCH v2 0/4] Updates based on feedback.
>=20
> On Mon, Jan 22, 2018 at 01:07:45PM -0800, Justin Terry (VM) via Qemu-deve=
l
> wrote:
> > Updates based on review feedback.
> >
> > 1. Fixes style issues and properly ran the scripts/checkpatch pre submi=
ssion.
> > 2. Added migration blockers for CPUID, dirty memory tracking, and
> XSAVE/XRSTOR.
> > 3. Fixed some bugs around register states when using bios vs efi.
> >
> > Justin Terry (VM) (4):
> >   Add the Windows Hypervisor Platform accelerator.
> >   Add the WHPX vcpu API
> >   Introduce the WHPX impl
> >   Add the WHPX acceleration enlightenments
>=20
> This could be huge for QEMU on Windows users.  Thanks for doing this!
>=20
> Which guest OSes have you tested?
>=20
> What are the known limitations (after all, the code is quite small and ma=
ybe not
> everything is implemented yet in this patch series)?
>=20
> Stefan
