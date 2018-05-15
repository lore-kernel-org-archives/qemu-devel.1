Received: from eggs.gnu.org ([2001:4830:134:3::10]:38357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIXPF-00008Y-Sb
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIXPF-0005iZ-4g
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:42:09 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIXPE-0005i4-UU
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:42:09 -0400
Received: by mail-wr0-x244.google.com with SMTP id o4-v6so15486496wrm.0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:42:08 -0700 (PDT)
References: <20180512003217.9105-1-richard.henderson@linaro.org>
	<20180512003217.9105-4-richard.henderson@linaro.org>
	<87r2mgowbl.fsf@linaro.org>
	<9a8d7eff-63ab-bbff-c9cb-4a757fc149d5@linaro.org>
	<87y3gmfd4z.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87y3gmfd4z.fsf@linaro.org>
Date: Tue, 15 May 2018 11:42:06 +0100
Message-ID: <87sh6tfbep.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/11] target/arm: Implement FCVT
 (scalar, integer) for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 05/13/2018 12:21 AM, Alex Benn=C3=A9e wrote:
>>>
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> Hmm oddly this fails to apply:
>>
>> Did try vs master or target-arm.next (as mentioned in the cover)?
>
> Apologies, I missed that.

Fortunately time heals all things and it now applies cleanly to master
as the prerequisites have gone in.

Hopefully Peters scripts will pick up the remaining tags?

Anyway now tested on direct master branch as well:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
