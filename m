Received: from eggs.gnu.org ([2001:4830:134:3::10]:38607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eSIk2-0002Iy-De
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eSIjy-0005jY-7G
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:31:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eSIjy-0005iz-2B
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:31:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7D915F7AC
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 08:31:36 +0000 (UTC)
References: <20171221212125.19075-1-maxime.coquelin@redhat.com>
	<20171222004937-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <1d5fc27d-5ff9-8637-dcc1-8fccca9038b0@redhat.com>
Date: Fri, 22 Dec 2017 09:31:29 +0100
MIME-Version: 1.0
In-Reply-To: <20171222004937-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/5] vhost-user-test: Fixes & code
 clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mlureau@redhat.com



On 12/21/2017 11:49 PM, Michael S. Tsirkin wrote:
> On Thu, Dec 21, 2017 at 10:21:20PM +0100, Maxime Coquelin wrote:
>> Sorry, I missed to fixup the feature mask in patch 4,
>> this is the only change in this v3.
>>
>> The two changes in v2 are fixing the features mask
>> before the function rework, and reword of commit message
>> of patch "vhost-user-test: extract read-guest-mem test
>> from main loop" (Thanks Marc-Andr=C3=A9).
>>
>> This series fixes two issues in vhost-user-test:
>> 1. Setup virtqueues in all tests
>> 2. Fix features mask for all but test_multiqueue()
>>
>> The clean-ups comprises making read-guest-mem test consistent
>> with other tests by initializing the device in the qtest thread.
>> Also, some code factorization is done with regard to device
>> initialization so that all tests share the same init.
>=20
> Looks like mingw tests fail with this.

No, the build issue with mingw is due to a regression in master.

Laurent posted a patch to fix it:
[PATCH] hw/i386/vmport: fix missing definitions with x86_64-w64-mingw32
Message-Id: <20171221211103.30311-1-laurent@vivier.eu>

Maxime
>> Maxime Coquelin (5):
>>    vhost-user-test: fix features mask
>>    vhost-user-test: extract read-guest-mem test from main loop
>>    vhost-user-test: setup virtqueues in all tests
>>    vhost-user-test: make features mask an init_virtio_dev() argument
>>    vhost-user-test: use init_virtio_dev in multiqueue test
>>
>>   tests/vhost-user-test.c | 171 ++++++++++++++++++++++----------------=
----------
>>   1 file changed, 79 insertions(+), 92 deletions(-)
>>
>> --=20
>> 2.14.3
