Received: from eggs.gnu.org ([2001:4830:134:3::10]:43826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eo40V-0002mH-K5
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eo40U-0004FN-6I
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:14:39 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:37500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eo40U-0004E9-0V
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:14:38 -0500
Received: by mail-oi0-x22c.google.com with SMTP id f186so2005060oig.4
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 01:14:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519113760-4474-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1519113760-4474-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 09:14:16 +0000
Message-ID: <CAFEAcA8GXtEJof8eiakbu3fDh_SafAnS_ywpPi6oXeT3qtQqJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] util/uri.c formating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 20 February 2018 at 08:02, Su Hang <suhang16@mails.ucas.ac.cn> wrote:
>  Formating the code with `clang-format -i util/uri.c`.
>  My .clang-format file content is:
>  '''
>  IndentWidth: 4
>  BreakBeforeBraces: Linux
>  '''
>
> Then use `perl -pi -e "s/return \((.*?)\);/return \1;/g" util/uri.c`
> to remove pattern like this: "return (1);"
>
> checkpatch.pl still rise these two kinds of "ERROR", I'm not sure
> whether I should also suppress these, so I left it.
>
> '''
> ERROR: braces {} are necessary even for single statement blocks
> #1803: FILE: uri.c:1803:
> +            while ((bas->path[cur] != 0) && (bas->path[cur] != '/'))
> +                cur++;
>
> ERROR: braces {} are necessary for all arms of this statement
> #1805: FILE: uri.c:1805:
> +            if (bas->path[cur] == 0)
> [...]
> '''

In some places you have put in extra braces, like here:

> -    if (str == NULL)
> -        return(-1);
> +    if (str == NULL) {
> +        return -1;
> +    }

I think if we're going to reformat the file we might as well
get it checkpatch-clean. Alternatively if you don't want to
fix up the brace style then we needn't touch them at all.

One useful split for format-cleanup patches that you might
consider is to have a patch which contains only whitespace
cleanups, so that 'git show --ignore-all-space' shows no changes.
That makes that patch easy to review. Then changes that do
make non-whitespace changes can go in their own patch, which
is generally smaller and so easier to review by eye.

thanks
-- PMM
