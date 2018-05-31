Received: from eggs.gnu.org ([2001:4830:134:3::10]:35231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOTSc-0006vu-AK
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOTSY-0006FF-8z
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:42:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOTSY-0006EY-4J
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:42:06 -0400
References: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
	<20180531192237.3994-2-samuel.thibault@ens-lyon.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fa8b7009-5bb1-fe4e-71eb-f9a7652973c3@redhat.com>
Date: Thu, 31 May 2018 14:42:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180531192237.3994-2-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/9] slirp: Add domainname option to slirp's
 DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: jan.kiszka@siemens.com, Benjamin Drung <benjamin.drung@profitbricks.com>, stefanha@redhat.com

On 05/31/2018 02:22 PM, Samuel Thibault wrote:
> From: Benjamin Drung <benjamin.drung@profitbricks.com>
> 
> This patch will allow the user to include the domainname option in
> replies from the built-in DHCP server.
> 
> Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>   net/slirp.c      | 12 +++++++++---
>   qapi/net.json    |  4 ++++
>   qemu-options.hx  |  7 +++++--
>   slirp/bootp.c    |  8 ++++++++
>   slirp/libslirp.h |  2 +-
>   slirp/slirp.c    |  4 +++-
>   slirp/slirp.h    |  1 +
>   7 files changed, 31 insertions(+), 7 deletions(-)

> +++ b/qapi/net.json
> @@ -160,6 +160,9 @@
>   # @dnssearch: list of DNS suffixes to search, passed as DHCP option
>   #             to the guest
>   #
> +# @domainname: guest-visible domain name of the virtual nameserver
> +#              (since 2.12)

This missed 2.12; we'll need a followup patch that updates it to 3.0.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
