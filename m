Received: from eggs.gnu.org ([209.51.188.92]:52561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJHnP-0002HG-7n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJHeQ-0003CH-M1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:09:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJHeQ-00038a-CK
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:09:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id b1so13738412wru.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:09:24 -0700 (PDT)
References: <20190424124414.17775-1-arilou@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190424124414.17775-1-arilou@gmail.com>
Date: Wed, 24 Apr 2019 13:09:22 +0000
Message-ID: <87ftq7wnwd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] gdbstub: Refactor gdb packets handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jon Doron <arilou@gmail.com>


Jon Doron <arilou@gmail.com> writes:

> Refactor the command packet handling code to ease the work of
> adding and extending commands that are currently not implemented.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 1577 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 1092 insertions(+), 485 deletions(-)

This is worthwhile but the patch is huge compared to recent changes to
this currently orphaned file. Could you please consider splitting your
patch up into more discreet parts. I would suggest:

  - introduce infrastructure
  - one patch per converted command

this way when something breaks bisect stands a better chance of locating
a minimal failing chunk of code.

Out of interest what additional commands are you planning to implement?

--
Alex Benn=C3=A9e
