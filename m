Received: from eggs.gnu.org ([2001:4830:134:3::10]:56894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejmif-00085X-Hg
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejmic-0007JQ-ED
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:58:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejmic-0007Iv-8n
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:58:30 -0500
Date: Thu, 8 Feb 2018 15:58:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180208155418-mutt-send-email-mst@kernel.org>
References: <20180205102659.60552-1-marcel@redhat.com>
	<CAFEAcA8OO7jEeAe5UWKBqSb_+tap7OVM2YxEsqWDVZV8jN7cmA@mail.gmail.com>
	<51f8addc-8c6c-4532-1a59-b4c0098f6c68@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f8addc-8c6c-4532-1a59-b4c0098f6c68@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/4] RDMA patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, yuval.shaia@oracle.com, dotanb@mellanox.com

On Thu, Feb 08, 2018 at 03:38:59PM +0200, Marcel Apfelbaum wrote:
> We do not "use" the __u32 types, we just copied a kernel file
> for structures used for communication between the guest driver
> and the QEMU code. We had a look on how it is done and
> we use the model that adds macros __u32 -> uint32_t,
> so the "__types" do not really create such problems.

I don't think this is done like this anywhere in code.
Please take a look at how it's done for e.g. input.h

I think that whenever a rule in HACKING, coding style,
etc is ignored it should be accompanied by motivation
in code comments, so this won't spread out any more.

-- 
MST
