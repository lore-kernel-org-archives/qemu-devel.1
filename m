Received: from eggs.gnu.org ([209.51.188.92]:39721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggGHi-0007xN-Lx
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 16:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggGHh-0003tZ-QT
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 16:48:42 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggGHh-0003tS-8S
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 16:48:41 -0500
Received: by mail-pl1-x641.google.com with SMTP id t13so19884466ply.13
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 13:48:41 -0800 (PST)
References: <875zv2kk1g.wl-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f94b78c0-888e-4c53-d314-9739c0b0cc3a@linaro.org>
Date: Mon, 7 Jan 2019 07:48:33 +1000
MIME-Version: 1.0
In-Reply-To: <875zv2kk1g.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to add a new target architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org

On 1/6/19 11:11 PM, Yoshinori Sato wrote:
> Hello.
> I written Renesas RX port.
> It is works to boot linux kernel of minimal configuration.
> 
> I'd like to merge this into the qmeu release and I need some
> advice on how to proceed.
> I tried reading wiki.qemu.org, but I could not find useful
> information about adding subsystems.
> 
> git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git

You'll need to produce a patch set that applies to master.
The easiest way is probably to merge master, diff, and then
apply the diff to a new branch.  Try to split the diff into
a few logical parts, e.g. target/rx/, hw/rx/, and last to
enable the port in configure.

The patch set should follow the CODING_STYLE.  You can use
./scripts/check_patch.pl to help find coding style problems.

Your patch set should modify MAINTAINERS to group all of the
rx related files, and list whoever is going to maintain the
port going forward, e.g. yourself.


r~
