Received: from eggs.gnu.org ([2001:4830:134:3::10]:52650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMzpN-0001aH-F4
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMzpK-0004Nu-Ag
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:23:49 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMzpE-0004GB-JM
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 13:23:45 -0500
Received: by mail-wr1-x42d.google.com with SMTP id j10so4170761wru.4
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 10:23:37 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-2-cota@braap.org>
	<877ehfew1g.fsf@linaro.org> <20181114170840.GA960@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181114170840.GA960@flamenco>
Date: Wed, 14 Nov 2018 18:23:34 +0000
Message-ID: <87o9arcyc9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 01/48] cpu: introduce run_on_cpu_no_bql
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

> On Wed, Nov 14, 2018 at 11:30:19 +0000, Alex Benn=C3=A9e wrote:
>>
>> Emilio G. Cota <cota@braap.org> writes:
>>
>> > This allows us to queue synchronous CPU work without the BQL.
>> >
>> > Will gain a user soon.
>>
>> This is also in the cpu-lock series right?
>
> No, in the cpu-lock series we add async_run_on_cpu_no_bql;
> here we add the sync version.

My mistake, being word blind:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
