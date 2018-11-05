Received: from eggs.gnu.org ([2001:4830:134:3::10]:59622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJo2S-0001bz-3l
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJnvm-0002rJ-A8
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:05:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJnvm-0002pj-2j
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 18:05:14 -0500
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
	<1540512223-21199-5-git-send-email-max7255@yandex-team.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c64cbe7-f804-abca-5f55-53dcd4a42022@redhat.com>
Date: Mon, 5 Nov 2018 17:05:11 -0600
MIME-Version: 1.0
In-Reply-To: <1540512223-21199-5-git-send-email-max7255@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 4/4] net/slirp: add ipv6-hostfwd option
 for user netdev type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxim Samoylov <max7255@yandex-team.ru>, qemu-devel@nongnu.org

On 10/25/18 7:03 PM, Maxim Samoylov wrote:
> This allows forwarding TCP6 and UDP6 connections down to
> netdev=user connected guests.
> 
> Signed-off-by: Maxim Samoylov <max7255@yandex-team.ru>
> ---
>   hmp-commands.hx     |  31 ++++++++
>   include/net/slirp.h |   2 +
>   net/slirp.c         | 214 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   qapi/net.json       |   3 +-
>   4 files changed, 249 insertions(+), 1 deletion(-)

> +++ b/qapi/net.json
> @@ -201,7 +201,8 @@
>       '*smbserver': 'str',
>       '*hostfwd':   ['String'],
>       '*guestfwd':  ['String'],
> -    '*tftp-server-name': 'str' } }
> +    '*tftp-server-name': 'str',
> +    '*ipv6-hostfwd': ['String']} }

Missing documentation of the new member.  Don't forget a '(since 3.1)' 
comment (if this is still appropriate for the current release; which may 
be doubtful since we are in soft freeze, in which case it will be 3.2 or 
4.0, depending on what the next release is numbered).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
