Received: from eggs.gnu.org ([2001:4830:134:3::10]:60944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ellqT-0000ZW-Mv
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 20:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ellqQ-0000sD-Mh
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 20:26:49 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ellqQ-0000qC-CP
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 20:26:46 -0500
Received: by mail-wm0-f66.google.com with SMTP id t74so19430022wme.3
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 17:26:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <270e884b-9a6a-3902-b9d4-4e4635d73fec@redhat.com>
References: <20171225025107.23985-1-famz@redhat.com>
	<270e884b-9a6a-3902-b9d4-4e4635d73fec@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Wed, 14 Feb 2018 09:26:04 +0800
Message-ID: <CAK1Eb9nV0Mm04vRvDaaHNczmQEpWEC3cyxLy281YPEBsDUYjew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Test creating overlay when
 guest running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>

Ping?

On Thu, Jan 4, 2018 at 6:18 AM, Eric Blake <eblake@redhat.com> wrote:
> On 12/24/2017 08:51 PM, Fam Zheng wrote:
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>
>> ---
>>
>> v2: Actually test the thing. [Kevin]
>> ---
>>  tests/qemu-iotests/153     | 8 +++++---
>>  tests/qemu-iotests/153.out | 7 ++++---
>>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>>
>> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
>> index fa25eb24bd..adfd02695b 100755
>> --- a/tests/qemu-iotests/153
>> +++ b/tests/qemu-iotests/153
>> @@ -32,6 +32,7 @@ _cleanup()
>>  {
>>      _cleanup_test_img
>>      rm -f "${TEST_IMG}.base"
>> +    rm -f "${TEST_IMG}.overlay"
>
> Trivial conflict with Jeff's work to do per-test temporary directories
> in iotests.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
