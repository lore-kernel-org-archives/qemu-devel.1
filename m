Received: from eggs.gnu.org ([2001:4830:134:3::10]:55015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLIR5-0000nz-GP
	for qemu-devel@nongnu.org; Tue, 22 May 2018 21:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLIR2-0002TH-AK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 21:19:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLIR2-0002Rn-5k
	for qemu-devel@nongnu.org; Tue, 22 May 2018 21:19:24 -0400
Date: Wed, 23 May 2018 09:19:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180523011915.GD31932@xz-mi>
References: <20180522035629.30428-1-peterx@redhat.com>
	<20180522035629.30428-3-peterx@redhat.com>
	<583d5b48-bb34-2c47-8e80-6c1142701506@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <583d5b48-bb34-2c47-8e80-6c1142701506@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel-iommu: start to use
 error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, May 22, 2018 at 06:09:46PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Peter,
>=20
> On 05/22/2018 12:56 AM, Peter Xu wrote:
> > Replace existing trace_vtd_err() with error_report_once() then stderr
> > will capture something if any of the error happens, meanwhile we don'=
t
> > suffer from any DDOS.  Then remove the trace point.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c | 34 +++++++++++++++++-----------------
> >  hw/i386/trace-events  |  1 -
> >  2 files changed, 17 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index fb31de9416..cf655fb9f6 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -285,14 +285,14 @@ static void vtd_generate_fault_event(IntelIOMMU=
State *s, uint32_t pre_fsts)
> >  {
> >      if (pre_fsts & VTD_FSTS_PPF || pre_fsts & VTD_FSTS_PFO ||
> >          pre_fsts & VTD_FSTS_IQE) {
> > -        trace_vtd_err("There are previous interrupt conditions "
> > +        error_report_once("There are previous interrupt conditions "
> >                        "to be serviced by software, fault event "
> >                        "is not generated.");
>=20
> Can you keep alignment consistent please?

That was actually intended so reviewers don't need to skim those lines
only caused by indents.  If I'm going to touch those lines, then maybe
I can make them even look better by dumping more valid information.

I'll repost.  Thanks,

--=20
Peter Xu
