Received: from eggs.gnu.org ([209.51.188.92]:57556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghXnP-0001dm-J9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghXnO-0005M7-Uu
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:42:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ghXnO-0005Lj-Oy
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:42:42 -0500
Date: Thu, 10 Jan 2019 11:42:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190110114231.19701e02.cohuck@redhat.com>
In-Reply-To: <20190110020259.8492-2-ehabkost@redhat.com>
References: <20190110020259.8492-1-ehabkost@redhat.com>
	<20190110020259.8492-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qom: Don't keep error value between
 object_property_parse() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>

On Thu, 10 Jan 2019 00:02:57 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> When handling errp==NULL at object_apply_global_props(), we are
> leaving the old error value in `err` after printing a warning.
> This makes QEMU crash if two global properties generate warnings:
> 
>   $ echo device_add rtl8139 | qemu-system-x86_64 -monitor stdio -global rtl8139.xxx=yyy -global rtl8139.xxx=zzz
>   warning: can't apply global rtl8139.xxx=yyy: Property '.xxx' not found
>   qemu-system-x86_64: util/error.c:57: error_setv: Assertion `*errp == NULL' failed.
>   Aborted (core dumped)
> 
> Fix that by making `err` go out of scope immediately after the
> warn_report_err() call.
> 
> Fixes: 50545b2cc029 "qdev-props: call object_apply_global_props()"
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
