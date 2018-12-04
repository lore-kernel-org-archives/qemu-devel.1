Received: from eggs.gnu.org ([2001:4830:134:3::10]:40567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gU9oD-0004MG-QG
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gU9oA-0000bT-ML
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:28:13 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gU9oA-0000ap-CL
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:28:10 -0500
Received: by mail-wr1-x443.google.com with SMTP id 96so15779520wrb.2
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 04:28:09 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-8-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-8-cota@braap.org>
Date: Tue, 04 Dec 2018 12:28:06 +0000
Message-ID: <87h8ft3295.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/13] fpu: introduce hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> The appended paves the way for leveraging the host FPU for a subset
> of guest FP operations. For most guest workloads (e.g. FP flags
> aren't ever cleared, inexact occurs often and rounding is set to the
> default [to nearest]) this will yield sizable performance speedups.
>
> The approach followed here avoids checking the FP exception flags registe=
r.
> See the added comment for details.
>
> This assumes that QEMU is running on an IEEE754-compliant FPU and
> that the rounding is set to the default (to nearest). The
> implementation-dependent specifics of the FPU should not matter; things
> like tininess detection and snan representation are still dealt with in
> soft-fp. However, this approach will break on most hosts if we compile
> QEMU with flags such as -ffast-math. We control the flags so this should
> be easy to enforce though.

We don't currently enforce this though although maybe that would be too
much hand holding for compiler ricers hell bent on not understanding the
flags they use.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
