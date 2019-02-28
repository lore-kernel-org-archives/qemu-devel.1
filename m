Received: from eggs.gnu.org ([209.51.188.92]:46356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzFr5-0001S2-Lb
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzFr4-0005Dy-CJ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:11:43 -0500
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-3-david@redhat.com>
	<ec7a9ec1-3d6d-6d19-246c-4f6d41f52ec1@redhat.com>
	<87h8cpkmra.fsf@zen.linaroharston>
	<56298ace-a6f7-2b2a-acc2-0e09615c121b@redhat.com>
	<87fts8lxl8.fsf@zen.linaroharston>
	<bd3c9d75-ab17-cd04-ba04-cb1fb19b4ce8@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <90c21734-878e-9c0a-cea3-911c4931e8cd@redhat.com>
Date: Thu, 28 Feb 2019 08:11:38 +0100
MIME-Version: 1.0
In-Reply-To: <bd3c9d75-ab17-cd04-ba04-cb1fb19b4ce8@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/tcg: target/s390: Add test
 for VECTOR LOAD GR FROM VR ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 28.02.19 01:24, Richard Henderson wrote:
> On 2/27/19 1:40 PM, Alex Benn=C3=A9e wrote:
>> And crucially have nice regular sized instructions. Is that not an opt=
ion?
>=20
> s390 insns are {2,4,6} bytes.  I don't think that there's an easy way t=
o pick
> out the hw status codes that would give the ilen of the faulting insn.
>=20

We would have to read the faulting instruction to determine based on the
two leftmost bits the ilen. But I don't consider that approach much
cleaner compared to signal + setjmp (signal + sigsetjmp after I fixed it
;) )

Thanks for the pointer though, Alex

>=20
> r~
>=20


--=20

Thanks,

David / dhildenb
