Received: from eggs.gnu.org ([2001:4830:134:3::10]:38523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cem8T-00033n-Of
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cem8S-0001Ao-Pe
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:15:57 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cem8S-0001A3-Ix
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:15:56 -0500
Received: by mail-wm0-x236.google.com with SMTP id r141so14928824wmg.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 09:15:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 17:15:34 +0000
Message-ID: <CAFEAcA_N1j9tpxEBROG6D1per9vDMPZeuRyM93BRzNT5ZK3q0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chad Joan <chadjoan@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 February 2017 at 16:54, Chad Joan <chadjoan@gmail.com> wrote:
> so if we can test and
> approve even /some/ of the more popular mail clients (ex: gmail,
> thunderbird, outlook, etc) for use, it would help newbies A LOT.

Pretty sure we've seen mangled emails from all of those.
The problem is that most email clients will automatically
wrap long lines, which is fine for text but breaks an
inline patch. Changing trailing whitespace in patches is
also a common issue.

The documentation in "git help format-patch" has a section
"MUA-SPECIFIC HINTS" which says that gmail's web interface
is definitely no good, and Thunderbird defaults to the wrong
thing and requires a bunch of config changes which you'd then
have to switch back to your preferences for normal mail when
you're done sending patches. Outlook is so hopeless for
patch mail it isn't even listed :-)

The kernel docs have a longer list of mail clients with
notes about suitability:
https://kernel.org/doc/html/latest/process/email-clients.html
but the set of "just works" clients is very small.

thanks
-- PMM
