Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOWCG-0002Cv-RV
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOWCG-0002LT-3O
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:05:12 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:44156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOWCF-0002KP-TU
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:05:12 -0500
Received: by mail-ot0-x22a.google.com with SMTP id d27so16109420ote.11
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 14:05:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512669755-8409-3-git-send-email-thuth@redhat.com>
References: <1512669755-8409-1-git-send-email-thuth@redhat.com>
	<1512669755-8409-3-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2017 22:04:50 +0000
Message-ID: <CAFEAcA9gz0cNkPvZhkLYfYQ+ST01POwuptfXkKixSu_x=s9C+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/2] net: Remove the deprecated
 -tftp, -bootp, -redir and -smb options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 7 December 2017 at 18:02, Thomas Huth <thuth@redhat.com> wrote:
> These options likely do not work as expected as soon as the user
> tries to use more than one network interface at once. The parameters
> have been marked as deprecated since QEMU v2.6, so users had plenty
> of time to move their scripts to the new syntax. Time to remove the
> old parameters now.

The deprecation message says:
               error_report("The -redir option is deprecated. "
                            "Please use '-netdev user,hostfwd=...' instead.");

How does this work for systems which have embedded ethernet
devices and can't use -netdev ?

This is one reason I haven't bothered to update my scripts yet
(the other being that the deprecation message is basically
saying "go and do a bunch of research into command line
syntax" rather than "replace your current option '-redir xyz'
with '-netdev user,hostfwd=x,y:z'"...)

The message also doesn't point out that if you were previously
using -net + -redir you need to switch to -device + -netdev,
since -net + -netdev doesn't work AFAIK. Which is more
upheaval to a working command line setup.

thanks
-- PMM
