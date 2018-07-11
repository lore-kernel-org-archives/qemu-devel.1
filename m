Received: from eggs.gnu.org ([2001:4830:134:3::10]:45435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdIID-0004b2-DM
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdII8-00047x-I0
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:48:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdII8-00047c-AX
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:48:36 -0400
References: <20180710155037.16834-1-stefanha@redhat.com>
	<20180710155037.16834-2-stefanha@redhat.com>
	<20180711172208.288fc0bb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <759f6dde-7350-70b9-1867-d2d1781df16b@redhat.com>
Date: Wed, 11 Jul 2018 18:48:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180711172208.288fc0bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qdev: add HotplugHandler->post_plug()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, l00284672 <lizhengui@huawei.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 11/07/2018 17:22, Igor Mammedov wrote:
> It also seems wrong to call _plug handler on maybe partially
> initialized device so perhaps we should first finish devices/children
> realization then do reset and only after that call _plug() handler

I agree but this is too dangerous until we look at plug() handlers and
remove the usage of Error **.  Introducing a new callback helps the
transition.

Paolo
