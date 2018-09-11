Received: from eggs.gnu.org ([2001:4830:134:3::10]:36663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fziLw-0007pk-MT
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fziEP-0002yD-Co
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:57:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fziEP-0002xp-4T
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:57:25 -0400
Received: by mail-pl1-x642.google.com with SMTP id b12-v6so11293767plr.8
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 05:57:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-12-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <625a1e52-e2e3-51dd-be03-bae4dcf831b4@twiddle.net>
Date: Tue, 11 Sep 2018 05:57:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180910232752.31565-12-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/12] target/i386/translate: use
 thread-local storage in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 09/10/2018 04:27 PM, Emilio G. Cota wrote:
> Needed for MTTCG.
> 
> Note that in user-mode, code generation is serialized by
> mmap_lock, so making these variables per-thread would
> just waste TLS space.
> 
> Acked-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---

This is ok for now, but we really really should move these into DisasContext.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
