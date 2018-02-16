Received: from eggs.gnu.org ([2001:4830:134:3::10]:53205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emhjR-0006E2-6j
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emhjM-000753-KV
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:15:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1emhjM-00074l-GQ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:15:20 -0500
References: <20180216125504.25955-1-benjamin.drung@profitbricks.com>
	<20180216125504.25955-2-benjamin.drung@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff0868d2-98c0-a0ee-8139-0367c29a03b1@redhat.com>
Date: Fri, 16 Feb 2018 09:15:11 -0600
MIME-Version: 1.0
In-Reply-To: <20180216125504.25955-2-benjamin.drung@profitbricks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: Add domainname option to
 slirp's DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Drung <benjamin.drung@profitbricks.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel@nongnu.org

On 02/16/2018 06:55 AM, Benjamin Drung wrote:
> This patch will allow the user to include the domainname option in
> replies from the built-in DHCP server.
> 
> Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>
> ---

> +++ b/qapi/net.json
> @@ -160,6 +160,8 @@
>   # @dnssearch: list of DNS suffixes to search, passed as DHCP option
>   #             to the guest
>   #
> +# @domainname: guest-visible domain name of the virtual nameserver
> +#

Missing a '(since 2.12)' tag.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
