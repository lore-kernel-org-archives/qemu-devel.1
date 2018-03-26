Received: from eggs.gnu.org ([2001:4830:134:3::10]:51341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0XCd-0003Qp-1C
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0XCb-0006by-Nz
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:50:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180326184147.1565719-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2e720753-9bce-014b-c550-11486ea38051@amsat.org>
Date: Mon, 26 Mar 2018 15:50:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180326184147.1565719-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-2.12] maint: Add
 .mailmap entries for patches claiming list authorship
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org

On 03/26/2018 03:41 PM, Eric Blake wrote:
> The list did not author any patches, but it does rewrite the
> 'From:' header of messages sent from any domain with restrictive
> SPF policies that would otherwise prevent the message from reaching
> all list recipients.  If a maintainer is not careful to undo the
> list header rewrite, and the author did not include a manual
> 'From:' line in the body to fix the munged header, then 'git am'
> happily attributes the patch to the list.  Add some mailmap
> entries to correct the few that have escaped our attention; while
> we also work on improving the tooling to catch the problem in
> the future before a merge is even made.

Thanks!

> 
> Also improve the comments occurring in the file, including line
> length improvements.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
> Probably worth inclusion in 2.12-rc1, since it makes statistics
> about the release easier to follow.
> 
>  .mailmap | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index cf689b9ec99..b02c357e9a1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1,6 +1,7 @@
> -# This mailmap just translates the weird addresses from the original import into git
> -# into proper addresses so that they are counted properly in git shortlog output.
> -#
> +# This mailmap fixes up author names/addresses.
> +
> +# The first section translates weird addresses from the original git import
> +# into proper addresses so that they are counted properly by git shortlog.
>  Andrzej Zaborowski <balrogg@gmail.com> balrog <balrog@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Anthony Liguori <anthony@codemonkey.ws> aliguori <aliguori@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
> @@ -15,10 +16,19 @@ Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
>  Paul Burton <paul.burton@mips.com> <paul@archlinuxmips.org>
>  Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
>  malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
> +
>  # There is also a:
>  #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
>  # for the cvs2svn initialization commit e63c3dc74bf.
> -#
> +
> +# Next, translate a few commits where mailman rewrote the From: line due
> +# to strict SPF, although we prefer to avoid adding more entries like that.
> +Ed Swierk <eswierk@skyportsystems.com> Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>
> +Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu.org>
> +Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
> +Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
> +
> +
>  # Also list preferred name forms where people have changed their
>  # git author config
>  Daniel P. Berrangé <berrange@redhat.com>
> 
