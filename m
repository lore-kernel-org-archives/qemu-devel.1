Received: from eggs.gnu.org ([2001:4830:134:3::10]:51124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEbso-0007LF-0C
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEbsi-0007x5-Ul
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:08:09 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171110221329.24176-2-mreitz@redhat.com>
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-2-mreitz@redhat.com>
Date: Tue, 14 Nov 2017 15:07:51 +0100
Message-ID: <w517eut0x8o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 1/3] qapi: Add
 qdict_is_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Fri 10 Nov 2017 11:13:27 PM CET, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/qapi/qmp/qdict.h |  1 +
>  qobject/qdict.c          | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index fc218e7be6..c65ebfc748 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -76,6 +76,7 @@ int64_t qdict_get_try_int(const QDict *qdict, const char *key,
>                            int64_t def_value);
>  bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value);
>  const char *qdict_get_try_str(const QDict *qdict, const char *key);
> +bool qdict_is_qnull(const QDict *qdict, const char *key);

I found this name a bit confusing, how about something like
qdict_entry_is_qnull() ?

I'm fine if you want to keep it like this though,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
