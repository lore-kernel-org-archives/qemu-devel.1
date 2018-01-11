Received: from eggs.gnu.org ([2001:4830:134:3::10]:58866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZZyJ-0003cv-QG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZZyJ-0003bu-1j
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:20:31 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:34137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZZyI-0003bR-O6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:20:30 -0500
Received: by mail-oi0-x235.google.com with SMTP id a70so1313295oib.1
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 02:20:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b5273c61-3db0-c171-4b92-c273def5feb7@redhat.com>
References: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
	<029858e0-c6e5-939d-d79e-c7ad7e5069a1@linaro.org>
	<CAFEAcA9ZMZyhV_MLvdpKD74895rXJ4cw3sX1sMHYJASe2h3LMw@mail.gmail.com>
	<b5273c61-3db0-c171-4b92-c273def5feb7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 10:20:09 +0000
Message-ID: <CAFEAcA9c7=g68jE6zXJBxkKvvKG9m1u9aFxbf87AnvfuqQo3bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cpu: flush TB cache when loading VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, maria.klimushenkova@ispras.ru, Pavel Dovgalyuk <dovgaluk@ispras.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 11 January 2018 at 10:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
> RAM contents are memcpy'd blindly during loadvm.  I think that's what
> requires a tb_flush.

Ah, that makes sense. Could we have a comment documenting the
rationale, please? Something like:

/* vmload has just updated the content of RAM, bypassing the
 * usual mechanisms that ensure we flush TBs for writes to
 * memory we've translated code from. So we must flush all TBs,
 * which will now be stale.
 */

thanks
-- PMM
