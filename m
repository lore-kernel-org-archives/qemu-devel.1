Received: from eggs.gnu.org ([2001:4830:134:3::10]:43186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWI5g-0002B5-Ks
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWI5b-0008JI-Q6
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cWI5b-0008IC-Jv
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:33:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170125052703.23571-1-lma@suse.com>
Date: Wed, 25 Jan 2017 08:33:52 +0100
In-Reply-To: <20170125052703.23571-1-lma@suse.com> (Lin Ma's message of "Wed,
	25 Jan 2017 13:27:03 +0800")
Message-ID: <87lgtztwyn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] qmp: Fix argument name in error message
 of device-list-properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>
Cc: qemu-devel@nongnu.org

Lin Ma <lma@suse.com> writes:

> The argument is called "typename", not "name".
>
> [Thanks to Markus for correcting the commit message]
>
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  qmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qmp.c b/qmp.c
> index 0028f0b..886059e 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -531,12 +531,12 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
>  
>      klass = object_class_dynamic_cast(klass, TYPE_DEVICE);
>      if (klass == NULL) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "name", TYPE_DEVICE);
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename", TYPE_DEVICE);
>          return NULL;
>      }
>  
>      if (object_class_is_abstract(klass)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "name",
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
>                     "non-abstract device type");
>          return NULL;
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
