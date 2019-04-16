Received: from eggs.gnu.org ([209.51.188.92]:42489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGK2r-00008x-UH
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGK2q-00013w-0Y
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:06:25 -0400
Received: from [110.188.70.11] (port=31148 helo=spam1.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hGK2p-0000wS-9t
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:06:23 -0400
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415092500.GD5718@redhat.com>
	<aa92336f-681e-30d9-2670-7d0093d9912a@hygon.cn>
	<20190416081804.GC31311@redhat.com>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <8622eb20-ed78-fcc8-4e24-f9b8333af381@hygon.cn>
Date: Tue, 16 Apr 2019 17:04:36 +0800
MIME-Version: 1.0
In-Reply-To: <20190416081804.GC31311@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>

On 2019/4/16 16:19, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 16, 2019 at 02:56:12PM +0800, Pu Wen wrote:
>> On 2019/4/15 17:25, Daniel P. Berrang=C3=A9 wrote:
>>> On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
>>>> @@ -152,6 +154,7 @@ GlobalProperty pc_compat_2_12[] =3D {
>>>>        { TYPE_X86_CPU, "topoext", "off" },
>>>>        { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>>>        { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>>> +    { "Dhyana-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>>>    };
>>>>    const size_t pc_compat_2_12_len =3D G_N_ELEMENTS(pc_compat_2_12);
>>>
>>> You can drop the changes in this file. This CPU model didn't exist
>>> in any older QEMU releases, so there's no machine type backcompat
>>> required, at least from upstream QEMU POV.
>>
>> Then how about running QEMU with the parameter like "-M pc-i440fx-2.12=
"?
>> Although the default machine is newer than that.
>=20
> That doesnt matter.  This back-compat property table is about ensuring
> that "-cpu Skylake-Client -M pc-i440fx-2.12" run on QEMU 4.0.0 release
> works the same way as when run on QEMU 2.12.0 release.
>=20
> Since there is no Dhyana CPU model in QEMU 2.12.0 release, there's no
> back compat issue to fix.

Thanks for the explanation. Will drop the changes in next version patch.

--=20
Regards,
Pu Wen
