Received: from eggs.gnu.org ([2001:4830:134:3::10]:52006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ryo_on@yk.rim.or.jp>) id 1cvX5T-0003jJ-5u
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ryo_on@yk.rim.or.jp>) id 1cvX5Q-0000nJ-3x
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:38:07 -0400
Received: from mail111.siriuscloud.jp ([219.118.72.111]:58275
	helo=mail01.SiriusCloud.jp) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ryo_on@yk.rim.or.jp>) id 1cvX5P-0000lL-QL
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:38:04 -0400
Date: Wed, 05 Apr 2017 07:38:07 +0900 (JST)
Message-Id: <20170405.073807.1910382251709225887.ryo_on@yk.rim.or.jp>
From: Ryo ONODERA <ryo_on@yk.rim.or.jp>
In-Reply-To: <CAFEAcA_TrA+hwNVTZ0_vb0dGBjcLi+xzkgZ5KNamBmiLsddVWQ@mail.gmail.com>
References: <CAFEAcA83HujBVrbYgXdfJq5YXTqzX9rOSLeGPgdtxaG2TwsbNw@mail.gmail.com>
	<20170405.072837.698655508316162287.ryo_on@yk.rim.or.jp>
	<CAFEAcA_TrA+hwNVTZ0_vb0dGBjcLi+xzkgZ5KNamBmiLsddVWQ@mail.gmail.com>
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

From: Peter Maydell <peter.maydell@linaro.org>, Date: Tue, 4 Apr 2017 23:30:42 +0100

> On 4 April 2017 at 23:28, Ryo ONODERA <ryo_on@yk.rim.or.jp> wrote:
>> I use qemu from master branch (with some modification) every weekend.
>> However I had never run 'make check'.
>> I will run 'make check'.
> 
> Hmm. ivshmem_server doesn't link for me, because
> it uses shm_open() but doesn't link with -lrt.
> So the build fails.

 My 'some modifications' contains fix for your problem.
I will submit it later.

Thank you.

> thanks
> -- PMM

--
Ryo ONODERA // ryo_on@yk.rim.or.jp
PGP fingerprint = 82A2 DC91 76E0 A10A 8ABB  FD1B F404 27FA C7D1 15F3
