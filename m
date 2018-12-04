Received: from eggs.gnu.org ([2001:4830:134:3::10]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUG47-00036c-O1
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUG45-0005Kq-0R
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:09:03 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUG44-0005F3-DJ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:09:00 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so17135400wrt.13
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 11:09:00 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-8-cota@braap.org> <87h8ft3295.fsf@linaro.org>
	<e39db85e-52b5-bdc8-d9a7-e3a14f78ce4b@linaro.org>
	<87ftvd2ycv.fsf@linaro.org> <20181204173138.GA15610@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181204173138.GA15610@flamenco>
Date: Tue, 04 Dec 2018 19:08:57 +0000
Message-ID: <87a7ll2jp2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/13] fpu: introduce hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org


Emilio G. Cota <cota@braap.org> writes:

> On Tue, Dec 04, 2018 at 13:52:16 +0000, Alex Benn=C3=A9e wrote:
>> > We could always
>> >
>> > #ifdef __FAST_MATH__
>> > #error "Silliness like this will get you nowhere"
>> > #endif
>>
>> Emilio, are you happy to add that guard with a suitable pithy comment?
>
> Isn't it better to just disable hardfloat then?
>
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -220,7 +220,7 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
>   * the use of hardfloat, since hardfloat relies on the inexact flag being
>   * already set.
>   */
> -#if defined(TARGET_PPC)
> +#if defined(TARGET_PPC) || defined(__FAST_MATH__)
>  # define QEMU_NO_HARDFLOAT 1
>  # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
>  #else
>
> Or perhaps disable it, as well as issue a #warning?

Issuing the warning is only to tell the user they are being stupid but
yeah certainly disable. Maybe we'll be around when someone comes asking
why maths didn't get faster ;-)

>
> 		E.


--
Alex Benn=C3=A9e
