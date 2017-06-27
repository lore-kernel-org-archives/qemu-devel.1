Received: from eggs.gnu.org ([2001:4830:134:3::10]:51281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dPq8F-0004c1-M2
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dPq8A-00014l-AB
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:02:15 -0400
References: <1497376844-26561-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <59adcd8d-12c3-d148-ab56-5d1db4f42b5a@msgid.tls.msk.ru>
Date: Tue, 27 Jun 2017 16:02:08 +0300
MIME-Version: 1.0
In-Reply-To: <1497376844-26561-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Fix build with pkg-config and
 --static --enable-sdl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

13.06.2017 21:00, Thomas Huth wrote:
> The configure script prefers pkg-config over sdl-config, but
> the "--static-libs" parameter only exists for the latter. With
> pkg-config, "--static --libs" have to be used instead.

Applied to -trivial, thanks!

/mjt
