Received: from eggs.gnu.org ([2001:4830:134:3::10]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLnTS-0000Qw-UO
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLnTS-0003Ln-0h
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:23:26 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLnTR-0003Km-QQ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:23:25 -0400
Received: by mail-wr0-x22e.google.com with SMTP id q97so35047257wrb.2
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 02:23:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6e150052-91ca-d260-b0e9-6894f93fc15d@redhat.com>
References: <20170615152852.GB2399@work-vm>
	<6e150052-91ca-d260-b0e9-6894f93fc15d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Jun 2017 10:23:04 +0100
Message-ID: <CAFEAcA_pEkfR9w9+oES=965dkDBCo=2yAyWEQ_eujfcyu1XQ-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] ahci-test failures with 'Failed to get "write"
 lock'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On 15 June 2017 at 17:16, John Snow <jsnow@redhat.com> wrote:
> On 06/15/2017 11:28 AM, Dr. David Alan Gilbert wrote:
>> Hi,
>>   Peter noticed that there were some hangs in the ahci-test;
>> I can reproduce them on my laptop as long as the laptop has
>> some other load on it (a few md5sum /dev/zero's help).
>>
>> /x86_64/ahci/flush/migrate: qemu-system-x86_64: Failed to get "write" lock
>> Is another process using the image?
>> OK
>> /x86_64/ahci/migrate/sanity: qemu-system-x86_64: Failed to get "write" lock
>> Is another process using the image?
>>
>> and that hangs in sanity.
>>
>> That seems to be the common case, I've also had one:
>>
>> /x86_64/ahci/migrate/ncq/halted: qemu-system-x86_64: Failed to get "write" lock
>> Is another process using the image?
>> qemu-system-x86_64: /home/dgilbert/git/qemu/block/io.c:1352: bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed.
>>
>>
>> Neither of these always fail.

> Haven't observed myself and I run the tests pretty frequently. I'll keep
> an eye out. I see many similar problems in iotests for other areas, too.

If we can figure out this quickly that would be good -- it's
causing my build tests to fail often enough that I'm a bit
reluctant to try to merge more pull requests until we've
squished this bug...

thanks
-- PMM
