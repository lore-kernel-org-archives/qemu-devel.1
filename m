Received: from eggs.gnu.org ([2001:4830:134:3::10]:60266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e5Yum-0001gz-TD
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e5Yuh-0002Ab-0M
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1e5Yug-00029N-Pp
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:08:42 -0400
References: <20171020101219.2378-1-pbonzini@redhat.com>
	<CAFEAcA9uEmoxgF4Ra9+u==kyou3GHw9BzuXJn1RGuraikY1h3Q@mail.gmail.com>
	<9695ca9b-6275-d7bf-1c3b-147aeab25473@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ec107687-d109-9eaa-780c-851f73971178@redhat.com>
Date: Fri, 20 Oct 2017 17:08:38 +0200
MIME-Version: 1.0
In-Reply-To: <9695ca9b-6275-d7bf-1c3b-147aeab25473@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: disable -Wmissing-braces on older
 compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/20/17 13:02, Paolo Bonzini wrote:
> On 20/10/2017 12:48, Peter Maydell wrote:
>> On 20 October 2017 at 11:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> GCC 4.9 and newer stopped warning for missing braces around the
>>> "universal" C zero initializer {0}.  One such initializer sneaked
>>> into scsi/qemu-pr-helper.c and is breaking the build with such
>>> older GCC versions.
>>>
>>> Detect the lack of support for the idiom, and disable the warning
>>> in that case.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> AFAIK "{}" will work and not be warned about anywhere (we
>> use it extensively already) so you don't need to fall back to
>> memset...
> 
> Doh, of course that will work in scsi/qemu-pr-helper.c.  In general you
> can use {0} but not {} to initialize a scalar, like
> 
> 	IDontKnowIfItsAnArrayOrPointer x = {};	//might fail
> 	IDontKnowIfItsAnArrayOrPointer x = {0};	//always works
> 
> I'm not sure if that matters.

My remark below might matter even less, but:

I'd find it regrettable if we suppressed a wrong gcc warning about a
valid C construct by replacing the construct with a GNU-ism that is
*not* standard C. :/

Laszlo
