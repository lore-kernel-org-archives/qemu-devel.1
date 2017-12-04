Received: from eggs.gnu.org ([2001:4830:134:3::10]:47524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLuiV-0006Dq-Dz
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLuiQ-0003lS-Ew
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:39:43 -0500
References: <20171204140150.20483-1-david@redhat.com>
	<20171204140150.20483-5-david@redhat.com>
	<20171204182454.5e397739.cohuck@redhat.com>
	<1a964f3a-c5e4-5ad5-fa44-d9242124c955@redhat.com>
	<20171204183200.2641e1e2.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f4489166-b80b-9276-7f89-d133e7a2d8a7@redhat.com>
Date: Mon, 4 Dec 2017 18:39:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171204183200.2641e1e2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 4/9] s390x/tcg: wire up SET
 CHANNEL MONITOR
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

On 04.12.2017 18:32, Cornelia Huck wrote:
> On Mon, 4 Dec 2017 18:27:55 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 04.12.2017 18:24, Cornelia Huck wrote:
>>> On Mon,  4 Dec 2017 15:01:45 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>  =20
>>>> Let's just wire it up like KVM.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  target/s390x/helper.h      | 1 +
>>>>  target/s390x/insn-data.def | 1 +
>>>>  target/s390x/misc_helper.c | 9 +++++++++
>>>>  target/s390x/translate.c   | 7 +++++++
>>>>  4 files changed, 18 insertions(+) =20
>>>
>>> So we would have generated an exception before if someone tried to
>>> enable channel measurements under tcg?
>>>  =20
>>
>> Yes, PGM_OPERATION should have been triggered.
>>
>=20
> Next question: What happens now if we try to enable channel
> measurements? :)
>=20

With my limited knowledge of the magical world of css, it seems to work.

[root@localhost ~]# chccwdev --attribute cmb_enable=3D1 0.0.0001
Setting cmb_enable attribute of 0.0.0001 to 1
Done


--=20

Thanks,

David / dhildenb
