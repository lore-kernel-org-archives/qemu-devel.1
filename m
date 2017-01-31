Received: from eggs.gnu.org ([2001:4830:134:3::10]:54194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYZwx-0004Ip-If
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYZww-000660-Mj
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:02:27 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:33723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYZww-00065W-FZ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:02:26 -0500
Received: by mail-ua0-x234.google.com with SMTP id i68so274092571uad.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 07:02:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485873796-15095-1-git-send-email-mst@redhat.com>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 15:02:05 +0000
Message-ID: <CAFEAcA_ku0d6oE_W9YrndCvOoVxw7EH_pO8Vdjuh7VpAj=vMZQ@mail.gmail.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 31 January 2017 at 14:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> Some headers use QEMU_BUILD_BUG_ON. This causes a problem
> if the C file including that header happens to have
> QEMU_BUILD_BUG_ON at the same line number.
>
> Fix using a widely available extension: __COUNTER__.
> If unavailable, provide a stub.

Specifically, it was introduced in gcc 4.3.0 (2008),
and is in at least clang 3.1 (2012).

thanks
-- PMM
