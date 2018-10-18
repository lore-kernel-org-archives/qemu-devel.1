Received: from eggs.gnu.org ([2001:4830:134:3::10]:43661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1gD9gB-0007ST-9z
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1gD9g5-0001dj-5p
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1gD9g4-0001Q7-Ma
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:53:32 -0400
References: <20181011192513.63634-1-dgilbert@redhat.com>
	<20181011192513.63634-3-dgilbert@redhat.com>
	<20181017192826.GA7385@flamenco>
	<286c9ba0-05d9-02ec-7f59-34b34a66be2c@redhat.com>
	<20181018124328.GA1040@flamenco>
From: Wei Huang <wei@redhat.com>
Message-ID: <590abdea-cd12-651b-7130-86c1786da99a@redhat.com>
Date: Thu, 18 Oct 2018 09:53:13 -0500
MIME-Version: 1.0
In-Reply-To: <20181018124328.GA1040@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/7] tests/migration: Enable the migration
 test on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, quintela@redhat.com, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, i.maximets@samsung.com, den@openvz.org



On 10/18/2018 07:43 AM, Emilio G. Cota wrote:
> On Thu, Oct 18, 2018 at 14:38:01 +0200, Thomas Huth wrote:
>> On 2018-10-17 21:28, Emilio G. Cota wrote:
>>> Can anyone reproduce this? Otherwise, let me know what other info
>>> I could provide.
>>
>> I've finally been able to reproduce it - seems like it only happens here
>> when the host is under heavy load.

Given that it only happens under heavy load, could the failure be caused
by migration thresholds defined in migrate_postcopy_prepare()? You can
play with "max-bandwidth", "downtime-limit" and others to see if it helps.

>>
>> ... not sure whether I've got time to debug this before KVM forum, so if
>> it bugs you, feel free to send a patch to disable the test in
>> tests/Makefile.include for s390x again.
> 
> Glad you could reproduce! I'll disable the test locally for now.
> 
> Thanks,
> 
> 		Emilio
> 
