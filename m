Received: from eggs.gnu.org ([2001:4830:134:3::10]:36197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ec7bf-0004y9-TT
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ec7be-0007YS-UA
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:39:39 -0500
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:39758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1ec7be-0007YB-Oi
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:39:38 -0500
Received: by mail-io0-x22d.google.com with SMTP id b198so21670709iof.6
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 02:39:38 -0800 (PST)
MIME-Version: 1.0
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Jan 2018 18:38:57 +0800
Message-ID: <CAKXe6SJtWUFY8hN=dXzFCzztcsGkWbNx+1WZba05Rp3TqO_38w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Do I need update the microcode of virtual machine
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

Hi Paolo, all,

I have a question about the intel microcode update for spectre variant#2.
>From my understanding, there is no need to update the microcode of VMs
because the kvm has expose the SPEC_CTL and PRED_CMD to the guest.
Also, if we need to update the micorcode in guest, who is the vendor for
this.
>From the hyper-v, I think I'm right.
-->
https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/CVE-2017-5715-and-hyper-v-vms

But upon I update the centos guest, the host kvm/qemu has been updated.
The IBPB_ENABLED and IBRS_ENABLED are both zero if I don't update the
microcode in the guest.
If I update the guest micorcode, the are both 1.

So I want to know, if I should update the microcode in guest.
If the answer is Yes, then what about the Windows guest, how to update the
microcode?


Thanks,
Li Qiang
