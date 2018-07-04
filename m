Received: from eggs.gnu.org ([2001:4830:134:3::10]:57974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fajuS-0008RG-J7
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fajuO-0004Vo-NW
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:41:36 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fajuO-0004VZ-Gr
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:41:32 -0400
Received: by mail-wm0-x241.google.com with SMTP id b188-v6so6560358wme.3
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 08:41:32 -0700 (PDT)
References: <20180704143014.8670-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180704143014.8670-1-f4bug@amsat.org>
Date: Wed, 04 Jul 2018 16:41:30 +0100
Message-ID: <87va9v80ut.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Do not display host compilers
 as cross-compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Daniel_P=20?= =?utf-8?Q?=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> This silent (since d75402b5ee2):
>
>   ./configure
>   [...]
>   NOTE: cross-compilers enabled:  'cc'
>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index b99ebdde24..fbb53ab6bb 100755
> --- a/configure
> +++ b/configure
> @@ -7328,7 +7328,7 @@ echo "QEMU_CFLAGS+=3D$cflags" >> $config_target_mak
>
>  done # for target in $targets
>
> -if test -n "$enabled_cross_compilers"; then
> +if test -n "$target_compiler" -a -n "$enabled_cross_compilers"; then
>      echo
>      echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
>  fi

I had also added:

-    echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
+    echo "NOTE: compilers enabled for TCG tests: $enabled_cross_compilers"

to make things clearer.

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--
Alex Benn=C3=A9e
