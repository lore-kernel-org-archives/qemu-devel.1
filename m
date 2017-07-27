Received: from eggs.gnu.org ([2001:4830:134:3::10]:42427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dahhO-00038M-Cp
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dahhN-0002Hm-GY
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:15:26 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:32940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dahhN-0002H2-AR
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:15:25 -0400
Received: by mail-wr0-x232.google.com with SMTP id v105so112614868wrb.0
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 05:15:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170727120210.6943-2-crosa@redhat.com>
References: <20170727120210.6943-1-crosa@redhat.com>
	<20170727120210.6943-2-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2017 13:15:03 +0100
Message-ID: <CAFEAcA-CzG=JYjajJqMRL+pcMC2_06HTm1_xhD=ca=AReXHmTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] configure: remove duplicate single
 quotes on config.log header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 27 July 2017 at 13:02, Cleber Rosa <crosa@redhat.com> wrote:
> The generation of the informational header on config.log contains two
> pairs of single quotes, which seems unintentional, and looks like
> this:
>
>   # QEMU configure log Thu Jul 26 08:17:15 EDT 2017
>   # Configured with: './configure' '--target-list=x86_64-softmmu'

I think this is deliberate. The idea is that the string is a
validly shell-quoted string that you can cut and paste
into a shell prompt if you want to. (This is less important
than it used to be now we have config.status.)

If your configure command has more than one line you get
something like this:

# Configured with: '../../configure'
'--target-list=arm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-linux-user'
'--enable-debug' '--cc=ccache gcc' '--audio-drv-list=pa'

...and note in particular how the '--cc=ccache gcc' argument
is printed. Your change would give

# Configured with: '../../configure
--target-list=arm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-linux-user
--enable-debug --cc=ccache gcc --audio-drv-list=pa'

which can't be cut and pasted, and is ambiguous.

thanks
-- PMM
