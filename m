Received: from eggs.gnu.org ([2001:4830:134:3::10]:36860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gKJl7-0007XX-CM
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gKJkr-0003ca-3a
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:04:13 -0500
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-5-david@redhat.com>
	<20181106231041.GC24589@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <252c917e-a06f-08f6-db22-30b0459b507d@redhat.com>
Date: Wed, 7 Nov 2018 10:03:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181106231041.GC24589@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/10] pci/pcie: stop plug/unplug if the
 slot is locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On 07.11.18 00:10, David Gibson wrote:
> On Mon, Nov 05, 2018 at 11:20:38AM +0100, David Hildenbrand wrote:
>> We better stop right away. While at it, properly move the check
>> to the pre_plug handler.
>>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Although I'm not sure the commit message gives a terribly clear
> picture of what's going on here.

Thanks, I'll change it to

"We better stop right away. For now, errors would be partially ignored
(so the guest might get informed or the device might get unplugged),
although actual plug/unplug will be reported as failed to the user.

While at it, properly move the check to the pre_plug handler for the
plug case, as we can test the slot state before the device will be
realized."

--=20

Thanks,

David / dhildenb
