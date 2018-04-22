Received: from eggs.gnu.org ([2001:4830:134:3::10]:40452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAAKr-0007rl-HF
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 04:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAAKm-0003D8-HI
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 04:27:01 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-2-david@redhat.com>
	<1768047882.21650876.1524373778096.JavaMail.zimbra@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9588e61b-e9d0-c320-d6f8-790b245a1dc8@redhat.com>
Date: Sun, 22 Apr 2018 10:26:44 +0200
MIME-Version: 1.0
In-Reply-To: <1768047882.21650876.1524373778096.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] pc-dimm: factor out MemoryDevice
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

>> +typedef struct MemoryDeviceClass {
>> +    InterfaceClass parent_class;
>> +
>> +    uint64_t (*get_addr)(MemoryDeviceState *md);
>> +    uint64_t (*get_plugged_size)(MemoryDeviceState *md, Error **errp)=
;
>> +    uint64_t (*get_region_size)(MemoryDeviceState *md, Error **errp);
>=20
> Just not sure if we need second argument 'Error **errp'? Or all functio=
ns
> declarations should have this?=20

We need them right now due to the existing implementation of PCDIMM. I
don't think we will ever hit such a case (not if anything else is
seriously wrong). If nobody has a problem with it, I'll drop these two
parameters and directly use &error_abort internally (PCDIMM).

Adding Error **errp to functions where we don't expect to be errors
doesn't feel right.

Thanks for pointing this out!

--=20

Thanks,

David / dhildenb
