Received: from eggs.gnu.org ([2001:4830:134:3::10]:46065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eu3Lr-0005eB-Uu
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 16:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eu3Ln-0006Kv-Sn
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 16:45:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eu3Ln-0006KZ-Ln
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 16:45:23 -0500
Date: Thu, 8 Mar 2018 18:45:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180308214504.GE3417@localhost.localdomain>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-29-brijesh.singh@amd.com>
	<20180308170824.GL4718@redhat.com>
	<e6db1aaa-83c7-ae5c-2311-bc247b301426@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e6db1aaa-83c7-ae5c-2311-bc247b301426@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 28/28] tests/qmp-test: blacklist sev
 specific qmp commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>

On Thu, Mar 08, 2018 at 02:18:55PM -0600, Brijesh Singh wrote:
>=20
>=20
> On 3/8/18 11:08 AM, Daniel P. Berrang=E9 wrote:
> > On Thu, Mar 08, 2018 at 06:49:01AM -0600, Brijesh Singh wrote:
> >> Blacklist the following commands to fix the 'make check' failure.
> >>
> >> query-sev-launch-measure: it returns meaninful data only when we lau=
nch
> >> SEV guest otherwise the command returns an error.
> >>
> >> query-sev: it return an error when SEV is not available on host (e.g=
 non
> >> X86 platform or KVM is disabled at the build time)
> >>
> >> query-sev-capabilities: it returns an error when SEV feature is not
> >> available on host machine.
> > We generally expect 'make check' to succeed on every single patch
> > in a series, so that 'git bisect' doesn't break.
> >
> > So you should add each command to the blacklist in the same commit
> > that introduced the failure in the first place.
>=20
>=20
> Sure, I can quickly send the updated patch series to address your this
> concern, but before spamming everyone's inbox I was wondering if I can
> get some indication whether this series will make into 2.12 merge.
>=20
> Paolo, Eduardo and Richard,
>=20
> Most of the changes are in x86 directory hence any thought if you are
> considering this series for 2.12 ? I have been testing the series with
> and without SEV support and so far have not ran into any issue. if you
> are not planning to pull this series in 2.12 then I will wait a bit
> longer to get more feedback before sending the updates to address
> Daniel's comment. thanks

Trying to merge it before 2.12 soft freeze (next Tuesday) still
looks like a reasonable goal to me.  What do others think?

--=20
Eduardo
