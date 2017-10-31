Received: from eggs.gnu.org ([2001:4830:134:3::10]:52456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9XWW-00025g-ED
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9XWS-00065v-IN
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:28:12 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:55340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9XWS-00065b-BP
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:28:08 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l8so16123566wre.12
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 07:28:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171030205636.14236-1-eblake@redhat.com>
References: <20171030205636.14236-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 14:27:46 +0000
Message-ID: <CAFEAcA-7WefugTeU1EV=2ZtStTVbrJFXpuKDb89EmyfvjAU4PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] NBD patches prior to 2.11 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 October 2017 at 20:56, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit abf6e752e55b2f5afb48303429dea2db7c3a62de:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20171030' into staging (2017-10-30 13:02:45 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-10-30
>
> for you to fetch changes up to f140e3000371e67ff4e00df3213e2d576d9c91be:
>
>   nbd: Minimal structured read for client (2017-10-30 21:48:41 +0100)
>
> ----------------------------------------------------------------
> nbd patches for 2017-10-30
>
> Vladimir Sementsov-Ogievskiy (some patches co-authored by Eric Blake):
> 00/12 nbd minimal structured read
>
> ----------------------------------------------------------------
> Eric Blake (8):
>       nbd: Include error names in trace messages
>       nbd: Move nbd_errno_to_system_errno() to public header
>       nbd: Expose constants and structs for structured read
>       nbd/server: Report error for write to read-only export
>       nbd/server: Simplify nbd_negotiate_options loop
>       nbd/server: Refactor zero-length option check
>       nbd/server: Include human-readable message in structured errors
>       nbd: Move nbd_read() to common header
>
> Vladimir Sementsov-Ogievskiy (4):
>       nbd: Minimal structured read for server
>       nbd/client: refactor nbd_receive_starttls
>       nbd/client: prepare nbd_receive_reply for structured reply
>       nbd: Minimal structured read for client

Applied, thanks.

-- PMM
