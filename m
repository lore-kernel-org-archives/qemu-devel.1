Received: from eggs.gnu.org ([2001:4830:134:3::10]:34036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dekST-0006d0-GG
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dekSO-0002jV-HF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dekSO-0002bw-3j
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:00:40 -0400
Date: Mon, 7 Aug 2017 10:00:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170807100025.27221aa8@w520.home>
In-Reply-To: <CAMxP3BT8Zps6Bp6kEcV+nYHQvncco5f_BQ9O=fTMUckUZz6Ymg@mail.gmail.com>
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
	<CAMxP3BT8Zps6Bp6kEcV+nYHQvncco5f_BQ9O=fTMUckUZz6Ymg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Bob Chen <a175818323@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

On Mon, 7 Aug 2017 21:04:16 +0800
Bob Chen <a175818323@gmail.com> wrote:

> Besides, I checked the lspci -vvv output, no capabilities of Access Control
> are seen.

Are these switches onboard an NVIDIA card or are they separate
components?  The examples I have on NVIDIA cards do include ACS:

+-02.0-[42-47]----00.0-[43-47]--+-08.0-[44]----00.0  NVIDIA Corporation GK107GL [GRID K1]
                                +-09.0-[45]----00.0  NVIDIA Corporation GK107GL [GRID K1]
                                +-10.0-[46]----00.0  NVIDIA Corporation GK107GL [GRID K1]
                                \-11.0-[47]----00.0  NVIDIA Corporation GK107GL [GRID K1]

# lspci -vvvs 43: | grep -A 2 "Access Control Services"
	Capabilities: [f24 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
--
	Capabilities: [f24 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
--
	Capabilities: [f24 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
--
	Capabilities: [f24 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-

+-03.0-[04-07]----00.0-[05-07]--+-08.0-[06]----00.0  NVIDIA Corporation GM204GL [Tesla M60]
                                \-10.0-[07]----00.0  NVIDIA Corporation GM204GL [Tesla M60]

# lspci -vvvs 5: | grep -A 2 "Access Control Services"
	Capabilities: [f24 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
--
	Capabilities: [f24 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-

Without ACS on the downstream switch ports, the GPUs sharing the switch
will be in the same IOMMU group and we have no ability to control
anything about the routing between downstream ports.  Thanks,

Alex
