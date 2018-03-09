Received: from eggs.gnu.org ([2001:4830:134:3::10]:45200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOLM-00056U-Ox
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOLI-0007q0-PO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:10:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euOLI-0007pI-DA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:10:16 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-4-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f5a09e8-3f7f-ec3a-3a05-bc37d9bbf8e4@redhat.com>
Date: Fri, 9 Mar 2018 14:10:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 03/23] qobject: introduce
 qobject_get_try_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

On 03/09/2018 02:59 AM, Peter Xu wrote:
> A quick way to fetch string from qobject when it's a QString.
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qapi/qmp/qstring.h |  1 +
>   qobject/qstring.c          | 11 +++++++++++
>   2 files changed, 12 insertions(+)
> 

> +++ b/qobject/qstring.c
> @@ -137,6 +137,17 @@ const char *qstring_get_try_str(const QString *qstring)
>       return qstring ? qstring_get_str(qstring) : NULL;
>   }
>   
> +/**
> + * qobject_get_try_str(): Return a pointer to the corresponding string
> + *
> + * NOTE: the string will only be returned if the object is valid, and
> + * its type is QString, otherwise NULL is returned.
> + */
> +const char *qobject_get_try_str(const QObject *qstring)
> +{
> +    return qstring_get_try_str(qobject_to_qstring(qstring));

Conflicts with Max's refactoring to a qobject_to() macro.
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06230.html

Whoever lands first gets to watch the other (or the maintainer) rebase ;)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
