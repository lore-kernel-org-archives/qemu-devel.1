Received: from eggs.gnu.org ([2001:4830:134:3::10]:55282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb8fW-0003Tt-L0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb8fV-000832-Pk
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:07:50 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb8fV-00082n-KP
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:07:49 -0400
Received: by mail-oi0-x242.google.com with SMTP id v8-v6so18617767oie.5
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:07:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705180403.11928-1-richard.henderson@linaro.org>
References: <20180705180403.11928-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 19:07:28 +0100
Message-ID: <CAFEAcA_bjPEchF6FFa4DHi69rS8-WjpnR4E_2HZgNwqAF8CGYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] target/arm: Suppress Coverity warning for PRF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 5 July 2018 at 19:04, Richard Henderson <richard.henderson@linaro.org> wrote:
> These instructions must perform the sve_access_check, but
> since they are implemented as NOPs there is no generated
> code to elide when the access check fails.
>
> Fixes: Coverity issues 1393780 & 1393779.
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Does anyone know if this actually works for Coverity?
> I'd hate to churn the code without knowing.

Googling suggests that cast-to-void works. I tend to just mark
them as false-positive in the Coverity GUI, though...

thanks
-- PMM
