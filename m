Received: from eggs.gnu.org ([209.51.188.92]:35034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjkKa-0001wB-HX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjkKY-0004Yi-O6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:30:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjkKY-0004Nq-Gz
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:30:02 -0500
Date: Wed, 16 Jan 2019 13:29:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190116132953.404247ec@redhat.com>
In-Reply-To: <4c0d5fdb-7bf7-81ca-77c3-c387bd40ab3f@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-12-git-send-email-imammedo@redhat.com>
	<4c0d5fdb-7bf7-81ca-77c3-c387bd40ab3f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/14] tests: acpi: add AVMF firmware blobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On Tue, 15 Jan 2019 21:47:49 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 01/15/19 16:41, Igor Mammedov wrote:
> > Add firmware blobs built with PcdAcpiTestSupport=TRUE,
> > that puts RSDP address in RAM after 1Mb aligned GUID
> >   AB87A6B1-2034-BDA0-71BD-375007757785
> > so that tests could scan and find it in RAM once firmware's
> > initialized ACPI tables.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  Makefile              |   3 ++-
> >  pc-bios/avmf.img      | Bin 0 -> 2097152 bytes
> >  pc-bios/avmf_vars.img | Bin 0 -> 786432 bytes
> >  3 files changed, 2 insertions(+), 1 deletion(-)
> >  create mode 100644 pc-bios/avmf.img
> >  create mode 100644 pc-bios/avmf_vars.img  
> 
> "AVMF" is not a great name. "AAVMF" is a downstream name alright, but
> many dislike it in upstream use. "edk2-aarch64" or "edk2-ArmVirtQemu"
> would be more precise, but those are verbose. Sigh, why are names so
> hard. What does everyone think?
I'm fine with either version.
 
> Also, do you have to care about the license of firmware images built
> from edk2 when bundling such images? Since edk2 commit 9a67ba261fe9
> ("ArmVirtPkg: Replace obsoleted network drivers from platform DSC/FDF.",
> 2018-12-14), you cannot build the ArmVirtQemu (aka AAVMF) firmware
> without OpenSSL. Thus, the resultant license is 2-BSDL + OpenSSL -- for
> now anyway.
> 
> Because, in the near future, that might change again. edk2 is in the
> process of moving to Apache-2.0, and OpenSSL will also move (AFAICT) to
> Apache-2.0 starting with release 3.0.0. (See commit 151333164ece,
> "Change license to the Apache License v2.0", 2018-12-06.)
That's another reason to look into EFI app approach (a simple one without
dependencies) ans let distro to provide firmware image.

> Thanks
> Laszlo
