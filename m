Received: from eggs.gnu.org ([2001:4830:134:3::10]:39224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPWIs-0005qM-6x
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPWIr-0003np-Ab
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:51:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1498490724-20674-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6ba872d7-5dcc-f160-beed-a691a02c1d09@amsat.org>
Date: Mon, 26 Jun 2017 12:51:43 -0300
MIME-Version: 1.0
In-Reply-To: <1498490724-20674-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Handle having no c++ compiler
 in FORTIFY_SOURCE check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

On 06/26/2017 12:25 PM, Peter Maydell wrote:
> Our FORTIFY_SOURCE check assumes that $cxx refers to a working C++
> compiler, with the result that if you don't happen to have one
> then configure will spuriously print
>    configure: line 4685: c++: command not found
> 
> Fix this by adding a 'has $cxx' check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index c571ad1..a435908 100755
> --- a/configure
> +++ b/configure
> @@ -4681,7 +4681,7 @@ fi
>   if test "$fortify_source" != "no"; then
>     if echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then
>       fortify_source="no";
> -  elif test -n "$cxx" &&
> +  elif test -n "$cxx" && has $cxx &&
>          echo | $cxx -dM -E - | grep __clang__ >/dev/null 2>&1 ; then
>       fortify_source="no";
>     else
> 
