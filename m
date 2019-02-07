Received: from eggs.gnu.org ([209.51.188.92]:45893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grjNX-0000TO-NE
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grjNV-0001lo-L3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:06:07 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grjNT-0001jn-JS
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:06:03 -0500
Received: by mail-wr1-x434.google.com with SMTP id a16so11512971wrv.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 05:06:02 -0800 (PST)
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
	<20190207114913.2c5f2c5b.cohuck@redhat.com>
	<6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
	<ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
	<1a3f847e-a371-eacb-8be6-678bb3c20b05@debian.org>
	<951bf77e-f953-48aa-9e2e-3f7c66bb9db2@redhat.com>
	<78990142-121a-f84d-811b-60ec503f394b@linaro.org>
	<c5e3a50d-cc63-1933-be4c-69c031296bf6@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a4cb5b65-5962-80a3-d417-c986ef566d34@linaro.org>
Date: Thu, 7 Feb 2019 13:05:57 +0000
MIME-Version: 1.0
In-Reply-To: <c5e3a50d-cc63-1933-be4c-69c031296bf6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Giovanni Mascellani <gio@debian.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org

On 2/7/19 12:36 PM, Thomas Huth wrote:
> On 2019-02-07 13:15, Richard Henderson wrote:
>> See also
>>
>>   https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg06734.html
>>
>> which I never followed up on the review changes requested.
> 
> Ah, right, now that you've mentioned it, it rings a bell! Do you have
> some spare time to respin the series, with using time2tod() in the
> HELPER(stck) function?

I'll try to do so tomorrow.


r~
