Received: from eggs.gnu.org ([2001:4830:134:3::10]:52680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejAJU-0002vw-9L
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejAJR-00049A-7x
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:58:00 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:42377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejAJQ-00048k-VG
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:57:57 -0500
Received: by mail-wr0-x22e.google.com with SMTP id 41so3406598wrc.9
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 12:57:56 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<87bmh2w0fp.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87bmh2w0fp.fsf@linaro.org>
Date: Tue, 06 Feb 2018 20:57:54 +0000
Message-ID: <877erpx2ct.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 00/20] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> Changes since v11:
>>   * Use dup_const more.
>>   * Cleanup some gvec 2i and 2s routines.
>>   * Use more helpers and less gotos in target/arm/translate-a64.c.
>
> I just noticed the aarch64 cross build breaks:
>
> n file included from /root/src/github.com/stsquad/qemu/tcg/tcg.c:296:0:
> /root/src/github.com/stsquad/qemu/tcg/aarch64/tcg-target.inc.c: In functi=
on 'tcg_out_dupi_vec':
> /root/src/github.com/stsquad/qemu/tcg/aarch64/tcg-target.inc.c:806:9: err=
or: implicit declaration of function 'new_pool_l2' [-Werror=3Dimplicit-func=
tion-declaration]
>          new_pool_l2(s, R_AARCH64_CONDBR19, s->code_ptr, 0, v64, v64);

Ignore me, bad patch application that only affected that build.

--
Alex Benn=C3=A9e
