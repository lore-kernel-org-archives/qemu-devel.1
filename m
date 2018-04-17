Received: from eggs.gnu.org ([2001:4830:134:3::10]:55700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f8GVB-0007FR-7G
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f8GV8-00077s-5M
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:37:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:31958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f8GV7-00072j-Sd
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:37:46 -0400
Date: Tue, 17 Apr 2018 10:35:39 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180417023539.yweapei6mpvuqxhf@debian>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<20180416074706.GB28904@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416074706.GB28904@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com

On Mon, Apr 16, 2018 at 03:47:06PM +0800, Stefan Hajnoczi wrote:
> On Wed, Apr 11, 2018 at 03:20:27PM +0800, Tiwei Bie wrote:
> > This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> 
> Naming suggestion: "PREFILL_IOTLB" instead of "NEED_ALL_IOTLB".
> 
> I wasn't able to guess what "NEED_ALL_IOTLB" does.  "PREFILL_IOTLB"
> communicates that memory translation will be set up in advance.

By naming it as NEED_ALL_IOTLB, I want to indicate that,
without this, it's hard or impossible for backend to get
all the IOTLBs (because backend needs to meet IOVAs first
before getting the corresponding IOTLBs, and backend can't
tell whether it has met all the IOVAs or not, especially
when dynamic mapping is being used by guest). But with
this feature negotiated, backend will expect to get all
the IOTLBs. But it seems that, the name (NEED_ALL_IOTLB)
isn't good. And thanks for your suggestion! :)

Best regards,
Tiwei Bie
