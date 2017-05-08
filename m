Received: from eggs.gnu.org ([2001:4830:134:3::10]:32978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7lBJ-0002G6-SV
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7lBG-0001G9-Nu
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:06:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d7lBG-0001Fy-I3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:06:38 -0400
References: <20170505032340.26467-1-famz@redhat.com>
	<03beb071-ebbc-4328-3530-37b9856476cc@redhat.com>
	<20170508155511.GX18871@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3c224dd-baa1-e132-089f-d1707d5bb641@redhat.com>
Date: Mon, 8 May 2017 18:06:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170508155511.GX18871@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 08/05/2017 17:55, Daniel P. Berrange wrote:
>>
>> For patch 5, I think we should revive the "quick" qemu-iotests group
>> (maybe we can have support for skipping groups, and have a "slow" group
>> with the very few tests that take >30 seconds?) and add the quick tests
>> to "make check".
> 'quick' not only depends on the test case, but also the backend.
> Most of the so called 'quick' tests are very slow with qcow v1 (over
> your 30 sec mark), and can also be fairly slow with LUKS too.

You could define two groups: "quick" for those that are pretty much
guaranteed to be fast with all backends, "slow" for those that are
guaranteed to be slow with all backends.

Then CI can use "!slow" when running with selected backends (raw, qcow2,
raw-over-NBD) and "quick" for other backends.

Paolo
