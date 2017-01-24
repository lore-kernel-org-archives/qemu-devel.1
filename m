Received: from eggs.gnu.org ([2001:4830:134:3::10]:36582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW0jM-0001Hz-BC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW0jL-0000qI-Lc
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:01:48 -0500
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
	<1485164923-17736-7-git-send-email-armbru@redhat.com>
	<2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com>
	<877f5l1tak.fsf@dusky.pond.sub.org>
	<3512807d-d04e-50fa-9fcf-d1d5ba8ac350@redhat.com>
	<87r33saa6p.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4cd45561-60e9-2cd2-e317-880ba9eb2f86@redhat.com>
Date: Tue, 24 Jan 2017 14:01:38 +0100
MIME-Version: 1.0
In-Reply-To: <87r33saa6p.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/i386/i386: Stop auto-creating
 lsi53c895a SCSI HBAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>



On 24/01/2017 13:56, Markus Armbruster wrote:
> So, what do we want to deprecate?
> 
> I think the onboard SCSI HBA adopting if=scsi drives should stay,
> because it matches what we do for other interface types.  Unless we
> wanted to deprecate interface types other than none entirely.

Yes, of course.

> What about realview and versatile auto-creating lsi53c895a?

That should go.

> What about pseries auto-creating spapr-vscsi?

That should stay I think.  The discriminant being that spapr-vscsi
devices actually are likely to have drivers in the guests.

> What about cold-plug of HBAs auto-creating SCSI devices?  You proposed
> deprecating it for PC types, but it's currently independent of the
> machine type.  Deprecate it for all types?  If not, add a flag to
> MachineClass so we can deprecate it just for PC types?

I need --verbose for this, sorry.

Paolo
