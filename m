Received: from eggs.gnu.org ([2001:4830:134:3::10]:37477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cTpEv-0002nP-M2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cTpEr-0001Ul-Na
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:21:21 -0500
References: <20170105054618.GA12106@umbus.fritz.box>
	<1483724069.4199.80.camel@redhat.com>
	<20170108234621.GB12515@umbus.fritz.box>
	<1484217095.7948.1.camel@redhat.com>
	<bdc8e732-f2e9-ff08-9a0b-30ac16cbd9c2@redhat.com>
	<148423893781.24341.140388976706291486@loki>
	<75e2809a-dab3-15f8-d125-3d2def5ebeeb@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f083c54a-abbf-32c2-c0cf-d95881e4b2b0@redhat.com>
Date: Wed, 18 Jan 2017 14:21:09 +0200
MIME-Version: 1.0
In-Reply-To: <75e2809a-dab3-15f8-d125-3d2def5ebeeb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Proposal PCI/PCIe device placement on PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>, libvir-list@redhat.com
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, aik@ozlabs.ru, groug@kaod.org, ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <Alex.Williamson@redhat.com>

On 01/12/2017 07:53 PM, Laine Stump wrote:
> On 01/12/2017 11:35 AM, Michael Roth wrote:
>> Quoting Laine Stump (2017-01-12 08:52:10)

[...]

>
>
> Yeah you're right, I'm probably remembering the wrong problem and wrong reason for the problem. I just remember there was *some* issue about hotplugging new PCI controllers. Possibly the internal
> representation of the bus hierarchy wasn't updated unless you forced a rescan of all the devices or something? My memory of it is vague, I just remember being told it wasn't just a case of the
> controller itself being initialized.
>
> Alex or Marcel - since whatever it was I likely heard it from one of you (or imagined it in a dream), can you straighten me out?
>

Hi Laine,

Indeed, hot-plugging a QEMU pci-bridge in X86 is somehow problematic since
it comes with some bits on ACPI tables which are already loaded at hot-plug time.
We need the bits since the x86 pci-hotplug is ACPI based. For Q35 machine might be easier,
but is not implemented yet as far as I know.

Thanks,
Marcel

[...]
