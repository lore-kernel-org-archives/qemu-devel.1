Received: from eggs.gnu.org ([2001:4830:134:3::10]:44098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJLAz-0003ee-Ul
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJLAw-00068R-6N
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:18:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJLAv-00068F-W5
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:18:26 -0500
References: <20171127145936.15676-1-linzhecheng@huawei.com>
	<20171127150852.GO32413@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f6b7370a-c4b9-2289-42b3-41bceefad634@redhat.com>
Date: Mon, 27 Nov 2017 16:18:21 +0100
MIME-Version: 1.0
In-Reply-To: <20171127150852.GO32413@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] thread: move detach_thread from creating
 thread to created thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com

On 27/11/2017 16:08, Daniel P. Berrange wrote:
> We should just do
> 
>     if (mode == QEMU_THREAD_DETACHED) {
>         pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
>     }
> 

This is true, but Zhecheng's patch (when fixed---see patchew's report)
would also fix a similar race on pthread_setname_np, so I think it's
fine to introduce qemu_thread_start.

Thanks,

Paolo
