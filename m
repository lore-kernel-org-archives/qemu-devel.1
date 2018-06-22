Received: from eggs.gnu.org ([2001:4830:134:3::10]:50486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWLf7-0005Y6-Eh
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWLf6-0006Jr-QP
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:59:37 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWLf6-0006JZ-MS
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:59:36 -0400
Received: by mail-ot0-x242.google.com with SMTP id d19-v6so7381823oti.8
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 05:59:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622125814.345274-1-eblake@redhat.com>
References: <20180622125814.345274-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:59:15 +0100
Message-ID: <CAFEAcA8SdUhXXyi4kcgQCodzxHFYyeMZVRrSB1==ddSLBDh6+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Silence gcc false positive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On 22 June 2018 at 13:58, Eric Blake <eblake@redhat.com> wrote:
> The code has a while() loop that always initialized 'end', and
> the loop always executes at least once (as evidenced by the assert()
> just prior to the loop).  But some versions of gcc still complain
> that 'end' is used uninitialized, so silence them.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> Peter, do you want to apply this directly as a build fix, or shall
> I submit a pull request?

I'll just apply it directly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
