Received: from eggs.gnu.org ([2001:4830:134:3::10]:36465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eeyGc-0000H7-AN
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 02:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eeyGb-0005Xp-8B
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 02:17:42 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:45940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eeyGb-0005Xb-1c
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 02:17:41 -0500
Received: by mail-wr0-x22a.google.com with SMTP id 16so9898693wry.12
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 23:17:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E860786@SHSMSX104.ccr.corp.intel.com>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
	<20180125142220.GD28396@stefanha-x1.localdomain>
	<D0158A423229094DA7ABF71CF2FA0DA34E860786@SHSMSX104.ccr.corp.intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 26 Jan 2018 07:17:39 +0000
Message-ID: <CAJSP0QXNp7DxVbnmw1OjZWcuY=u-57BSseR78RciiJzUyCqELg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/6] Extend vhost-user to support VFIO
 based accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liang, Cunming" <cunming.liang@intel.com>
Cc: "Bie, Tiwei" <tiwei.bie@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang,
	Xiao W" <xiao.w.wang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Daly, Dan" <dan.daly@intel.com>

On Thu, Jan 25, 2018 at 4:10 PM, Liang, Cunming <cunming.liang@intel.com> wrote:
>> -----Original Message-----
>> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
>> Sent: Thursday, January 25, 2018 10:22 PM
>> To: Bie, Tiwei <tiwei.bie@intel.com>
>> Cc: qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org;
>> mst@redhat.com; alex.williamson@redhat.com; jasowang@redhat.com;
>> pbonzini@redhat.com; stefanha@redhat.com; Tan, Jianfeng
>> <jianfeng.tan@intel.com>; Liang, Cunming <cunming.liang@intel.com>;
>> Wang, Xiao W <xiao.w.wang@intel.com>; Wang, Zhihong
>> <zhihong.wang@intel.com>; Daly, Dan <dan.daly@intel.com>
>> Subject: Re: [Qemu-devel] [PATCH v1 0/6] Extend vhost-user to support
>> VFIO based accelerators
>>
>> On Thu, Jan 25, 2018 at 12:03:22PM +0800, Tiwei Bie wrote:
>> > Why extend vhost-user for vDPA
>> > ==============================
>> >
>> > We have already implemented various virtual switches (e.g. OVS-DPDK)
>> > based on vhost-user for VMs in the Cloud. They are purely software
>> > running on CPU cores. When we have accelerators for such NFVi
>> > applications, it's ideal if the applications could keep using the
>> > original interface (i.e. vhost-user netdev) with QEMU, and
>> > infrastructure is able to decide when and how to switch between CPU
>> > and
>> accelerators within the interface.
>> > And the switching (i.e. switch between CPU and accelerators) can be
>> > done flexibly and quickly inside the applications.
>> >
>> > More details about this can be found from the Cunming's discussions
>> > on the RFC patch set.
>> >
>> > The previous links:
>> > RFC:
>> > http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg04844.htm
>> > l
>>
>> Is vDPA also useful in the simpler use case where there is no NFVi application?
> There're separate patches to have non-DPDK vDPA(aka. vhost-vfio, a new vhost backend proposed) support, which is the scope of stage-II as we mentioned in community call.
> Stay tuned for the RFC patch. Main idea is that the virtio compatible device driver register as a mdev to talk with qemu vhost-vfio.

Thanks!

Stefan
