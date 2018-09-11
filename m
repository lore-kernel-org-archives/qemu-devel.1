Received: from eggs.gnu.org ([2001:4830:134:3::10]:36558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzmOa-0000Gi-TC
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzmOY-0008PK-8a
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:24:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzmOY-0008Ob-29
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:24:10 -0400
References: <CAKXe6SKtGLjDgh0thEemmoodtPZGKOcepbsJ6m76xhznuP3=VA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28a08ba6-3f7d-5fa1-525b-2790b139c6bb@redhat.com>
Date: Tue, 11 Sep 2018 19:24:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKtGLjDgh0thEemmoodtPZGKOcepbsJ6m76xhznuP3=VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Question] Question about ACPI table in qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, mst@redhat.com, Laszlo Ersek <lersek@redhat.com>, kevin@koconnor.net
Cc: Qemu Developers <qemu-devel@nongnu.org>

On 11/09/2018 18:54, Li Qiang wrote:
> Hi all,
> 
> I noticed that both qemu and seabios create the ACPI table.
> Once I think he bios' ACPI table will overwrite the qemu's if seabios
> compiled with CONFIG_ACPI.

Yes, SeaBIOS's ACPI tables are not used anymore, to remove the need to
update QEMU and SeaBIOS in sync.

> But after I read this -->
> https://lists.gnu.org/archive/html/qemu-devel/2013-02/msg04555.html
> 
> There say:
> 
> "just have QEMU pass the tables to SeaBIOS for it to copy
>>>> into memory like it does on CSM, coreboot, and Xen"
> 
> So where does this 'copy' happens? or is there something others I missed?

The copy happens in SeaBIOS's romfile_loader_execute function (called by
qemu_platform_setup).

Thanks,

Paolo
