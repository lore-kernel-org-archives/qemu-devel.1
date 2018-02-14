Received: from eggs.gnu.org ([2001:4830:134:3::10]:40244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1eloqo-00084x-Bo
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1eloql-0007Ok-3L
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:39:22 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:38326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1eloqk-0007KN-PY
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:39:19 -0500
Message-Id: <5A83BD72020000480006932A@prv-mh.provo.novell.com>
Date: Tue, 13 Feb 2018 21:39:14 -0700
From: "Bruce Rogers" <brogers@suse.com>
References: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com, peter.maydell@linaro.org, cohuck@redhat.com, ehabkost@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com

On 2/13/2018 at 5:11 PM, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> This blog entry is intended as a follow=E2=80=91up to the original entry =
in
> January regarding Spectre/Meltdown and the proposed changes to address
> them in the upcoming 2.11.1 release.
>=20
> This entry is meant to accompany the 2.11.1 release (planned for
> 2018=E2=80=9102=E2=80=9114) and document how to make use of the new =
options for
> various architectures.
>=20
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed=E2=80=91off=E2=80=91by: Michael Roth <mdroth@linux.vnet.ibm.com>
> =E2=80=91=E2=80=91=E2=80=91
>=20
> The pseries/s390 bits have gotten some initial review (thanks=20
> Suraj/Christian),
> but it can definitely use some additional review on the x86 side of =
things.
>=20
> Also, Peter if think anything extra should to be mentioned on the ARM =
side=20
> just
> let me know what to add.
>=20
>  .../2018=E2=80=9102=E2=80=9114=E2=80=91qemu=E2=80=912=E2=80=9111=E2=80=
=911=E2=80=91and=E2=80=91spectre=E2=80=91update.md   | 180 ++++++++++++++++=
+++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 _posts/2018=E2=80=9102=E2=80=9114=E2=80=91qemu=E2=80=
=912=E2=80=9111=E2=80=911=E2=80=91and=E2=80=91spectre=E2=80=91update.md
>=20
> diff =E2=80=91=E2=80=91git a/_posts/2018=E2=80=9102=E2=80=9114=E2=80=91qe=
mu=E2=80=912=E2=80=9111=E2=80=911=E2=80=91and=E2=80=91spectre=E2=80=91updat=
e.md=20
> b/_posts/2018=E2=80=9102=E2=80=9114=E2=80=91qemu=E2=80=912=E2=80=9111=E2=
=80=911=E2=80=91and=E2=80=91spectre=E2=80=91update.md
> new file mode 100644
> index 0000000..7cdea59
> =E2=80=91=E2=80=91=E2=80=91 /dev/null
> +++ b/_posts/2018=E2=80=9102=E2=80=9114=E2=80=91qemu=E2=80=912=E2=80=9111=
=E2=80=911=E2=80=91and=E2=80=91spectre=E2=80=91update.md
> @@ =E2=80=910,0 +1,180 @@
> +=E2=80=91=E2=80=91=E2=80=91
> +layout: post
> +title:  "QEMU 2.11.1 and making use of Spectre/Meltdown mitigation for =
KVM=20
> guests"
> +date: 2018=E2=80=9102=E2=80=9114 10:35:44 =E2=80=910600
> +author: Michael Roth
> +categories: [meltdown, spectre, security, x86, ppc, s390, releases, =
'qemu=20
> 2.11']
> +=E2=80=91=E2=80=91=E2=80=91
> +
> +In a [previous post](https://www.qemu.org/2018/01/04/spectre/) it was
> +detailed how QEMU/KVM might be affected by Spectre/Meltdown attacks, =
and=20
> what
> +the plan was to mitigate them in QEMU 2.11.1 (and eventually QEMU =
2.12).
> +
> +QEMU 2.11.1 is now available, and contains the aforementioned mitigation=
s=20
> for
> +x86 guests, along with additional mitigation functionality for pseries =
and
> +s390 guests (ARM guests do not currently require additional QEMU =
patches).
> +However, enabling this functionality requires additional configuration=
=20
> beyond
> +just updating QEMU, which we hope to address with this post.
> +
> +Please note that, as mentioned in the previous blog post, QEMU/KVM=20
> generally
> +has the same requirements as other unpriviledged processes running on =
the
> +host WRT Spectre/Meltdown mitigation. What is being addressed here is
> +enabling a guest operating system to enable the same (or similar)=20
> mitigations
> +to protect itself from unpriviledged guest processes. Thus, the
> +patches/requirements listed here are specific to that goal and should =
not=20
> be
> +regarded as the full set of requirements to enable mitigations on the =
host
> +side (though in some cases there is some overlap between the two WRT=20
> required
> +patches/etc).
> +
> +Also please note that this is a best=E2=80=91effort from the QEMU/KVM =
community, and
> +these mitigations rely on a mix of additional kernel/firmware/microcode
> +updates that are in some cases not available publically, or may not yet =
be
> +implemented in some distros, so users are highly encouraged to consult =
with
> +their respective vendors/distros to confirm whether all the required
> +components are in place. We do our best to highlight the requirements =
here,
> +but this may not be an exhaustive list.
> +
> +
> +## enabling mitigations for x86 KVM guests
> +
> +For x86 guests there are 2 additional CPU flags associated with
> +Spectre/Meltdown mitigation
: **spec=E2=80=91ctrl**, and **ibpb**. These flags
> +expose additional functionality made available through new microcode
> +updates for certain Intel/AMD processors that can be used to mitigate
> +various attack vectors related to Spectre. (Meltdown mitigation via =
KPTI
> +does not require additional CPU functionality or microcode, and does =
not
> +require an updated QEMU, only the related guest/host kernel patches).
> +
> +These CPU flags:
> +
> +* spec=E2=80=91ctrl: exposes Indirect Branch Restricted Speculation =
(IBRS)
> +* ibpb: exposes Indirect Branch Prediction Barriers
> +
> +are both features requiring guest/host kernel updates, as well as
> +microcode updates for Intel and recent AMD processors. The status of
> +these kernel patches upstream is still in flux, but most supported
> +distros have some form of the patches that is sufficient to make use
> +of the features. The current status/availability of microcode updates
> +depends on your CPU architecture/model. Please check with your
> +vendor/distro to confirm these prerequisites are available/installed.
> +
> +Generally, for Intel CPUs with updated microcode, **spec=E2=80=91ctrl** =
will
> +enable both IBRS and IBPB functionality. For AMD EPYC processors,
> +**ibpb** can be used to enable IBPB specifically, and is thought to
> +be sufficient by itself that particular architecture.

be sufficient by itself for that particular architecture

> +
> +These flags can be set in a similar manner as other CPU flags, i.e.:
> +
> +    qemu=E2=80=91system=E2=80=91x86_64 =E2=80=91cpu qemu64,+spec=E2=80=
=91ctrl,... ...
> +    qemu=E2=80=91system=E2=80=91x86_64 =E2=80=91cpu IvyBridge,+spec=E2=
=80=91ctrl,... ...
> +    qemu=E2=80=91system=E2=80=91x86_64 =E2=80=91cpu EPYC,+ibpb
> +    etc...

kind of a nit, but might as well be consistent here, as in:
qemu-system-x86_64 -cpu EPYC,+ibpb,... ...


Thanks for putting this together!

Bruce
