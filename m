Received: from eggs.gnu.org ([209.51.188.92]:46537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyGoE-0002MO-Qx
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyGoE-00062J-0u
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:00:42 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:44183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyGoD-0005yL-Kw
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:00:41 -0500
Received: by mail-oi1-x22e.google.com with SMTP id a81so7257583oii.11
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 06:00:31 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 14:00:19 +0000
Message-ID: <CAFEAcA-GYE98ceYOHQ5hGwb-Dh8qv=Jvr=EEp_Dk9YLCmQdA4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] can we disable the migration-test for TCG targets ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi; the migration-test is failing really frequently for me
for TCG targets (usually on sparc64 host) -- can we just disable
it from the test set until we've figured out and implemented a
fix for the underlying TCG bug, please?

thanks
-- PMM
