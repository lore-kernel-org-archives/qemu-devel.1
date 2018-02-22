Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoyx9-0002st-MI
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoyx5-0007Bw-Hn
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:02:59 -0500
References: <20180222215838.18223-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f96c8383-6cea-6b27-3b9c-e84568bbef88@redhat.com>
Date: Thu, 22 Feb 2018 16:02:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180222215838.18223-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Exempt long URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org

On 02/22/2018 03:58 PM, Eric Blake wrote:
> Sometimes, we want to refer to really long URLs, but checkpatch
> balks, and we have to manually bypass the check.  URL shorterners

s/shorterners/shorteners/

(Is it bad when I spell-check my own patches?)

> may be nice at reducing long links, but it's hard to guarantee the
> shortened link will live as long as the real target, and it is
> also nice to see the original target without having to load the
> shortened URL through a browser.  So exempt a line containing
> only a URL from the long-line syntax check.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
