Received: from eggs.gnu.org ([209.51.188.92]:39729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzM5U-00080q-D2
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzM5T-00013k-Dz
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:51:00 -0500
Date: Thu, 28 Feb 2019 13:50:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190228135054.GE9217@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <4817f5c3b20aedba869608c06e76d11a722f4864.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4817f5c3b20aedba869608c06e76d11a722f4864.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] trivial malloc to g_malloc in thunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>

On Thu, Feb 28, 2019 at 07:12:45PM +0530, Aarushi Mehta wrote:
> Hi
> 
> This is a trivial contribution part of the BiteSizedTasks on the wiki.
> I found this discussion http://git.corpit.ru/?p=qemu.git;a=commit;h=b45c03f585ea9bb1af76c73e82195418c294919d
> on migrating even g_malloc to g_new, is this not appropriate for the same? 
> The wiki can presumably use an update regarding this.

This kind of question should not be in the commit message - it shoudl
go below the '---'

> 
> Signed-off-by: Aarushi <mehta.aaru20@gmail.com>
> ---

....here....

This lets people answer the question, without the question becoming
part of the git history.

>  thunk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/thunk.c b/thunk.c
> index d5d8645cd4..03fb2abab7 100644
> --- a/thunk.c
> +++ b/thunk.c
> @@ -89,7 +89,7 @@ void thunk_register_struct(int id, const char *name, const argtype *types)
>      for(i = 0;i < 2; i++) {
>          offset = 0;
>          max_align = 1;
> -        se->field_offsets[i] = malloc(nb_fields * sizeof(int));
> +        se->field_offsets[i] = g_malloc(nb_fields * sizeof(int));

Yes, this should use g_new0

>          type_ptr = se->field_types;
>          for(j = 0;j < nb_fields; j++) {
>              size = thunk_type_size(type_ptr, i);
> -- 
> 2.17.1
> 
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
