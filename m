Received: from eggs.gnu.org ([2001:4830:134:3::10]:53682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZMK0-0001bo-AR
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZMJz-0008JD-Js
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:50:32 -0500
References: <20181102151152.288399-1-vsementsov@virtuozzo.com>
	<20181102151152.288399-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bdb0c306-763c-82ee-c168-93edb8c763b8@redhat.com>
Date: Tue, 18 Dec 2018 14:50:22 -0600
MIME-Version: 1.0
In-Reply-To: <20181102151152.288399-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] error: add error_get_hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 11/2/18 10:11 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add a function to export error hint - a pair to error_get_pretty. It's
> needed to handle errors by hand, where we can't just report it or
> propagate.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/qapi/error.h | 5 +++++
>   util/error.c         | 5 +++++
>   2 files changed, 10 insertions(+)

I'll have to see how this is used before agreeing to it, but the code 
itself is fine if the series does indeed warrant it.  I wouldn't mind 
Markus chiming in on the topic, either.

Reviewed-by: Eric Blake <eblake@redhat.com>

>   
> +const char *error_get_hint(const Error *err)
> +{
> +    return err->hint ? err->hint->str : NULL;
> +}
> +
>   void error_report_err(Error *err)
>   {
>       error_report("%s", error_get_pretty(err));
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
