Received: from eggs.gnu.org ([2001:4830:134:3::10]:44761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYb8N-0005De-ES
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYb8M-0008Jq-M0
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:18:19 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:33142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYb8M-0008Jf-Fb
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:18:18 -0500
Received: by mail-vk0-x22c.google.com with SMTP id k127so239926360vke.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 08:18:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <278c72d2-669a-9591-9391-2be3ead266a8@redhat.com>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
	<CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
	<c6c5267a-58df-061b-8dd3-73d691d37578@redhat.com>
	<CAFEAcA_rPxu8tmHn88t4odtCA1ZCK4iPsRB8+jLqk13k2u90yg@mail.gmail.com>
	<278c72d2-669a-9591-9391-2be3ead266a8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 16:17:57 +0000
Message-ID: <CAFEAcA9dWvXjXSLW8i0eA=d1t0H99YwnHyBipAk5V4=-Hj94nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 31 January 2017 at 15:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> We already require 4.1 for atomics.

Oh good. I've just sent a patch which gets rid of all the
checks for "gcc must be at least X" where X is 4.1 or
earlier.

thanks
-- PMM
