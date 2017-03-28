Received: from eggs.gnu.org ([2001:4830:134:3::10]:58713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cspgb-0000Lg-Km
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cspgW-0003XW-NC
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:53:17 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:35220
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cspgW-0003XJ-G8
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:53:12 -0400
References: <20170327201146.1820-1-sw@weilnetz.de>
	<f4b891ea-88c0-7c22-c702-f0ad0740d4e5@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <53da131d-0d11-d471-1848-84e65087029b@weilnetz.de>
Date: Tue, 28 Mar 2017 13:53:10 +0200
MIME-Version: 1.0
In-Reply-To: <f4b891ea-88c0-7c22-c702-f0ad0740d4e5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] Fix check for target OS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Am 28.03.2017 um 10:04 schrieb Paolo Bonzini:
> On 27/03/2017 22:11, Stefan Weil wrote:
>> * Support cross compilation with the most common cross prefixes
>>   for Mingw-w64. Other cross builds are still broken!
> Can you explain how it's broken?  Why does check_define not work at this
> point, for cross builds?
>
> "../configure --cross-prefix=x86_64-w64-mingw32-" seems to work for me.
>
> Paolo

You are right. I was wrong because of this use case:

$ ./configure '--enable-debug' '--cross-prefix=x86_64-w64-mingw32'

ERROR: Unsupported host OS CYGWIN_NT-6.1

So the error message is misleading when I specify a wrong cross prefix
(it should have been x86_64-w64-mingw32- instead of x86_64-w64-mingw32).

With the correct cross prefix, builds work, so cross builds are
not a critical issue as I thought.

The second issue which remains is calling ./configure --help:

$ ./configure --help

ERROR: Unsupported host OS CYGWIN_NT-6.1

The third issue is the message for deprecated cpus or targets
which should use "target" instead of "host".

All these three issues are not critical for the next QEMU version.
Therefore I think they can be fixed after the release.

Regards
Stefan
