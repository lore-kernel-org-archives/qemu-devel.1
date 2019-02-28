Received: from eggs.gnu.org ([209.51.188.92]:53602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzOkC-00070R-R0
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzOkA-0007hC-Rl
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:41:12 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-9-david@redhat.com>
	<23a43b55-4902-0440-8243-62aaff19c83a@linaro.org>
	<bb16025b-cda4-6613-7e10-a03c887b106a@redhat.com>
	<4af07456-e6d8-918f-6741-83e4e1a739bb@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a6756b53-a9e4-e15d-89cc-335ea0ee05e2@redhat.com>
Date: Thu, 28 Feb 2019 17:40:52 +0100
MIME-Version: 1.0
In-Reply-To: <4af07456-e6d8-918f-6741-83e4e1a739bb@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 08/33] s390x/tcg: Implement VECTOR LOAD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 28.02.19 17:34, Richard Henderson wrote:
> On 2/27/19 11:48 PM, David Hildenbrand wrote:
>> I think that would be wrong. It is only an alignment hint.
>>
>> "Setting the alignment hint to a non-zero value
>> that doesn=E2=80=99t correspond to the alignment of the second operand=
 may
>> reduce performance on some models."
>>
>> So we must not inject an exception when unaligned. This, however would
>> be the result of MO_ALIGN,, right?
>=20
> Ah, I didn't get that an alignment exception is not raised.  (I do find=
 that
> odd.  If the user is asserting a given alignment, why would we not tell=
 him if
> he is wrong?)

I was wondering the same thing. Most probably because they didn't
specify that that field has to contain 0 when introducing the
instruction. And as they added the alignment constraint only on new
hardware generations (z14), it could result for some instructions where
stuff "used to work" to suddenly report an exception.

>=20
> So, yes, ignore all of this from me -- leave MO_ALIGN off.
>=20
>=20
> r~
>=20


--=20

Thanks,

David / dhildenb
