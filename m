Received: from eggs.gnu.org ([2001:4830:134:3::10]:60305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eayZH-0001ly-EQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eayZE-0002AQ-Df
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:48:27 -0500
References: <20180115023501.37361-1-aik@ozlabs.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7b942fc7-a061-789a-4223-030d234602ca@redhat.com>
Date: Mon, 15 Jan 2018 07:48:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180115023501.37361-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] configure: Allow capstone=git only if
 git update is not disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 15.01.2018 03:35, Alexey Kardashevskiy wrote:
> Even with --disable-git-update, ./configure tries updating the capstone
> submodule instead of marking it "no"; this disables capstone submodule
> if git update is disabled.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 89bd662..92c21b3 100755
> --- a/configure
> +++ b/configure
> @@ -4502,7 +4502,7 @@ case "$capstone" in
>    "" | yes)
>      if $pkg_config capstone; then
>        capstone=system
> -    elif test -e "${source_path}/.git" ; then
> +    elif test -e "${source_path}/.git" -a $git_update = 'yes' ; then
>        capstone=git
>      elif test -e "${source_path}/capstone/Makefile" ; then
>        capstone=internal
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
