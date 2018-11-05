Received: from eggs.gnu.org ([2001:4830:134:3::10]:57131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJh5i-00040O-A2
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJh4X-00009G-0f
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:45:49 -0500
References: <20181103015821.30074-1-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d264678-088e-76d6-fa37-3613c89bbd86@redhat.com>
Date: Mon, 5 Nov 2018 09:45:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181103015821.30074-1-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] include: Add a comment to explain the
 origin of sizes' lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/2/18 8:58 PM, Leonid Bloch wrote:
> The lookup table for power-of-two sizes was added in commit 540b8492618eb
> for the purpose of having convenient shortcuts for these sizes in cases
> when the literal number has to be present at compile time, and
> expressions as '(1 * KiB)' can not be used. One such case is the
> stringification of sizes. Beyond that, it is convenient to use these
> shortcuts for all power-of-two sizes, even if they don't have to be
> literal numbers.
> 
> Despite its convenience, this table introduced 55 lines of "dumb" code,
> the purpose and origin of which are obscure without reading the message
> of the commit which introduced it. This patch fixes that by adding a
> comment to the code itself with a brief explanation for the reasoning
> behind this table. This comment includes the short AWK script that
> generated the table, so that anyone who's interested could make sure
> that the values in it are correct (otherwise these values look as if
> they were typed manually).
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>   include/qemu/units.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

I'm still not completely sold that we can't come up with a more elegant 
runtime solution that avoids the need for hard-coding stringified 
defaults at compile time; but if we keep these S_* constants, this 
comment definitely helps.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
