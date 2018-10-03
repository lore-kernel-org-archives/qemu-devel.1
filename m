Received: from eggs.gnu.org ([2001:4830:134:3::10]:40407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gme-00059A-CC
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gmZ-0000JS-8D
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:01:44 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:51313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7gmZ-0000J6-1e
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:01:39 -0400
Received: by mail-wm1-f48.google.com with SMTP id 143-v6so5618674wmf.1
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 06:01:38 -0700 (PDT)
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-8-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1dbd44e8-0288-a13f-8f9c-3ca2bbafd3f4@redhat.com>
Date: Wed, 3 Oct 2018 15:01:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/12] tests/qom-proplist: check
 duplicate "bv" property registration failed
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
> "bv" is already a class property.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/check-qom-proplist.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 92898e1520..0f6d9c1ce3 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -125,10 +125,13 @@ static char *dummy_get_sv(Object *obj,
>  
>  static void dummy_init(Object *obj)
>  {
> +    Error *err = NULL;
> +
>      object_property_add_bool(obj, "bv",
>                               dummy_get_bv,
>                               dummy_set_bv,
> -                             NULL);
> +                             &err);
> +    error_free_or_abort(&err);
>  }
>  
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
