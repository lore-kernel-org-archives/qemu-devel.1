Received: from eggs.gnu.org ([2001:4830:134:3::10]:36376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cp16K-0002Cs-9S
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 19:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cp16F-0003BV-6B
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 19:16:04 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cp16E-0003BM-Rr
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 19:15:58 -0400
Received: by mail-pf0-x241.google.com with SMTP id o126so10030239pfb.1
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 16:15:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
	<20170317114953.GF8050@redhat.com>
	<CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b7c2b50f-5d0b-e21b-c4e7-ef496705654c@twiddle.net>
Date: Sat, 18 Mar 2017 09:15:50 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 03/17/2017 09:52 PM, Peter Maydell wrote:
> On 17 March 2017 at 11:49, Daniel P. Berrange <berrange@redhat.com> wrote:
>> On Fri, Mar 17, 2017 at 11:08:22AM +0000, Peter Maydell wrote:
>>> We plan to drop support in a future QEMU release for host OSes
>>> and host architectures for which we have no test machine where
>>> we can build and run tests. For the 2.9 release, make configure
>>> print a warning if it is run on such a host, so that the user
>>> has some warning of the plans and can volunteer to help us
>>> maintain the port if they need it to continue to function.
>>>
>>> This commit flags up as deprecated the CPU architectures:
>>>  * ia64
>>>  * sparc
>>>  * anything which we don't have a TCG port for
>>>    (and which was presumably using TCI)
>>
>> This seems to imply that if we remove supported for these architectures,
>> then TCI is no longer required either, or would there be other reasons
>> to want to keep TCI around, even when all host archs have a TCG port ?
>
> I've never really seen the point in TCI, but others do, which
> is why it's in the tree.

I don't see the point in TCI, because it's known to not work for any host that 
has non-trivial calling conventions.

You may recall I once did a re-write that did use libffi to overcome that 
problem.  However, you rightly pointed out at the time that it's just as easy 
to write a proper host backend if one actually cares.


r~
