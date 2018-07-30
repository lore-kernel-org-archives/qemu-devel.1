Received: from eggs.gnu.org ([2001:4830:134:3::10]:55314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fkEYH-0007Tm-Ju
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fkEYC-00010u-KU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:13:57 -0400
Date: Mon, 30 Jul 2018 17:13:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180730201346.GL12380@localhost.localdomain>
References: <20180725091233.3300-1-david@redhat.com>
	<20180727145551.2a1df03f.cohuck@redhat.com>
	<f0779ee6-b52c-554d-8ca2-529ff153b745@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0779ee6-b52c-554d-8ca2-529ff153b745@redhat.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390x/cpu_models: Add
 "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jul 30, 2018 at 11:16:38AM +0200, David Hildenbrand wrote:
> On 27.07.2018 14:55, Cornelia Huck wrote:
> > On Wed, 25 Jul 2018 11:12:33 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> > 
> >> The "max" CPU model behaves like "-cpu host" when KVM is enabled, and like
> >> a CPU with the maximum possible feature set when TCG is enabled.
> >>
> >> While the "host" model can not be used under TCG ("kvm_required"), the
> >> "max" model can and "Enables all features supported by the accelerator in
> >> the current host".
> >>
> >> So we can treat "host" just as a special case of "max" (like x86 does).
> >> It differs to the "qemu" CPU model under TCG such that compatibility
> >> handling will not be performed and that some experimental CPU features
> >> not yet part of the "qemu" model might be indicated.
> >>
> >> These are right now under TCG (see "qemu_MAX"):
> >> - stfle53
> >> - msa5-base
> >> - zpci
> >>
> >> This will result right now in the following warning when starting QEMU TCG
> >> with the "max" model:
> >>     "qemu-system-s390x: warning: 'msa5-base' requires 'kimd-sha-512'."
> >>
> >> The "qemu" model (used as default in QEMU under TCG) will continue to
> >> work without such warnings. The "max" mdel in the current form
> >> might be interesting for kvm-unit-tests (where we would e.g. now also
> >> test "msa5-base").
> >>
> >> The "max" model is neither static nor migration safe (like the "host"
> >> model). It is independent of the machine but dependends on the accelerator.
> >> It can be used to detect the maximum CPU model also under TCG from upper
> >> layers without having to care about CPU model names for CPU model
> >> expansion.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  target/s390x/cpu_models.c | 81 +++++++++++++++++++++++++++------------
> >>  1 file changed, 56 insertions(+), 25 deletions(-)
> > 
> > So, what's the outcome? Can I merge this with the discussed minor
> > edits, or should I wait for a v2?
> > 
> 
> Eduardo identified possible optimizations independent of this patch, so
> we should be good to go. @Eduardo, please correct me if I'm wrong!

This version still looks good to me, my Reviewed-by line still
applies.  Thanks!

-- 
Eduardo
