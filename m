Received: from eggs.gnu.org ([2001:4830:134:3::10]:38597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ec7kX-0001It-7s
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ec7kW-0005pc-4E
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:48:49 -0500
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1ec7kV-0005pH-Um
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:48:48 -0500
Received: by mail-io0-x22d.google.com with SMTP id c17so24397164iod.1
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 02:48:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <824534a8-89ea-7b7a-40c9-1e4b5266e648@redhat.com>
References: <CAKXe6SJtWUFY8hN=dXzFCzztcsGkWbNx+1WZba05Rp3TqO_38w@mail.gmail.com>
	<824534a8-89ea-7b7a-40c9-1e4b5266e648@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Jan 2018 18:48:06 +0800
Message-ID: <CAKXe6SJwebj1Jzkwn8nCCkXZbx3HzOEYT8RFfKoJsiDfwiuvdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Do I need update the microcode of virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>

2018-01-18 18:43 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:

> On 18/01/2018 11:38, Li Qiang wrote:
> > Hi Paolo, all,
> >
> > I have a question about the intel microcode update for spectre variant#2.
> > From my understanding, there is no need to update the microcode of VMs
> > because the kvm has expose the SPEC_CTL and PRED_CMD to the guest.
> > Also, if we need to update the micorcode in guest, who is the vendor for
> > this.
>
> The guest has no microcode of it's own, but you need to update the
> microcode in the host.  You also need to update the kernel, QEMU and
> libvirt if you are using it.
>
> > From the hyper-v, I think I'm right.
> > -->https://docs.microsoft.com/en-us/virtualization/hyper-v-
> on-windows/CVE-2017-5715-and-hyper-v-vms
> >
> > But upon I update the centos guest, the host kvm/qemu has been updated.
> > The IBPB_ENABLED and IBRS_ENABLED are both zero if I don't update the
> > microcode in the guest. If I update the guest micorcode, the are both 1.
>
> What do you mean by "update the guest microcode"?  Did you mean host?
>

No, here mean the guest. By overwrite guest's files in
/lib/firmware/intel-ucode/ directory and "echo 1 >
/sys/devices/system/cpu/microcode/reload" as Intel's instruction says.
The host's kvm and qemu has been got updated before this.

Thanks,
Li Qiang


>
> Paolo
>
> >
> > So I want to know, if I should update the microcode in guest.
> > If the answer is Yes, then what about the Windows guest, how to update
> > the microcode?
> >
> >
> > Thanks,
> > Li Qiang
>
>
