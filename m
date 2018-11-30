Received: from eggs.gnu.org ([2001:4830:134:3::10]:42363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSmxh-0001WC-W5
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSmxc-0007ip-44
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:52:21 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSmxa-0007hL-1N
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:52:14 -0500
Received: by mail-wr1-x443.google.com with SMTP id 96so6132031wrb.2
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:52:13 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-10-richard.henderson@linaro.org>
	<87sgzi32fk.fsf@linaro.org>
	<49a0e9a4-9266-aad5-4059-b4197a3d64ba@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <49a0e9a4-9266-aad5-4059-b4197a3d64ba@linaro.org>
Date: Fri, 30 Nov 2018 17:52:11 +0000
Message-ID: <87o9a6312s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 09/37] tcg/i386: Use
 TCG_TARGET_NEED_LDST_OOL_LABELS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com


Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/30/18 9:22 AM, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> Move the entire memory operation out of line.
>>
>> Given Emilio's numbers is it likely we will want to support both options
>> given the variability on x86?
>
> No, I don't want to support two methods in any one tcg backend.
> Which is why I'm not really sure what to do about Emilio's results.

They at least seem pretty positive on aarch64 backends....

--
Alex Benn=C3=A9e
