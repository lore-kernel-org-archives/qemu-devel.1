Received: from eggs.gnu.org ([2001:4830:134:3::10]:54480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1e46gt-00013O-5F
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1e46gY-0001lo-Lv
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:48:27 -0400
Received: from speedy.comstyle.com ([206.51.28.2]:35456 helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1e46gY-0001Ux-BW
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:48:06 -0400
From: Brad Smith <brad@comstyle.com>
References: <20171013102812.29648-1-berrange@redhat.com>
	<1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
	<a591ebd3-ae7f-cde6-1cd2-d4859c17494f@redhat.com>
	<20171013113859.GG20515@redhat.com>
	<f43d6c1c-1112-bfcf-ae19-ed2a002b7873@redhat.com>
	<CAFEAcA_Jmh-UyHDtMM+yzG_3Y1eJPzPmr9ATBQp3j_-1a4U7wQ@mail.gmail.com>
Message-ID: <8b4e9396-bbef-cd14-2127-d387e7d024cc@comstyle.com>
Date: Mon, 16 Oct 2017 10:47:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Jmh-UyHDtMM+yzG_3Y1eJPzPmr9ATBQp3j_-1a4U7wQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: pick the right compiler for
 OpenBSD by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 10/13/2017 12:14 PM, Peter Maydell wrote:

> On 13 October 2017 at 12:46, Thomas Huth<thuth@redhat.com>  wrote:
>> I disagree. If the next OpenBSD release uses Clang by default, we're not
>> building QEMU there with the *working default* C compiler anymore.
>> You're then rather forcing the OpenBSD users then to install an
>> additional (likely unliked, since GPLv3) GCC package on their systems.
>>
>> So IMHO, just drop this patch and wait for the next OpenBSD release, and
>> the problem will be solved automatically. (and the few users who still
>> use an older release of OpenBSD will likely use the QEMU from their
>> ports system anyway)
> Another possible approach would be to have a configure test
> for whatever feature it is that we need in our compiler,
> and then run through a list that starts with "cc" and
> goes on to try "egcc" etc until it finds one that works.
> That way we'll automatically DTRT when OpenBSD upgrades
> their "cc" to a working one.

The release is already out.

One issue that needs to be fixed in the configure script. Have the TLS test
link with libpthread if the initial test fails.
