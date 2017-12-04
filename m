Received: from eggs.gnu.org ([2001:4830:134:3::10]:46162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLudh-0004R1-1Q
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLudc-0008R1-2X
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:34:45 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-6-david@redhat.com>
	<20171204182244.2b789717.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8904d9e3-990f-46e1-49d1-9d37533d025e@redhat.com>
Date: Mon, 4 Dec 2017 18:34:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171204182244.2b789717.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 5/5] s390x/tcg: wire up STORE
 CHANNEL REPORT WORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 04.12.2017 18:22, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 13:55:05 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> We somehow missed that, new kernels require it.
>=20
> Why _new_ kernels? I think we have unconditionally issued stcrw since
> back in 2.2?

Okay, the problem is then rather related to my setup. No ccw devices ->
no stcrw.

How could we ever add ccw devices to a TCG guest then?

>=20
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h      | 1 +
>>  target/s390x/insn-data.def | 1 +
>>  target/s390x/misc_helper.c | 9 +++++++++
>>  target/s390x/translate.c   | 8 ++++++++
>>  4 files changed, 19 insertions(+)


--=20

Thanks,

David / dhildenb
