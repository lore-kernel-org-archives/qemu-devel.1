Received: from eggs.gnu.org ([2001:4830:134:3::10]:59414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gJdwE-0004ph-Lk
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gJdw8-0002i6-8h
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:24:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gJdw4-0001kK-Jw
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:24:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id w7-v6so8105706wmc.1
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 04:24:49 -0800 (PST)
References: <20181105104524.933-1-jusual@mail.ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181105104524.933-1-jusual@mail.ru>
Date: Mon, 05 Nov 2018 12:24:46 +0000
Message-ID: <87va5bempd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] tests/microbit-test: Check nRF51 UART
 functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?Q?G=C3=B6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> writes:

> Some functional tests for:
>     Basic reception/transmittion
>     Suspending
>     INTEN* registers
>
> Based-on: <20181031002526.14262-1-contrib@steffen-goertz.de>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
> This patch was part of nRF51 UART patchset, but wasn't included in the la=
test
> revision. Due to upcoming loader fixes, we need this test instead of
> boot-serial-test, which doesn't support -device loader.

This didn't apply cleanly to master as the test isn't there yet. But the
uart patches look partially merged. Can I have a reference for the
series or tree please?

--
Alex Benn=C3=A9e
