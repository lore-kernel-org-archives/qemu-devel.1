Received: from eggs.gnu.org ([2001:4830:134:3::10]:49677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxWWG-0004Dm-EM
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxWWB-000106-AR
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:26:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3424
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxWWA-0000vA-SU
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:25:55 -0400
Message-ID: <58EB5D9E.3040504@huawei.com>
Date: Mon, 10 Apr 2017 18:25:34 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1491814858-63428-1-git-send-email-longpeng2@huawei.com>
	<20170410095133.GC3655@redhat.com>
In-Reply-To: <20170410095133.GC3655@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 15/19] tests: crypto: add cipher
 speed case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

Hi Daniel,

Ok, I'll take all your suggestions, and fix them in next version.

Thanks.

On 2017/4/10 17:51, Daniel P. Berrange wrote:

> On Mon, Apr 10, 2017 at 05:00:58PM +0800, Longpeng(Mike) wrote:
>> Now we have afalg-backend and libiary-backend, it's necessary
>> to add the speed test in test-crypto-cipher.
>>
>> We can use "./tests/test-crypto-cipher speed" to do the speed
>> test.
> 
> This is not using any of the existing code for the benchmark, so there's
> no real benefit to having it in this file.
> 
> I'd suggest creating a separate test program for performance benchmarking,
> eg  tests/benchmark-crypto-cipher, that would be invoked separately as &
> when needed ie skipped by make check-unit, but run by a 'make check-speed'.
> 
> Likewise for the other tests you've changed later in this series.
> 
> 
> Regards,
> Daniel


-- 
Regards,
Longpeng(Mike)
