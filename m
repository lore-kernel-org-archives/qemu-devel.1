Received: from eggs.gnu.org ([2001:4830:134:3::10]:54753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dezXB-0004c8-Kb
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dezX9-0006Bf-0Q
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:06:37 -0400
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:36131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1dezX8-0006BL-QB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:06:34 -0400
Received: by mail-it0-x231.google.com with SMTP id 77so342598itj.1
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 01:06:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMxP3BS+088_zjKMJeC0_g=sXiGqGPdj3UFD74URGFgef29kXA@mail.gmail.com>
References: <4E0AFA5F-44D6-4624-A99F-68A7FE52F397@meituan.com>
	<4b31a711-a52e-25d3-4a7c-1be8521097d9@redhat.com>
	<F99BFE80-FC15-40A0-BB3E-1B53B6CF9B05@meituan.com>
	<859362e8-0d98-3865-8bad-a15bfa218167@redhat.com>
	<20170726092931.0678689e@w520.home>
	<20170726190348-mutt-send-email-mst@kernel.org>
	<20170726113222.52aad9a6@w520.home>
	<CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
	<20170731234626.7664be18@w520.home>
	<CAMxP3BTfMad-ycWHqmW+aVM7rv2CJSv-dmEFUveGBqAWvfbBjQ@mail.gmail.com>
	<20170801090158.35d18f10@w520.home>
	<CAMxP3BRkzXBRPZw9fpCu-w4Fusn6ng_knk1cAz=EDBAiw9UnqA@mail.gmail.com>
	<20170807095224.5438ef8c@w520.home>
	<CAMxP3BS+088_zjKMJeC0_g=sXiGqGPdj3UFD74URGFgef29kXA@mail.gmail.com>
From: Bob Chen <a175818323@gmail.com>
Date: Tue, 8 Aug 2017 16:06:33 +0800
Message-ID: <CAMxP3BQsM3gEDndudKQEZ7nNZ=eT9QUU-Yqi+pu-guJL9o1eow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] =?utf-8?q?About_virtio_device_hotplug_in_Q35!_?=
	=?utf-8?b?44CQ5aSW5Z+f6YKu5Lu2LuiwqOaFjuafpemYheOAkQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

Plus:

1 GB hugepages neither improved bandwidth nor latency. Results remained the
same.

2017-08-08 9:44 GMT+08:00 Bob Chen <a175818323@gmail.com>:

