Received: from eggs.gnu.org ([209.51.188.92]:42321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyIKT-0005Go-LU
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyIKS-0003sl-Jp
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:38:05 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyIKO-0003l7-K4
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:38:04 -0500
Received: by mail-wm1-x336.google.com with SMTP id n19so8510208wmi.1
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 07:37:53 -0800 (PST)
References: <CAFEAcA-GYE98ceYOHQ5hGwb-Dh8qv=Jvr=EEp_Dk9YLCmQdA4g@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-GYE98ceYOHQ5hGwb-Dh8qv=Jvr=EEp_Dk9YLCmQdA4g@mail.gmail.com>
Date: Mon, 25 Feb 2019 15:37:49 +0000
Message-ID: <877ednnak2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] can we disable the migration-test for TCG targets ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> Hi; the migration-test is failing really frequently for me
> for TCG targets (usually on sparc64 host) -- can we just disable
> it from the test set until we've figured out and implemented a
> fix for the underlying TCG bug, please?

Well on Travis they are all TCG targets as we don't have access to KVM.
I'm curious however why sparc64 seems to fail more than the others - are
we sure it's not a guest specific bug?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
