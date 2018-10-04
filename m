Received: from eggs.gnu.org ([2001:4830:134:3::10]:43501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8A2U-0004Z5-CR
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8A2Q-0007g2-2N
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:16:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8A2P-0007er-Kj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:15:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id r63-v6so10206792wma.4
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 13:15:57 -0700 (PDT)
References: <20181003200454.18384-1-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181003200454.18384-1-cota@braap.org>
Date: Thu, 04 Oct 2018 21:15:54 +0100
Message-ID: <87o9c9qxhh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] per-TLB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00395.html
>
> Changes since v1:
>
> - Rebase on master
>
> - Expand lock usage to other tlb_table/tlb_v_table updates, which I
>   missed in v1
>
> - Fix assert_cpu_is_self macro
>
> - Add comment on why the owner thread doesn't need to use atomic_set
>   for updates
>
> - Add more calls to assert_cpu_is_self macro, which together with
>   the added comment should make the code simpler to understand
>
> - Include perf numbers in the last patch
>
> The series is checkpatch-clean. You can fetch the code from:
>   https://github.com/cota/qemu/tree/tlb-lock-v2

Weird build failure aside I gave it a good build test soak which usually
trips up TLB issues.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
