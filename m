Received: from eggs.gnu.org ([2001:4830:134:3::10]:38630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <raimue@codingfarm.de>) id 1dH648-0006Ot-H1
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 06:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <raimue@codingfarm.de>) id 1dH645-0006Mj-CL
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 06:13:52 -0400
Received: from donkey.codingfarm.de ([5.9.138.198]:43102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <raimue@codingfarm.de>)
	id 1dH645-0006M7-5B
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 06:13:49 -0400
References: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Rainer_M=c3=bcller?= <raimue@codingfarm.de>
Message-ID: <ed2675f7-08f7-5bcd-2ed3-3ecb865e54fe@codingfarm.de>
Date: Sat, 3 Jun 2017 12:13:59 +0200
MIME-Version: 1.0
In-Reply-To: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Define NCURSES_WIDECHAR if
 we're using curses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Chad Joan <chadjoan@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 2017-06-02 16:35, Peter Maydell wrote:
> diff --git a/configure b/configure
> index 0586ec9..6aca5d1 100755
> --- a/configure
> +++ b/configure
> @@ -3053,6 +3053,8 @@ int main(void) {
>  EOF
>    IFS=:
>    for curses_inc in $curses_inc_list; do
> +    # Make sure we get the wide character prototypes
> +    curses_inc="-DNCURSES_WIDECHAR $curses_inc"
>      IFS=:
>      for curses_lib in $curses_lib_list; do
>        unset IFS
> 

Thank you for getting back to this. I can confirm that this patch fixes
--enable-curses for me on Mac OS X.

Although this already works as is, I would use -DNCURSES_WIDECHAR=1 as
ncurses.h uses #if and not #ifdef to check for this.

Rainer
