Received: from eggs.gnu.org ([2001:4830:134:3::10]:39006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec7me-0002q8-DY
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec7ma-0007Qa-1B
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:51:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ec7mZ-0007Q9-Qe
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:50:55 -0500
References: <CAKXe6SJtWUFY8hN=dXzFCzztcsGkWbNx+1WZba05Rp3TqO_38w@mail.gmail.com>
	<824534a8-89ea-7b7a-40c9-1e4b5266e648@redhat.com>
	<CAKXe6SJwebj1Jzkwn8nCCkXZbx3HzOEYT8RFfKoJsiDfwiuvdg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <027977e8-b4bd-4ac3-f126-e378c29b990c@redhat.com>
Date: Thu, 18 Jan 2018 11:50:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJwebj1Jzkwn8nCCkXZbx3HzOEYT8RFfKoJsiDfwiuvdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Do I need update the microcode of virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>

On 18/01/2018 11:48, Li Qiang wrote:
>=20
>     > But upon I update the centos guest, the host kvm/qemu has been up=
dated.
>     > The IBPB_ENABLED and IBRS_ENABLED are both zero if I don't update=
 the
>     > microcode in the guest. If I update the guest micorcode, the are =
both 1.
>=20
>     What do you mean by "update the guest microcode"?=C2=A0 Did you mea=
n host?
>=20
>=20
> No, here mean the guest. By overwrite guest's files in
> /lib/firmware/intel-ucode/ directory and "echo 1 >
> /sys/devices/system/cpu/microcode/reload" as Intel's instruction says.
> The host's kvm and qemu has been got updated before this.

No, that has no effect.

Paolo
