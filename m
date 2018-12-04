Received: from eggs.gnu.org ([2001:4830:134:3::10]:37927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUB7u-0001Xu-J6
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUB7q-0004Kq-FS
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:52:38 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUB7q-0004A7-83
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:52:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id b14so2454250wru.12
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:52:19 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-8-cota@braap.org> <87h8ft3295.fsf@linaro.org>
	<e39db85e-52b5-bdc8-d9a7-e3a14f78ce4b@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e39db85e-52b5-bdc8-d9a7-e3a14f78ce4b@linaro.org>
Date: Tue, 04 Dec 2018 13:52:16 +0000
Message-ID: <87ftvd2ycv.fsf@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/4/18 6:28 AM, Alex Benn=C3=A9e wrote:
>> Emilio G. Cota <cota@braap.org> writes:
>>> This assumes that QEMU is running on an IEEE754-compliant FPU and
>>> that the rounding is set to the default (to nearest). The
>>> implementation-dependent specifics of the FPU should not matter; things
>>> like tininess detection and snan representation are still dealt with in
>>> soft-fp. However, this approach will break on most hosts if we compile
>>> QEMU with flags such as -ffast-math. We control the flags so this should
>>> be easy to enforce though.
>>
>> We don't currently enforce this though although maybe that would be too
>> much hand holding for compiler ricers hell bent on not understanding the
>> flags they use.
>
> We could always
>
> #ifdef __FAST_MATH__
> #error "Silliness like this will get you nowhere"
> #endif

Emilio, are you happy to add that guard with a suitable pithy comment?

--
Alex Benn=C3=A9e
