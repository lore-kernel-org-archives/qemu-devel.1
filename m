Received: from eggs.gnu.org ([2001:4830:134:3::10]:52295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGo1G-0003nr-6W
	for qemu-devel@nongnu.org; Thu, 10 May 2018 12:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGo1F-0004WL-EL
	for qemu-devel@nongnu.org; Thu, 10 May 2018 12:02:14 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-9-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba5e8366-e549-5611-b161-1710fc2f95b5@redhat.com>
Date: Thu, 10 May 2018 11:02:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180509165530.29561-9-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/13] tests: Add
 qdict_stringify_for_keyval() test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/09/2018 11:55 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/check-qdict.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 

> +static void qdict_stringify_for_keyval_test(void)
> +{
> +    QDict *dict = qdict_new();
> +
> +    /*
> +     * Test stringification of:
> +     *
> +     * {
> +     *     "a": "null",
> +     *     "b": 42,
> +     *     "c": -23,
> +     *     "d": false,
> +     *     "e": null,
> +     *     "f": "",
> +     *     "g": 0.5,
> +     *     "h": 0xffffffffffffffff,
> +     *     "i": true,
> +     *     "j": 0

Is it worth testing fun things like '-0.0'?


> +    g_assert(!strcmp(qdict_get_str(dict, "a"), "null"));
> +    g_assert(!strcmp(qdict_get_str(dict, "b"), "42"));
> +    g_assert(!strcmp(qdict_get_str(dict, "c"), "-23"));
> +    g_assert(!strcmp(qdict_get_str(dict, "d"), "off"));
> +    g_assert(qobject_type(qdict_get(dict, "e")) == QTYPE_QNULL);

Is it worth shortening this line to:
g_assert(qobject_to(QNull, qdict_get(dict, "e")));

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
