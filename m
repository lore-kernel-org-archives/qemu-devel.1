Received: from eggs.gnu.org ([2001:4830:134:3::10]:39807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gk3-0003na-LR
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gk0-0007UQ-9E
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:59:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7gk0-0007To-2W
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:59:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so5532601wme.3
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 05:59:00 -0700 (PDT)
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-6-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <299fffa7-e7af-d672-d4b9-356b950abc30@redhat.com>
Date: Wed, 3 Oct 2018 14:58:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/12] qom/object: fix iterating
 properties over a class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 07/09/2018 09:59, Marc-André Lureau wrote:
> object_class_property_iter_init() starts from the given class, so the
> next class should continue with the parent class.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 75d1d48944..d8666de3f2 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1108,7 +1108,7 @@ void object_class_property_iter_init(ObjectPropertyIterator *iter,
>                                       ObjectClass *klass)
>  {
>      g_hash_table_iter_init(&iter->iter, klass->properties);
> -    iter->nextclass = klass;
> +    iter->nextclass = object_class_get_parent(klass);
>  }
>  
>  ObjectProperty *object_class_property_find(ObjectClass *klass, const char *name,
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
