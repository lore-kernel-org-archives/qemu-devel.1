Received: from eggs.gnu.org ([2001:4830:134:3::10]:45223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dbBjB-0002di-VX
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dbBj9-0004B4-QV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:19:17 -0400
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:37053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dbBj9-0004A4-JR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:19:15 -0400
Received: by mail-ua0-x22d.google.com with SMTP id f9so171890424uaf.4
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 13:19:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170728194543.GA20726@linux.intel.com>
References: <20170728180446.GA31104@linux.intel.com>
	<CAPcyv4i5YWK6RHYEkH6C1oPWwhPLOD-atmkMVXDXc-qdv_0hgw@mail.gmail.com>
	<20170728194543.GA20726@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jul 2017 13:19:11 -0700
Message-ID: <CAPcyv4i9nY8tjx_AuqHGZ4bRvazao=-u+r+O9mvkw1vdR0Dacg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU NVDIMM as type 7 in e820 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Linda Knippers <linda.knippers@hpe.com>, "Kani,
	Toshimitsu" <toshi.kani@hpe.com>

On Fri, Jul 28, 2017 at 12:45 PM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Fri, Jul 28, 2017 at 11:11:10AM -0700, Dan Williams wrote:
>> On Fri, Jul 28, 2017 at 11:04 AM, Ross Zwisler
[..]
> [ Adding Linda & Toshi to see if they have an opinion. ]
>
> I guess maybe we don't need it.  Yep, /proc/iomem looks good:
>
>   # cat /proc/iomem
>   00000000-00000fff : Reserved
>   00001000-0009fbff : System RAM
>   ...
>   100000000-23fffffff : System RAM
>   240000000-a3fffffff : Persistent Memory
>     240000000-a3fffffff : namespace0.0
>
> I was just worried that this was an inconsistency between the way that virtual
> NVDIMMs are presented vs the way that they will be presented on bare metal.  I
> at least look at the e820 table to get my bearings of how memory is laid out -
> maybe I just need to look at /proc/iomem instead?

I don't think e820 matters as long as /proc/iomem ends up correct, and
the effective type is "reserved" . There's nothing in the
specification that requires the OS to validate e820 ranges vs NFIT.
