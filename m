Received: from eggs.gnu.org ([2001:4830:134:3::10]:37410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec7fP-0006zr-QA
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec7fM-0001rY-LQ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:43:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ec7fM-0001qr-FD
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:43:28 -0500
References: <CAKXe6SJtWUFY8hN=dXzFCzztcsGkWbNx+1WZba05Rp3TqO_38w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <824534a8-89ea-7b7a-40c9-1e4b5266e648@redhat.com>
Date: Thu, 18 Jan 2018 11:43:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJtWUFY8hN=dXzFCzztcsGkWbNx+1WZba05Rp3TqO_38w@mail.gmail.com>
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

On 18/01/2018 11:38, Li Qiang wrote:
> Hi Paolo, all,
>=20
> I have a question about the intel microcode update for spectre variant#=
2.
> From my understanding, there is no need to update the microcode of VMs
> because the kvm has expose the SPEC_CTL and PRED_CMD to the guest.
> Also, if we need to update the micorcode in guest, who is the vendor fo=
r
> this.

The guest has no microcode of it's own, but you need to update the
microcode in the host.  You also need to update the kernel, QEMU and
libvirt if you are using it.

> From the hyper-v, I think I'm right.
> -->https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/C=
VE-2017-5715-and-hyper-v-vms
>=20
> But upon I update the centos guest, the host kvm/qemu has been updated.
> The IBPB_ENABLED and IBRS_ENABLED are both zero if I don't update the
> microcode in the guest. If I update the guest micorcode, the are both 1=
.

What do you mean by "update the guest microcode"?  Did you mean host?

Paolo

>=20
> So I want to know, if I should update the microcode in guest.=C2=A0
> If the answer is Yes, then what about the Windows guest, how to update
> the microcode?
>=20
>=20
> Thanks,
> Li Qiang
