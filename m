Received: from eggs.gnu.org ([2001:4830:134:3::10]:58542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cklAV-0008Gr-GC
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cklAT-0001LG-5N
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cklAS-0001KC-W3
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:45 -0500
Date: Mon, 6 Mar 2017 10:56:37 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAG48ez2eaXFk50puw_bc27tNdfOHDsL08A9jY8=7DnA-mtEXWA@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1703061044280.16064@wniryva>
References: <20170303112503.32277-1-ppandit@redhat.com>
	<CAFEAcA_V8azXLLptxqNWBwkY7wJZzK+YkZHd6RfHEVS-NoXXBg@mail.gmail.com>
	<CAG48ez2eaXFk50puw_bc27tNdfOHDsL08A9jY8=7DnA-mtEXWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] linux-user: limit number of arguments to
 execve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jann Horn <jannh@google.com>, Qemu Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

+-- On Fri, 3 Mar 2017, Jann Horn wrote --+
| On Fri, Mar 3, 2017 at 4:55 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
| >> +            if (argc > ARG_MAX || envc > ARG_MAX) {
| >> +                fprintf(stderr,
| >> +                        "argc(%d), envc(%d) exceed %d\n", argc, envc, ARG_MAX);
| >> +                ret = -TARGET_EFAULT;
| >> +                break;
| >> +            }
| >>              argp = alloca((argc + 1) * sizeof(void *));
| >>              envp = alloca((envc + 1) * sizeof(void *));
| >
| > This code is already supposed to handle "argument string too big",
| > see commit a6f79cc9a5e.
| >
| > What's the actual bug case we're trying to handle here?

Not argument string, but argument count too big leads to a bad address in 
get_user_ual(...), resulting in segfault.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
