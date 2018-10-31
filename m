Received: from eggs.gnu.org ([2001:4830:134:3::10]:38309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHqTb-0007SU-Gt
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHqTa-0004ZW-Nm
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:24:03 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHqTa-0004Ys-Io
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:24:02 -0400
Received: by mail-ot1-x341.google.com with SMTP id k9so14474103otl.10
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 06:24:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <154093302393.20054.12233984835977061096@sif>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
	<CAFEAcA9czM5qCtj3F_QAhS8dP7yQog-9eD8dGP0qaSeOZ_hang@mail.gmail.com>
	<154093302393.20054.12233984835977061096@sif>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Oct 2018 13:23:40 +0000
Message-ID: <CAFEAcA8MMfS6cFiitqxKT6JG6u6qU9T6kcL_Qq+vXrCgKg2JEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/24] qemu-ga patch queue for soft-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 October 2018 at 20:57, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Sorry for the breakage. Static is indeed useful for qemu-ga, but libudev
> isn't a hard dependency for qemu-ga so we can get away with simply
> disabling libudev for static builds. Would the following (squashed into
> patch 04/24) be acceptable? This fixes static qemu-ga builds for me for
> both Ubuntu 18.04 and FC27. I'll go ahead submit a v2 shortly since it
> may be late for you:
>
> --- a/configure
> +++ b/configure
> @@ -5608,7 +5608,7 @@ fi
>  ##########################################
>  # Do we have libudev
>  if test "$libudev" != "no" ; then
> -  if $pkg_config libudev; then
> +  if $pkg_config libudev && test "$static" != "yes"; then
>      if test "$static" != "yes"; then

Now you've ruled out 'static' in the outer if, this
inner if can never be false...

>        libudev="yes"
>        libudev_libs=$($pkg_config --libs libudev)

thanks
-- PMM
