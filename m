Received: from eggs.gnu.org ([2001:4830:134:3::10]:42569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fP7Hq-0000YA-Mt
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 10:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fP7Hp-0004bJ-UG
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 10:13:42 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fP7Hp-0004YR-Mz
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 10:13:41 -0400
Received: by mail-wr0-x231.google.com with SMTP id l10-v6so3999101wrn.2
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 07:13:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 2 Jun 2018 15:13:39 +0100
Message-ID: <CAJSP0QWELqGP56Dm5qyS7zGe_xdPwB5t6CZXkqhdmX16RKM9nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Cortex M0 emulation tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, May 28, 2018 at 3:26 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Before we can tackle these tasks a Cortex M0 CPU needs to be defined.
> Adding the Cortex M0 involves a new element in
> target/arm/cpu.c:arm_cpus[].  The CPU needs ARM_FEATURE_V6 and
> ARM_FEATURE_M.  Once that is in place most of these tasks can be done
> independently and by multiple people.

I have put together a basic Cortex M0 ARMv6-M CPU that can serve as
the basis for this work.  Please see the RFC patches that I've sent
separately.

Stefan
