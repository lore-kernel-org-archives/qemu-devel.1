Received: from eggs.gnu.org ([2001:4830:134:3::10]:39723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTNie-0000BB-C2
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTNia-0001FX-Ee
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:35:00 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTNia-0001FM-78
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:34:56 -0400
Received: by mail-wm0-x242.google.com with SMTP id x6-v6so9022090wmc.3
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 01:34:56 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-6-alex.bennee@linaro.org>
	<a24ec09d-9bf8-ea12-092f-9df1d4ad7786@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <a24ec09d-9bf8-ea12-092f-9df1d4ad7786@linaro.org>
Date: Thu, 14 Jun 2018 09:34:53 +0100
Message-ID: <871sd922c2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v3 05/22] risu: add zlib indication to
 help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 06/13/2018 02:55 AM, Alex Benn=C3=A9e wrote:
>> This is a simple aide-memoir as it can be tricky to determine this
>> with a simple statically compiled binary.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  risu.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Eh, sure.  Or we could simply require zlib...
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I would be some cross compilers (or more correctly multiarch setups) are
broken in this regard. There was a time before I moved to 18.04 that I
couldn't have multiple zlib1g-dev packages installed due to clashing
files.

As risu accepts stdin/stdout for trace files you can work around this
with pipes and native gzip so a non-zlib enabled risu is still usable.
But I'm happy to defer to Peter on this one.

--
Alex Benn=C3=A9e
