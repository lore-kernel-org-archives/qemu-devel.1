Received: from eggs.gnu.org ([2001:4830:134:3::10]:38856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1copUb-0005ih-UM
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1copUb-0002eL-0q
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:52:22 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1copUa-0002e7-QM
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:52:20 -0400
Received: by mail-wm0-x236.google.com with SMTP id n11so12660367wma.0
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 03:52:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489746872-10327-1-git-send-email-thuth@redhat.com>
References: <1489746872-10327-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 10:51:59 +0000
Message-ID: <CAFEAcA_W5Omu73GdN2REwTRXe0K6CtXXrrAiqS4v+UP7WKzeYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] configure: Warn that the support
 for ia64 is going to be removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, "Daniel P. Berrange" <berrange@redhat.com>

On 17 March 2017 at 10:34, Thomas Huth <thuth@redhat.com> wrote:
> Access to an ia64 machine is hard to get these days, and we lack a
> machine for continuous integration testing, so it is very likely
> that we remove support for the ia64 TCG backend soon.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/configure b/configure
> index 99d8bec..3ff8999 100755
> --- a/configure
> +++ b/configure
> @@ -499,6 +499,11 @@ elif check_define __mips__ ; then
>    cpu="mips"
>  elif check_define __ia64__ ; then
>    cpu="ia64"
> +  echo "*** Note: The QEMU Project intends to drop support for ia64 in a near"
> +  echo "*** future release since we do not have a machine for continuous"
> +  echo "*** integration testing. Please get in touch via qemu-devel@nongnu.org"
> +  echo "*** if you want to maintain support and can provide a test machine."
> +  sleep 10
>  elif check_define __s390__ ; then
>    if check_define __s390x__ ; then
>      cpu="s390x"
> --
> 1.8.3.1

I have a more general patch for this that supports marking several
host CPUs and OSes as deprecated. I just haven't posted it yet
because I'm not sure which ones we want to mark as deprecated.

thanks
-- PMM
