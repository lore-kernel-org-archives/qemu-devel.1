Received: from eggs.gnu.org ([2001:4830:134:3::10]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTxP7-0001Ya-UF
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTxP7-0005uw-3H
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:04:25 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:34594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTxP6-0005uj-N9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:04:25 -0500
Received: by mail-ua0-x22d.google.com with SMTP id 35so19030656uak.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 13:04:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484772931-16272-3-git-send-email-mst@redhat.com>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-3-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Jan 2017 21:04:03 +0000
Message-ID: <CAFEAcA_92_OZbPQGZ17-bOWwnchN14Y9yKxk362G7-c65-6Q4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/4] compiler: drop ; after BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

On 18 January 2017 at 20:55, Michael S. Tsirkin <mst@redhat.com> wrote:
> All users include the trailing ;, let's require that
> so that uses such as if (a) QEMU_BUILD_BUG_ON(); do not
> produce unexpected results.

When would it ever make sense for a build-time
assert to be the only thing inside a runtime
conditional anyway?

thanks
-- PMM
