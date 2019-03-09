Received: from eggs.gnu.org ([209.51.188.92]:53506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2dLA-0001Mm-B3
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2dL0-0004cy-8Y
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:52:36 -0500
References: <a09acf9e093c09a70896bb9886370cf7f049f941.camel@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <740a3074-e0ff-1331-ff07-05635d7e0edc@vivier.eu>
Date: Sat, 9 Mar 2019 15:52:24 +0100
MIME-Version: 1.0
In-Reply-To: <a09acf9e093c09a70896bb9886370cf7f049f941.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] thunk: improve readability
 of allocation loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>

On 08/03/2019 20:43, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  thunk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/thunk.c b/thunk.c
> index 17f3d320bb..7f31cffe09 100644
> --- a/thunk.c
> +++ b/thunk.c
> @@ -86,7 +86,7 @@ void thunk_register_struct(int id, const char *name, const argtype *types)
>  #endif
>      /* now we can alloc the data */
>  
> -    for(i = 0;i < 2; i++) {
> +    for (i = 0; i < ARRAY_SIZE(se->field_offsets); i++) {
>          offset = 0;
>          max_align = 1;
>          se->field_offsets[i] = g_new(int, nb_fields);
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
