Received: from eggs.gnu.org ([2001:4830:134:3::10]:54572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX6OA-0006Cg-Js
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX6O9-0002qy-Tx
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:16:26 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:34847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX6O9-0002ql-PM
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:16:25 -0500
Received: by mail-ua0-x234.google.com with SMTP id y9so205812658uae.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:16:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <878tpwad5s.fsf@linaro.org>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
	<1485285380-10565-3-git-send-email-peter.maydell@linaro.org>
	<878tpwad5s.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 13:16:04 +0000
Message-ID: <CAFEAcA_hYyh_v7feko06Mq28DWTEGixNoeYMXdhKg28689zQSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] armv7m_nvic: keep a pointer to the
 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Liviu Ionescu <ilg@livius.net>

On 27 January 2017 at 12:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>> @@ -349,7 +347,6 @@ static void nvic_writel(nvic_state *s, uint32_t offs=
et, uint32_t value)
>>          }
>>          break;
>>      case 0xd08: /* Vector Table Offset.  */
>> -        cpu =3D ARM_CPU(qemu_get_cpu(0));
>>          cpu->env.v7m.vecbase =3D value & 0xffffff80;
>
> Given it is only used once here you could just indirect it:
>
>            s->cpu->env.v7m.vecbase =3D value & 0xffffff80;

Two reasons not to do that:
(1) it makes this patch easier to review if all it's
doing is deleting lines that set cpu
(2) future patches improving the NVIC support are going
to add more cases that want to use the cpu pointer

thanks
-- PMM
