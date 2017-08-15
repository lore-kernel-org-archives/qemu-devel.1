Received: from eggs.gnu.org ([2001:4830:134:3::10]:58805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhhnW-0005Vn-RH
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhhnS-00055n-RH
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:46:42 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:34748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dhhnS-00055E-KA
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:46:38 -0400
Received: by mail-pg0-x22c.google.com with SMTP id u185so11611522pgb.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 12:46:38 -0700 (PDT)
References: <1502721197-32717-1-git-send-email-mst@redhat.com>
	<20170814173335.58f0e84f.cohuck@redhat.com>
	<2f4dafd1-ba08-0f61-735a-31edefcff1e3@linaro.org>
	<20170815222611-mutt-send-email-mst@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <00d26661-113b-fc4d-3485-1ef809c7dfe7@linaro.org>
Date: Tue, 15 Aug 2017 12:46:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170815222611-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: switch tests to accel=kvm:tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 08/15/2017 12:28 PM, Michael S. Tsirkin wrote:
>> Ouch.  This is the only real smoke test we have for the tcg backend for the
>> host.  While it is still going to test tcg for whatever machines do not run
>> natively on the host, I can't help think we've lost testing.
>>
>> Can we use accel=tcg:kvm instead?
>>
>>
>> r~
> 
> We can add an environment to disable kvm on qemu side,
> for e.g. CI systems who have spare time.

Hum.  I'm not especially keen on an environment variable that wouldn't be
useful for anything else.  I'd much rather adjust the test case so that plain
"make check" tests all that we need to test.


r~
