Received: from eggs.gnu.org ([2001:4830:134:3::10]:38735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMVS2-0003V6-Sz
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMVRp-0002ap-NB
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:57:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gMVRp-0002Z7-5o
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:57:29 -0500
References: <20180629145347.652-1-peter.maydell@linaro.org>
	<20180629145347.652-41-peter.maydell@linaro.org>
	<e8d62bcd-f8a9-2a6a-7765-0cf69cc8c1b5@redhat.com>
	<0840beac-a764-2fa9-98e3-da10f1f7d6bc@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <30881914-68f3-607d-b2ae-681f5621195e@redhat.com>
Date: Tue, 13 Nov 2018 10:57:23 +0100
MIME-Version: 1.0
In-Reply-To: <0840beac-a764-2fa9-98e3-da10f1f7d6bc@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 40/55] target/arm: Enable SVE for
 aarch64-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 13/11/2018 10:49, Richard Henderson wrote:
> On 11/12/18 10:10 PM, Laurent Vivier wrote:
>> Running some tests for my pull request, I've found this commit breaks
>> ltp-full-20180515 sigaltstack01 tests with ubuntu arm64/trusty.
>>
>> sigaltstack01  274  TBROK  :  tst_sig.c:233: unexpected signal
>> SIGIOT/SIGABRT(6) received (pid = 15241).
>> *** Error in `/opt/ltp/testcases/bin/sigaltstack01': free(): invalid
>> pointer: 0x000000000042a010 ***
> 
> How exactly does one reproduce this failure?
> 
> $ ~/qemu/bld/aarch64-linux-user/qemu-aarch64 -cpu max
> ./testcases/kernel/syscalls/sigaltstack/sigaltstack01
> sigaltstack01    1  TPASS  :  Functionality of sigaltstack() successful

For me it happens only with Ubuntu trusty:

sudo chroot chroot/arm64/trusty /opt/ltp/testcases/bin/sigaltstack01

Thanks,
Laurent
