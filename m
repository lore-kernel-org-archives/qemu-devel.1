Received: from eggs.gnu.org ([2001:4830:134:3::10]:47515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ryo_on@yk.rim.or.jp>) id 1cvWwS-00019m-50
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ryo_on@yk.rim.or.jp>) id 1cvWwN-0002oX-84
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:28:48 -0400
Received: from mail111.siriuscloud.jp ([219.118.72.111]:40810
	helo=mail01.SiriusCloud.jp) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ryo_on@yk.rim.or.jp>) id 1cvWwM-0002mr-UM
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:28:43 -0400
Date: Wed, 05 Apr 2017 07:28:37 +0900 (JST)
Message-Id: <20170405.072837.698655508316162287.ryo_on@yk.rim.or.jp>
From: Ryo ONODERA <ryo_on@yk.rim.or.jp>
In-Reply-To: <CAFEAcA83HujBVrbYgXdfJq5YXTqzX9rOSLeGPgdtxaG2TwsbNw@mail.gmail.com>
References: <20170405.062259.994335017099386017.ryo_on@yk.rim.or.jp>
	<CAFEAcA83HujBVrbYgXdfJq5YXTqzX9rOSLeGPgdtxaG2TwsbNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to provide build/CI environment for NetBSD host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

Hi,

From: Peter Maydell <peter.maydell@linaro.org>, Date: Tue, 4 Apr 2017 22:43:50 +0100

> On 4 April 2017 at 22:22, Ryo ONODERA <ryo_on@yk.rim.or.jp> wrote:
>> I saw "Warning of unsupported host systems"
>> in http://wiki.qemu-project.org/ChangeLog/2.9 wiki page.
>>
>> I would like to contribute to qemu's NetBSD host support.
>>
>> I can provide NetBSD/amd64(x86_64) 7-stable build
>> environment as build/CI machine to the qemu project
>> if nobody provides it to the project yet.
>>
>> How to provide build/CI environment to the qemu project?
> 
> Thanks for the offer. Since then, I've been able to set up
> a NetBSD VM, which is probably a reasonable CI environment.

Good news for me! Thank you very much!

> However, the other reason why netbsd isn't in the supported
> list is that when I tried compiling it it didn't pass the basic
> 'make; make check' test. So obviously nobody's been
> using or testing it :-(

I use qemu from master branch (with some modification) every weekend.
However I had never run 'make check'.
I will run 'make check'.

> You could start with looking at the compile failures
> and submitting patches.

O.k.
Thank you.

> thanks
> -- PMM

--
Ryo ONODERA // ryo_on@yk.rim.or.jp
PGP fingerprint = 82A2 DC91 76E0 A10A 8ABB  FD1B F404 27FA C7D1 15F3
