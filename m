Received: from eggs.gnu.org ([2001:4830:134:3::10]:51845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIBTs-0003Ar-QH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIBTo-0006JA-MJ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:12:56 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dIBTo-0006IM-Fo
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:12:52 -0400
Received: by mail-wm0-x22a.google.com with SMTP id d73so45287804wma.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 03:12:52 -0700 (PDT)
References: <20170602160848.4913-1-alex.bennee@linaro.org>
	<20170602160848.4913-6-alex.bennee@linaro.org>
	<CAFEAcA_g6u+bsmb2JkqmBmy-N14BHFcTJTsvUTO27_q1nmbYgg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_g6u+bsmb2JkqmBmy-N14BHFcTJTsvUTO27_q1nmbYgg@mail.gmail.com>
Date: Tue, 06 Jun 2017 11:13:14 +0100
Message-ID: <87tw3tctl1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v4 05/10] risu: paramterise
 send/receive functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 2 June 2017 at 17:08, Alex Bennée <alex.bennee@linaro.org> wrote:
>> This is a precursor to record/playback support. Instead of passing the
>> socket fd we now pass helper functions for reading/writing and
>> responding. This will allow us to do the rest of the record/playback
>> cleanly outside of the main worker function.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>
>> -        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
>> +         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
>>              /* register mismatch */
>>              resp = 2;
>> -
>> -        } else if (op == OP_TESTEND) {
>> +         } else if (op == OP_TESTEND) {
>>              resp = 1;
>> -        }
>
> [etc]
>
> If you're going to fix the indent can you put that in
> its own patch, please? Much easier to review that way.

Damn I forgotten that got munged. Can we agree on what the indent should
be for risu? 3 or 4, space or tabs?

--
Alex Bennée
