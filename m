Received: from eggs.gnu.org ([2001:4830:134:3::10]:49666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJP2I-000320-7H
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJP2D-0003Vp-J6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:58:02 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJP2D-0003VY-D1
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:57:57 -0400
Received: by mail-wr0-x242.google.com with SMTP id h5-v6so6883754wrm.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:57:57 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-21-alex.bennee@linaro.org>
	<02e9a6a1-2274-541e-8b88-111a3fc537f5@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <02e9a6a1-2274-541e-8b88-111a3fc537f5@redhat.com>
Date: Thu, 17 May 2018 20:57:54 +0100
Message-ID: <87o9hedph9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 20/49] tests/tcg/i386: fix test-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>


Eric Blake <eblake@redhat.com> writes:

> On 05/17/2018 12:46 PM, Alex Benn=C3=A9e wrote:
>> The test-i386 test case is a little special as it includes assembler
>> files. Add the additional compile magic to assemble these bits and
>> link them to the final binary.
>
> The patch says "add"...
>
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tests/tcg/i386/test-i386.c | 1 -
>>   1 file changed, 1 deletion(-)
>
> ...but consists only of a single deletion.

Oops, yeah it all got merged into the "move to i386 subdir" patch. Maybe
I should just fold that together?

--
Alex Benn=C3=A9e
