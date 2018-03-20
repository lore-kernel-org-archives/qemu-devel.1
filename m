Received: from eggs.gnu.org ([2001:4830:134:3::10]:47011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyKvy-0005eC-By
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyKvx-0004EF-Gv
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:20:26 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:34354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyKvx-0004Dv-CX
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:20:25 -0400
Received: by mail-ot0-x235.google.com with SMTP id m7-v6so2588447otd.1
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 10:20:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521566230-111929-4-git-send-email-mst@redhat.com>
References: <1521566230-111929-1-git-send-email-mst@redhat.com>
	<1521566230-111929-4-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 17:20:04 +0000
Message-ID: <CAFEAcA97jt9rcAC4HROcxQgWhi-FxC3UOKhyrTuUioSFd=6KyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] postcopy: drop unnecessary
 conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 20 March 2018 at 17:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> We have our own copy of unistd so there is no
> need to check for symbols present there.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I just sent a mail in the other thread about this, but we
only have our own copy of unistd if the host architecture
supports KVM. If it doesn't then we're going to be using
the system's copy of the includes...

thanks
-- PMM
