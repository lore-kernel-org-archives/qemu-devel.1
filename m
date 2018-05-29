Received: from eggs.gnu.org ([2001:4830:134:3::10]:56140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNle7-0006wW-5S
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNle6-00038w-CM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:55:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fNle6-00038q-8M
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:55:06 -0400
References: <20180529180813.2647-1-programmingkidx@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9db621f9-f62c-682d-57e0-9760973a4d4b@redhat.com>
Date: Tue, 29 May 2018 15:55:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180529180813.2647-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: Suppress
 NSFileHandlingPanelOKButton depreciation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, patches@linaro.org

On 05/29/2018 01:08 PM, John Arbuckle wrote:

In the subject: s/depreciation/deprecation/

> OSX 10.13 deprecates the NSFileHandlingPanelOKButton constant, and
> would rather you use NSModalResponseOK, which was introduced in OS 10.9.
> Use the recommended new constant name, with a backward compatibility
> define if we're building on an older OSX.
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>   ui/cocoa.m | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
