Received: from eggs.gnu.org ([2001:4830:134:3::10]:34952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1csptB-0004He-PF
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cspt7-0001Bh-QN
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:06:17 -0400
Received: from chuckie.co.uk ([82.165.15.123]:46719
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cspt7-0001BN-It
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:06:13 -0400
References: <20170327201146.1820-1-sw@weilnetz.de>
	<f4b891ea-88c0-7c22-c702-f0ad0740d4e5@redhat.com>
	<53da131d-0d11-d471-1848-84e65087029b@weilnetz.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5e77ea18-7036-7c37-a06a-07bc8321c6b0@ilande.co.uk>
Date: Tue, 28 Mar 2017 13:05:51 +0100
MIME-Version: 1.0
In-Reply-To: <53da131d-0d11-d471-1848-84e65087029b@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] Fix check for target OS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 28/03/17 12:53, Stefan Weil wrote:

> You are right. I was wrong because of this use case:
> 
> $ ./configure '--enable-debug' '--cross-prefix=x86_64-w64-mingw32'
> 
> ERROR: Unsupported host OS CYGWIN_NT-6.1
> 
> So the error message is misleading when I specify a wrong cross prefix
> (it should have been x86_64-w64-mingw32- instead of x86_64-w64-mingw32).
> 
> With the correct cross prefix, builds work, so cross builds are
> not a critical issue as I thought.
> 
> The second issue which remains is calling ./configure --help:
> 
> $ ./configure --help
> 
> ERROR: Unsupported host OS CYGWIN_NT-6.1
> 
> The third issue is the message for deprecated cpus or targets
> which should use "target" instead of "host".
> 
> All these three issues are not critical for the next QEMU version.
> Therefore I think they can be fixed after the release.

On a related note, I was scratching my head for a while over the weekend
trying to build on MingW with the "ERROR: Unsupported host ..." message,
since it also pops up if you don't have gcc installed, or indeed gcc but
not the gcc headers installed.

The latter case was much harder to spot since config.log showed other
warnings and #errors from previous configure tests before failing with
the unrelated ERROR message.


ATB,

Mark.
