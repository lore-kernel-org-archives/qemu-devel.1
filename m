Received: from eggs.gnu.org ([2001:4830:134:3::10]:49085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zoup@zoup.org>) id 1crR36-0002Oi-P6
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zoup@zoup.org>) id 1crR35-0007mg-4p
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:22:44 -0400
Received: from mail-it0-x236.google.com ([2607:f8b0:4001:c0b::236]:38304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zoup@zoup.org>) id 1crR34-0007mF-UC
	for Qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:22:43 -0400
Received: by mail-it0-x236.google.com with SMTP id y18so3636384itc.1
	for <Qemu-devel@nongnu.org>; Fri, 24 Mar 2017 08:22:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149036783558.3910.1779320846654726604@loki>
References: <CAOvx4-1MYO14+hkP8ZZg6Y4v_GFU8HtzYSeRo692zbsZN8D79A@mail.gmail.com>
	<149036783558.3910.1779320846654726604@loki>
From: Armin Ranjbar <zoup@zoup.org>
Date: Fri, 24 Mar 2017 19:52:21 +0430
Message-ID: <CAOvx4-3-rW1=F3uTZnvrMvdX0vT1omsq0PTAhove12ciaebx_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] guest-exec of qemu-guest-agent fails on Windows
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Qemu-devel@nongnu.org, Behrooz <everplays@gmail.com>

We have tried qemu-ga from Fedora [1] which didn't have guest-exec and
guest-exec-status (qemu-ga -b ? didn't list them and running guest-exec
returned command not found) and also build msi from HEAD ourselves.

gspawn-exec files are there, when we try to run guest-exec command qemu-ga
windows application (which is running on foreground for testing) fails at
gspawn-win32-helper.c [2] assertion, what happens on windows is that the
"gspawn-win32-helper application stopped working" dialog appears.

[1] https://fedoraproject.org/wiki/Windows_Virtio_Drivers
[2]
https://github.com/GNOME/glib/blob/8edcf67b0221efa3c2ada67c44eff29939b1704d/glib/gspawn-win32-helper.c#L208


---
Armin ranjbar


On Fri, Mar 24, 2017 at 7:33 PM, Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:

> What steps did you use to install qga? Did you use the .msi
> installer? If not you'll need to make those glib helper executables
> available to the agent by placing them in the install directory or
> somewhere in its executable paths. The MSI installer should handle
> all this for you.
>
>
