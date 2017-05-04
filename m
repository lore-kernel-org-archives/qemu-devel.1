Received: from eggs.gnu.org ([2001:4830:134:3::10]:60828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6AqL-0005Bk-5Y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6AqI-0006PN-2Q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:06:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6AqH-0006PA-SL
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:06:26 -0400
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
	<e186ce8d-52fc-3eca-1343-1a2f18331a76@redhat.com>
	<ff732c49-de24-eebd-ae8e-2de00281f211@gmail.com>
	<878cbc47-316c-d508-a5a3-22029dee2203@redhat.com>
	<9af959d5-23c2-abd4-6100-577755239d2f@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71ca0408-4ec3-938c-2899-a4aa02ed3ab5@redhat.com>
Date: Thu, 4 May 2017 09:06:18 +0200
MIME-Version: 1.0
In-Reply-To: <9af959d5-23c2-abd4-6100-577755239d2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 04/05/2017 05:36, Xiao Guangrong wrote:
> Great.
> 
> As there is no conflict between these two patchsets except dirty
> ring pages takes benefit from write-protect-all, i think they
> can be developed and iterated independently, right?

I can certainly start reviewing this one.

Paolo

> Or you prefer to merge dirty ring pages first then review the
> new version of this patchset later?
