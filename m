Received: from eggs.gnu.org ([2001:4830:134:3::10]:53967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqJ2T-000072-6p
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqJ2R-0005Ut-TU
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:37:25 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqJ2R-0005RP-Mm
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:37:23 -0400
Received: by mail-wr0-x235.google.com with SMTP id g10so111121584wrg.2
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 05:37:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316111416.25587-1-vfeenstr@redhat.com>
References: <20170316111416.25587-1-vfeenstr@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 12:37:01 +0000
Message-ID: <CAFEAcA-bu9noosLApv83U2WAs27q4Kx2zVv_xpZtWjL=64VSdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Supress warning in function
 pointer typedefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 16 March 2017 at 11:14, Vinzenz 'evilissimo' Feenstra
<vfeenstr@redhat.com> wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>
> When importing dynamically functions via `GetProcAddress` in windows
> related code, it is quite common to make a typedef for the resulting
> function pointer. When the function to be imported, has a stdcall
> calling convention, usually the `WINAPI` macro is used. This patch adds an
> exception in the checkpatch.pl script to allow the calling convention
> specification in function pointer typedefs, to be `WINAPI`.
>
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>

Could you provide an example of the kind of source line that provokes
the incorrect warning and the checkpatch output that results,
please?

thanks
-- PMM
