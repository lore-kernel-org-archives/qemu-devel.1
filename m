Received: from eggs.gnu.org ([2001:4830:134:3::10]:51766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoFyP-0004bY-RL
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoFyM-00015r-PC
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:01:17 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:42696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eoFyM-00014e-Ic
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:01:14 -0500
Received: by mail-wr0-f174.google.com with SMTP id k9so18616573wre.9
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 14:01:14 -0800 (PST)
References: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5059119b-6ec4-88e9-6d92-5edb7c22fbb8@redhat.com>
Date: Tue, 20 Feb 2018 23:01:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Moving seabios-hppa git submodule to use a
 qemu.org mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>

On 20/02/2018 19:43, Peter Maydell wrote:
> I just noticed that we seem to have acquired another git
> submodule that isn't pointing to a qemu.org git url:
> 
> [submodule "roms/seabios-hppa"]
>         path = roms/seabios-hppa
>         url = git://github.com/hdeller/seabios-hppa.git
> 
> Jeff, could we set up so we can mirror this repo on qemu.org?
> Then we can send a patch to update the .gitmodules to point to it.

This is a fork of SeaBIOS, perhaps we should add "branch = hppa" and
pull it into the existing SeaBIOS repo of qemu.git.

However, I am worried that any bugfixes are never going to be applied to
the HPPA version.  How much forked is the fork?

Paolo
