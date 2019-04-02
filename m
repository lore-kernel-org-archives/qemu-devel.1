Received: from eggs.gnu.org ([209.51.188.92]:48907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hBGcf-0004gz-KT
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hBGXF-0004B4-Hg
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:20:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hBGXF-0004A3-77
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:20:53 -0400
References: <20190402080215.10747-1-vkuznets@redhat.com>
	<7B2302D0-7277-4C14-9FEA-DDAE70EF005E@oracle.com>
	<461676dd-8a04-3d3e-86c0-76e143fa27b9@redhat.com>
	<47EDAADB-151A-43DC-B137-6E6DCD11BB64@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73925ca6-37ee-f932-ceb5-3144cd6b05cc@redhat.com>
Date: Tue, 2 Apr 2019 12:20:38 +0200
MIME-Version: 1.0
In-Reply-To: <47EDAADB-151A-43DC-B137-6E6DCD11BB64@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ioapic: allow buggy guests mishandling
 level-triggered interrupts to make progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 02/04/19 11:08, Liran Alon wrote:
>> -
>> -            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
>> -                IOAPIC_TRIGGER_LEVEL) {
>> +            if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
>>                 continue;
>>             }
> I think above =E2=80=9Cif=E2=80=9D of checking remote-irr should just b=
e removed.
> But the rest seems good :)
>=20

It seems more logical, as the condition is now the opposite of
ioapic_set_irq: ioapic_set_irq services the interrupt if remote-irr =3D 0=
,
EOI does it if remote-irr =3D 1.

Paolo
