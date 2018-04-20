Received: from eggs.gnu.org ([2001:4830:134:3::10]:60409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9PlX-0007QA-U4
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9PlS-0001mo-Uv
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:43:27 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9PlS-0001lY-On
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:43:22 -0400
Received: by mail-wr0-x22e.google.com with SMTP id z73-v6so19943158wrb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 23:43:22 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-43-alex.bennee@linaro.org>
	<1296d11c-5b11-cdca-cf01-09940334f127@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1296d11c-5b11-cdca-cf01-09940334f127@linaro.org>
Date: Fri, 20 Apr 2018 07:43:20 +0100
Message-ID: <87sh7q9y47.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 42/43] tests/tcg: disable fp-test for 32
 bit (HACK!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 04/19/2018 03:59 AM, Alex Benn=C3=A9e wrote:
>> +ifneq (,$(findstring 64,$(TARGET_NAME)))
>
> You're only considering aarch64, x86_64, ppc64 and the like.
> This fails for alpha, s390x and the like.

Yes, it's a temporary hack that needs a better solution.

--
Alex Benn=C3=A9e
