Received: from eggs.gnu.org ([2001:4830:134:3::10]:37441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgD9W-0000Sn-Ol
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgD9U-0007ep-5m
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:18:58 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170221161354.22204-1-berto@igalia.com>
References: <20170221161354.22204-1-berto@igalia.com>
Date: Tue, 21 Feb 2017 17:18:54 +0100
Message-ID: <w5160k3bjpt.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Remove unnecessary cases of
 error_propagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue 21 Feb 2017 05:13:54 PM CET, Alberto Garcia wrote:
>      if (rc && rc != -ENOSYS) {
> -        error_propagate(errp, local_err);
>          return;
>      }
> -    error_free(local_err);
[...]
> -    if (rc && rc != -ENOSYS && rc != -EINPROGRESS) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -    error_free(local_err);
[...]
>      rc = do_open_tray(has_device ? device : NULL,
>                        has_id ? id : NULL,
> -                      false, &err);
> +                      false, errp);
>      if (rc && rc != -ENOSYS) {
> -        error_propagate(errp, err);
>          goto fail;
>      }
> -    error_free(err);
> -    err = NULL;

I just noticed that these three changes are wrong, sorry for the noise!

Berto
