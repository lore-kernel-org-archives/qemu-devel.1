Received: from eggs.gnu.org ([2001:4830:134:3::10]:34089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cqjX7-0000Ol-As
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cqjX3-0008Gw-6m
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1cqjX3-0008Gg-1L
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:54:45 -0400
Date: Wed, 22 Mar 2017 17:54:39 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170322165438.GA1910@potion>
References: <20170322155906.10679-1-rkrcmar@redhat.com>
	<20170322180319-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322180319-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pc: q35: bump max_cpus to INT32_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

2017-03-22 18:06+0200, Michael S. Tsirkin:
> On Wed, Mar 22, 2017 at 04:59:06PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 w=
rote:
>> QEMU does not allocate based on machine's max_cpus, but only uses it t=
o
>> limit the maximum selected by user and the actual limit of VCPUs is
>> enfoced by other components:
>>  - machine without vIOMMU ends at 255 VCPUs
>>  - TCG currently doesn't support x2APIC, so it also ends below 256
>>  - KVM with vIOMMU cannot exceed the KVM limit (currently 288)
>>=20
>> Using a big value should bring no drawbacks and the benefit is that
>> components (especially out-of-tree KVM) can bump their limits without
>> touching machine's max_cpus.
>>=20
>> max_cpus is unsigned, but it is treated as signed at least in printf a=
nd
>> the other two billion VCPU won't be needed for a while, so we can igno=
re
>> possible bugs by using signed max.
>>=20
>> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>> ---
>>   Should the 2.9 machine type still have 288?
>=20
> It doesn't look like a bugfix to me.
> So if we can defer past 2.9 that would be best IMO.

Sure, I'll wait until the 2.10 machine type pops up.

Thanks.
