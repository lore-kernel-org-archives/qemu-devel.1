Received: from eggs.gnu.org ([2001:4830:134:3::10]:58785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1D29-00066A-8i
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1D28-0007ef-1g
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:26:09 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1D27-0007cl-PB
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:26:07 -0400
Received: by mail-wm0-x229.google.com with SMTP id r190so49911038wme.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 07:26:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3dd852ae-3ff9-0b53-11f1-ea4e2a3ed59c@amsat.org>
References: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
	<1491844419-12485-8-git-send-email-peter.maydell@linaro.org>
	<3dd852ae-3ff9-0b53-11f1-ea4e2a3ed59c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 15:25:46 +0100
Message-ID: <CAFEAcA8HeZXitVwpuTG5j2LCxxYt5Tp-kLAuTnTzMqK5fN=+Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/9] arm: Track M profile handler mode
 state in TB flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>

On 17 April 2017 at 05:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 04/10/2017 02:13 PM, Peter Maydell wrote:
>> --- a/target/arm/translate.h
>> +++ b/target/arm/translate.h
>> @@ -31,6 +31,7 @@ typedef struct DisasContext {
>>      bool vfp_enabled; /* FP enabled via FPSCR.EN */
>>      int vec_len;
>>      int vec_stride;
>> +    bool handler; /* v7M Handler mode */
>
>
> What about a more descriptive name like 'is_v7m_handler_mode' or
> 'v7m_mode_handler'? It makes your next patch easier to understand:

Seems reasonable; I've made that change (but won't repost the
series as that's the only tweak).

thanks
-- PMM
