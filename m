Received: from eggs.gnu.org ([2001:4830:134:3::10]:40732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gnJ-0005gy-BJ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gnF-0000kC-6i
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:24 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:39123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7gnE-0000iy-Uc
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:21 -0400
Received: by mail-wr1-f53.google.com with SMTP id 61-v6so5306810wrb.6
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 06:02:19 -0700 (PDT)
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-11-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <297543cb-38e3-b5a9-1574-ee434178cfdb@redhat.com>
Date: Wed, 3 Oct 2018 15:02:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/12] vl: handle -object help
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
> List the user creatable objects.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  vl.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/vl.c b/vl.c
> index 5ba06adf78..71765a2982 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2731,6 +2731,19 @@ static int machine_set_property(void *opaque,
>   */
>  static bool object_create_initial(const char *type)
>  {
> +    if (is_help_option(type)) {
> +        GSList *l, *list;
> +
> +        printf("List of user creatable objects:\n");
> +        list = object_class_get_list_sorted(TYPE_USER_CREATABLE, false);
> +        for (l = list; l != NULL; l = l->next) {
> +            ObjectClass *oc = OBJECT_CLASS(l->data);
> +            printf("%s\n", object_class_get_name(oc));
> +        }
> +        g_slist_free(list);
> +        exit(0);
> +    }
> +
>      if (g_str_equal(type, "rng-egd") ||
>          g_str_has_prefix(type, "pr-manager-")) {
>          return false;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
