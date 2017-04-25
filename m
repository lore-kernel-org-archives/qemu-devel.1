Received: from eggs.gnu.org ([2001:4830:134:3::10]:48197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2zJk-00062J-Fp
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2zJj-0006AW-J6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:11:40 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2zJj-0006A8-Bf
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:11:39 -0400
Received: by mail-wm0-x22c.google.com with SMTP id m123so94048502wma.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 05:11:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170425062952.99149-1-brendan@bslabs.net>
References: <20170425062952.99149-1-brendan@bslabs.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 13:11:17 +0100
Message-ID: <CAFEAcA8_=3Bsd0ANdOmq6mk3PuxSkw7p18MLSFQyV917w1m+Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: Fix macOS 10.12 deprecation
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brendan Shanks <brendan@bslabs.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 25 April 2017 at 07:29, Brendan Shanks <brendan@bslabs.net> wrote:
> macOS 10.12 deprecated/replaced many AppKit constants to make naming
> more consistent. Use the new constants, and #define them to the
> old constants when compiling against a pre-10.12 SDK.
>
> Signed-off-by: Brendan Shanks <brendan@bslabs.net>
> ---
>  ui/cocoa.m | 87 +++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 58 insertions(+), 29 deletions(-)
>

Thanks for this patch -- I'm running 10.12 but I think my SDK
is still the earlier version. Patch looks good and compiles
fine, so I've applied it to git master.

-- PMM
