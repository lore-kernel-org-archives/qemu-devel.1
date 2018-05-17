Received: from eggs.gnu.org ([2001:4830:134:3::10]:34867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJQOR-0003mQ-A6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 17:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJQOM-0005Ik-De
	for qemu-devel@nongnu.org; Thu, 17 May 2018 17:24:59 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJQOM-0005Gv-6Z
	for qemu-devel@nongnu.org; Thu, 17 May 2018 17:24:54 -0400
Received: by mail-wr0-x244.google.com with SMTP id w18-v6so3327363wrn.6
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 14:24:53 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-30-alex.bennee@linaro.org>
	<9b8a5a71-2071-ef5c-07b2-3797883ed22e@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9b8a5a71-2071-ef5c-07b2-3797883ed22e@linaro.org>
Date: Thu, 17 May 2018 22:24:51 +0100
Message-ID: <87muwydlgc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 29/49] tests/tcg/arm: disable -p 32768
 mmap test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 05/17/2018 10:46 AM, Alex Benn=C3=A9e wrote:
>> Broken since I updated to 18.04
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/arm/Makefile.target | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>
> Meh.  Most of these fail for hosts with 64k pages.
> So, sure, disable this one, but I don't think that
> the others are useful either.

I'm not entirely sure what the point of -p is meant to be. Is it just a
performance hack for linux-user to have bigger pages? We are not using
softmmu but I guess it affects the PageDesc structures?

--
Alex Benn=C3=A9e
