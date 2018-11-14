Received: from eggs.gnu.org ([2001:4830:134:3::10]:38118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMups-00054E-1B
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMupn-0006Hj-VW
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:03:59 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMupn-0006H0-Pk
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:03:55 -0500
Received: by mail-wr1-x442.google.com with SMTP id j10so2987080wru.4
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:03:55 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-4-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-4-cota@braap.org>
Date: Wed, 14 Nov 2018 13:03:53 +0000
Message-ID: <874lcjerpi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 03/48] tcg/README: fix typo
 s/afterwise/afterwards/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Afterwise is "wise after the fact", as in "hindsight".
> Here we meant "afterwards" (as in "subsequently"). Fix it.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/README b/tcg/README
> index d22ee084b8..3fa8a7059f 100644
> --- a/tcg/README
> +++ b/tcg/README
> @@ -101,7 +101,7 @@ This can be overridden using the following function m=
odifiers:
>    canonical locations before calling the helper.
>  - TCG_CALL_NO_WRITE_GLOBALS means that the helper does not modify any gl=
obals.
>    They will only be saved to their canonical location before calling hel=
pers,
> -  but they won't be reloaded afterwise.
> +  but they won't be reloaded afterwards.
>  - TCG_CALL_NO_SIDE_EFFECTS means that the call to the function is remove=
d if
>    the return value is not used.


--
Alex Benn=C3=A9e
