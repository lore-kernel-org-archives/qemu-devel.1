Received: from eggs.gnu.org ([2001:4830:134:3::10]:33628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fptVT-0006GN-Iy
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fptVO-0001S8-Fu
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:58:23 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fptVN-0001OT-PZ
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:58:22 -0400
Received: by mail-oi0-x241.google.com with SMTP id q11-v6so1226866oic.12
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 03:58:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180815023521.185705-1-aoates@google.com>
References: <20180815023521.185705-1-aoates@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 11:58:00 +0100
Message-ID: <CAFEAcA96P2aNENte+oisEMHEGbQeqVJjWHSYJLAJ3VHt2p76aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Oates <aoates@google.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2018 at 03:35, Andrew Oates <aoates@google.com> wrote:
> On Linux, SOCK_DGRAM+IPPROTO_ICMP sockets give only the ICMP packet when
> read from.  On macOS, however, the socket acts like a SOCK_RAW socket
> and includes the IP header as well.
>
> This change strips the extra IP header from the received packet on macOS
> before sending it to the guest.  SOCK_DGRAM ICMP sockets aren't
> supported on other BSDs, but we enable this behavior for them as well to
> treat the sockets the same as raw sockets.
>
> Signed-off-by: Andrew Oates <aoates@google.com>
> ---
> v2: check validity of inner_hlen and update len appropriately
> v3: CONFIG_DARWIN -> CONFIG_BSD; add comment explaining #ifdef
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
