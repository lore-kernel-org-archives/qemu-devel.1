Received: from eggs.gnu.org ([2001:4830:134:3::10]:36330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTo6n-00065W-RY
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTo6n-00049K-0n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:45:41 -0400
References: <20180615112500.19854-1-david@redhat.com>
	<20180615112500.19854-7-david@redhat.com>
	<20180615143923.1babac86@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b47a7a83-84da-d239-e52a-d683668e77a8@redhat.com>
Date: Fri, 15 Jun 2018 14:45:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180615143923.1babac86@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/12] hostmem: drop error variable from
 host_memory_backend_get_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On 15.06.2018 14:39, Igor Mammedov wrote:
> On Fri, 15 Jun 2018 13:24:54 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> Unused, so let's remove it.
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> breaks compilation with
>=20
>  hw/mem/nvdimm.c:171:5: error: too many arguments to function =E2=80=98=
host_memory_backend_get_memory=E2=80=99
>      return host_memory_backend_get_memory(dimm->hostmem, &error_abort)=
;
>=20

Looks like some reshuffling of patches was not that healthy. Will fix.

--=20

Thanks,

David / dhildenb
