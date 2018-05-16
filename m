Received: from eggs.gnu.org ([2001:4830:134:3::10]:59696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ44Z-0001tV-Mf
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ44Y-0000qZ-SP
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:34:59 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-9-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bdffad4f-8486-4953-69c7-cb9eb4087baa@redhat.com>
Date: Wed, 16 May 2018 16:34:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180512012537.22478-9-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/12] qjson: allow caller to ask for
 arbitrary indent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 05/11/2018 08:25 PM, John Snow wrote:
> The function already exists, just expose it.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   include/qapi/qmp/qjson.h |  1 +
>   qobject/qjson.c          | 21 +++++++++++----------
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
> index b274ac3a86..0e8624c1fa 100644
> --- a/include/qapi/qmp/qjson.h
> +++ b/include/qapi/qmp/qjson.h
> @@ -19,6 +19,7 @@ QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2);
>   QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
>       GCC_FMT_ATTR(1, 0);
>   
> +QString *qobject_to_json_opt(const QObject *obj, int pretty, int indent);

pretty seems like it is better as a bool.  Even though to_json() isn't 
typed correctly, that's no excuse for the public function to copy a bad 
interface (and maybe it's worth a separate cleanup patch to fix 
to_json() first).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
