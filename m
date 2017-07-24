Received: from eggs.gnu.org ([2001:4830:134:3::10]:45979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZeRw-0003g0-O3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZeRv-0001QV-S3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:35:08 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZeRv-0001NW-M0
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:35:07 -0400
Received: by mail-wm0-x22b.google.com with SMTP id c184so33453387wmd.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 07:35:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5c16cc8e-884c-6e2b-ad60-b72ef6c59337@redhat.com>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<5c16cc8e-884c-6e2b-ad60-b72ef6c59337@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 15:34:45 +0100
Message-ID: <CAFEAcA_njsLSkV1xvQ19j+89=prJGAbktkK9kNiaEQXTUtDkEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, Qemu-block <qemu-block@nongnu.org>

On 24 July 2017 at 15:28, Eric Blake <eblake@redhat.com> wrote:
> On 07/21/2017 04:34 AM, Stefan Hajnoczi wrote:
>> There is not much getting started documentation for qemu-iotests.  This
>> patch explains how to create a new test and covers the overall testing
>> approach.
>>
>> +2. Create the test file
>> +
>> +Copy an existing test (one that most closely resembles what you wish to test)
>> +to the new test number:
>> +
>> +  cp 001 <test-number>
>
> And mark it executable (chmod a+x <test-number>)

It should already be executable because the test file being
copied (001 in this case) is executable, shouldn't it?

thanks
-- PMM
