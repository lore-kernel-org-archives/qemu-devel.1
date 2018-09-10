Received: from eggs.gnu.org ([2001:4830:134:3::10]:53326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzIEt-0000GV-2H
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzIEp-0000lm-5G
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:12:11 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzIEo-0000lE-Ud
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:12:07 -0400
Received: by mail-wm0-x242.google.com with SMTP id j192-v6so20654607wmj.1
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 02:12:06 -0700 (PDT)
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-4-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180903171831.15446-4-cota@braap.org>
Date: Mon, 10 Sep 2018 10:12:04 +0100
Message-ID: <87ftyhd8d7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] atomic: fix comment s/x64_64/x86_64/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index 9ed39effd3..de3e36f400 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -98,7 +98,7 @@
>   * We'd prefer not want to pull in everything else TCG related, so handle
>   * those few cases by hand.
>   *
> - * Note that x32 is fully detected with __x64_64__ + _ILP32, and that for
> + * Note that x32 is fully detected with __x86_64__ + _ILP32, and that for
>   * Sparc we always force the use of sparcv9 in configure.
>   */
>  #if defined(__x86_64__) || defined(__sparc__)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
