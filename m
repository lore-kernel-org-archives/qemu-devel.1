Received: from eggs.gnu.org ([2001:4830:134:3::10]:47221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ec8J0-0008Bc-PO
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ec8Iz-000619-Dt
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:24:26 -0500
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:45249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1ec8Iz-00060U-7x
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:24:25 -0500
Received: by mail-io0-x233.google.com with SMTP id p188so11706891ioe.12
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 03:24:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118104916.GF19695@redhat.com>
References: <CAKXe6SJtWUFY8hN=dXzFCzztcsGkWbNx+1WZba05Rp3TqO_38w@mail.gmail.com>
	<20180118104916.GF19695@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Jan 2018 19:23:44 +0800
Message-ID: <CAKXe6SJH7pOvTkKSqd9kaU5FsQySCKxGLmb+GJsDu1zzcvbJwQ@mail.gmail.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

2018-01-18 18:49 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Thu, Jan 18, 2018 at 06:38:57PM +0800, Li Qiang wrote:
> > Hi Paolo, all,
> >
> > I have a question about the intel microcode update for spectre variant#2.
> > From my understanding, there is no need to update the microcode of VMs
> > because the kvm has expose the SPEC_CTL and PRED_CMD to the guest.
> > Also, if we need to update the micorcode in guest, who is the vendor for
> > this.
> > From the hyper-v, I think I'm right.
> > -->
> > https://docs.microsoft.com/en-us/virtualization/hyper-v-on-
> windows/CVE-2017-5715-and-hyper-v-vms
> >
> > But upon I update the centos guest, the host kvm/qemu has been updated.
> > The IBPB_ENABLED and IBRS_ENABLED are both zero if I don't update the
> > microcode in the guest.
> > If I update the guest micorcode, the are both 1.
> >
> > So I want to know, if I should update the microcode in guest.
> > If the answer is Yes, then what about the Windows guest, how to update
> the
> > microcode?
>
> Microcode updates are only applicable to the physical CPUs seen by the
> host. There is no concept of microcde for virtual CPUs in the guest. The
> guest merely sees whatever CPU feature the hypervisor has permitted it to
> see. IOW, as described in that microsoft link, you need to
>
>  - Update microcode and/or firmware in host
>  - Update host hypervisor software
>  - Change hypervisor config for each guest to enable new CPU features
>  - Update guest software (kernel)
>  - Cold boot (ie fully shutoff, and then power on) the guest
>
>
You are right. I have made a mistake, the test guest centos doesn't
schedule to the host which I have updated the kvm/qemu.
Thanks!

Li Qiang


> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
