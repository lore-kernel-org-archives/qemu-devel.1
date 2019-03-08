Received: from eggs.gnu.org ([209.51.188.92]:49804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G7W-0000RY-VW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2G7V-0008AC-VW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:05:06 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:43029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2G7S-0006jQ-CV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:05:04 -0500
Received: by mail-oi1-x229.google.com with SMTP id i8so15910730oib.10
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 06:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20190307151141.6483-1-kraxel@redhat.com>
In-Reply-To: <20190307151141.6483-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 14:04:33 +0000
Message-ID: <CAFEAcA-t7kkq8pMK-Nh2mopZiEsTuO+kGzGNTz3Aj2kjngPmtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Ui 20190307 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 7 Mar 2019 at 15:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190307-pull-request
>
> for you to fetch changes up to 9b3c34835094760732c65a829bf0c07512126496:
>
>   monitor: deprecate acl_show, acl_reset, acl_policy, acl_add, acl_remove (2019-03-07 14:23:22 +0100)
>
> ----------------------------------------------------------------
> curses: better wide char support.
> vnc: acl update, stall fix.
>
> ----------------------------------------------------------------

Hi; this fails to build on FreeBSD; linking the qemu-system-*
binaries fails with:

/usr/bin/ld: undefined reference to symbol `libiconv_open' (try adding -liconv)
//usr/local/lib/libiconv.so.2: could not read symbols: Bad value
c++: error: linker command failed with exit code 1 (use -v to see invocation)

(This is with the FreeBSD test setup from tests/vm/freebsd).

thanks
-- PMM