> 1. How to test the KVM exit rate?
>
> 2. The switches are separate devices of PLX Technology
>
> # lspci -s 07:08.0 -nn
> 07:08.0 PCI bridge [0604]: PLX Technology, Inc. PEX 8747 48-Lane, 5-Port
> PCI Express Gen 3 (8.0 GT/s) Switch [10b5:8747] (rev ca)
>
> # This is one of the Root Ports in the system.
> [0000:00]-+-00.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon
> D DMI2
>              +-01.0-[01]----00.0  LSI Logic / Symbios Logic MegaRAID SAS
> 2208 [Thunderbolt]
>              +-02.0-[02-05]--
>              +-03.0-[06-09]----00.0-[07-09]--+-08.0-[08]--+-00.0  NVIDIA
> Corporation GP102 [TITAN Xp]
>              |                               |            \-00.1  NVIDIA
> Corporation GP102 HDMI Audio Controller
>              |                               \-10.0-[09]--+-00.0  NVIDIA
> Corporation GP102 [TITAN Xp]
>              |                                            \-00.1  NVIDIA
> Corporation GP102 HDMI Audio Controller
>
>
>
>
> 3. ACS
>
> It seemed that I had misunderstood your point? I finally found ACS
> information on switches, not on GPUs.
>
> Capabilities: [f24 v1] Access Control Services
> ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl+ DirectTrans+
> ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+
> EgressCtrl- DirectTrans-
>
>
>
> 2017-08-07 23:52 GMT+08:00 Alex Williamson <alex.williamson@redhat.com>:
>
>> On Mon, 7 Aug 2017 21:00:04 +0800
>> Bob Chen <a175818323@gmail.com> wrote:
>>
>> > Bad news... The performance had dropped dramatically when using emulated
>> > switches.
>> >
>> > I was referring to the PCIe doc at
>> > https://github.com/qemu/qemu/blob/master/docs/pcie.txt
>> >
>> > # qemu-system-x86_64_2.6.2 -enable-kvm -cpu host,kvm=off -machine
>> > q35,accel=kvm -nodefaults -nodefconfig \
>> > -device ioh3420,id=root_port1,chassis=1,slot=1,bus=pcie.0 \
>> > -device x3130-upstream,id=upstream_port1,bus=root_port1 \
>> > -device
>> > xio3130-downstream,id=downstream_port1,bus=upstream_port1,
>> chassis=11,slot=11
>> > \
>> > -device
>> > xio3130-downstream,id=downstream_port2,bus=upstream_port1,
>> chassis=12,slot=12
>> > \
>> > -device vfio-pci,host=08:00.0,multifunction=on,bus=downstream_port1 \
>> > -device vfio-pci,host=09:00.0,multifunction=on,bus=downstream_port2 \
>> > -device ioh3420,id=root_port2,chassis=2,slot=2,bus=pcie.0 \
>> > -device x3130-upstream,id=upstream_port2,bus=root_port2 \
>> > -device
>> > xio3130-downstream,id=downstream_port3,bus=upstream_port2,
>> chassis=21,slot=21
>> > \
>> > -device
>> > xio3130-downstream,id=downstream_port4,bus=upstream_port2,
>> chassis=22,slot=22
>> > \
>> > -device vfio-pci,host=89:00.0,multifunction=on,bus=downstream_port3 \
>> > -device vfio-pci,host=8a:00.0,multifunction=on,bus=downstream_port4 \
>> > ...
>> >
>> >
>> > Not 8 GPUs this time, only 4.
>> >
>> > *1. Attached to pcie bus directly (former situation):*
>> >
>> > Unidirectional P2P=Disabled Bandwidth Matrix (GB/s)
>> >    D\D     0      1      2      3
>> >      0 420.93  10.03  11.07  11.09
>> >      1  10.04 425.05  11.08  10.97
>> >      2  11.17  11.17 425.07  10.07
>> >      3  11.25  11.25  10.07 423.64
>> > Unidirectional P2P=Enabled Bandwidth Matrix (GB/s)
>> >    D\D     0      1      2      3
>> >      0 425.98  10.03  11.07  11.09
>> >      1   9.99 426.43  11.07  11.07
>> >      2  11.04  11.20 425.98   9.89
>> >      3  11.21  11.21  10.06 425.97
>> > Bidirectional P2P=Disabled Bandwidth Matrix (GB/s)
>> >    D\D     0      1      2      3
>> >      0 430.67  10.45  19.59  19.58
>> >      1  10.44 428.81  19.49  19.53
>> >      2  19.62  19.62 429.52  10.57
>> >      3  19.60  19.66  10.43 427.38
>> > Bidirectional P2P=Enabled Bandwidth Matrix (GB/s)
>> >    D\D     0      1      2      3
>> >      0 429.47  10.47  19.52  19.39
>> >      1  10.48 427.15  19.64  19.52
>> >      2  19.64  19.59 429.02  10.42
>> >      3  19.60  19.64  10.47 427.81
>> > P2P=Disabled Latency Matrix (us)
>> >    D\D     0      1      2      3
>> >      0   4.50  13.72  14.49  14.44
>> >      1  13.65   4.53  14.52  14.33
>> >      2  14.22  13.82   4.52  14.50
>> >      3  13.87  13.75  14.53   4.55
>> > P2P=Enabled Latency Matrix (us)
>> >    D\D     0      1      2      3
>> >      0   4.44  13.56  14.58  14.45
>> >      1  13.56   4.48  14.39  14.45
>> >      2  13.85  13.93   4.86  14.80
>> >      3  14.51  14.23  14.70   4.72
>> >
>> >
>> > *2. Attached to emulated Root Port and Switches:*
>> >
>> > Unidirectional P2P=Disabled Bandwidth Matrix (GB/s)
>> >    D\D     0      1      2      3
>> >      0 420.48   3.15   3.12   3.12
>> >      1   3.13 422.31   3.12   3.12
>> >      2   3.08   3.09 421.40   3.13
>> >      3   3.10   3.10   3.13 418.68
>> > Unidirectional P2P=Enabled Bandwidth Matrix (GB/s)
>> >    D\D     0      1      2      3
>> >      0 418.68   3.14   3.12   3.12
>> >      1   3.15 420.03   3.12   3.12
>> >      2   3.11   3.10 421.39   3.14
>> >      3   3.11   3.08   3.13 419.13
>> > Bidirectional P2P=Disabled Bandwidth Matrix (GB/s)
>> >    D\D     0      1      2      3
>> >      0 424.36   5.36   5.35   5.34
>> >      1   5.36 424.36   5.34   5.34
>> >      2   5.35   5.36 425.52   5.35
>> >      3   5.36   5.36   5.34 425.29
>> > Bidirectional P2P=Enabled Bandwidth Matrix (GB/s)
>> >    D\D     0      1      2      3
>> >      0 422.98   5.35   5.35   5.35
>> >      1   5.35 423.44   5.34   5.33
>> >      2   5.35   5.35 425.29   5.35
>> >      3   5.35   5.34   5.34 423.21
>> > P2P=Disabled Latency Matrix (us)
>> >    D\D     0      1      2      3
>> >      0   4.79  16.59  16.38  16.22
>> >      1  16.62   4.77  16.35  16.69
>> >      2  16.77  16.66   4.03  16.68
>> >      3  16.54  16.56  16.78   4.08
>> > P2P=Enabled Latency Matrix (us)
>> >    D\D     0      1      2      3
>> >      0   4.51  16.56  16.58  16.66
>> >      1  15.65   3.87  16.74  16.61
>> >      2  16.59  16.81   3.96  16.70
>> >      3  16.47  16.28  16.68   4.03
>> >
>> >
>> > Is it because the heavy load of CPU emulation had caused a bottleneck?
>>
>> QEMU should really not be involved in the data flow, once the memory
>> slots are configured in KVM, we really should not be exiting out to
>> QEMU regardless of the topology.  I wonder if it has something to do
>> with the link speed/width advertised on the switch port.  I don't think
>> the endpoint can actually downshift the physical link, so lspci on the
>> host should probably still show the full bandwidth capability, but
>> maybe the driver is somehow doing rate limiting.  PCIe gets a little
>> more complicated as we go to newer versions, so it's not quite as
>> simple as exposing a different bit configuration to advertise 8GT/s,
>> x16.  Last I tried to do link matching it was deemed too complicated
>> for something I couldn't prove at the time had measurable value.  This
>> might be a good way to prove that value if it makes a difference here.
>> I can't think why else you'd see such a performance difference, but
>> testing to see if the KVM exit rate is significantly different could
>> still be an interesting verification.  Thanks,
>>
>> Alex
>>
>
>
