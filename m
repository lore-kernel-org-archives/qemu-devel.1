Received: from eggs.gnu.org ([2001:4830:134:3::10]:55143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDSF5-0003QN-SH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDSF2-0005AX-MR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:42:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gDSF2-00057a-Dl
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:42:52 -0400
References: <20181011192513.63634-1-dgilbert@redhat.com>
	<20181011192513.63634-3-dgilbert@redhat.com>
	<20181017192826.GA7385@flamenco>
	<286c9ba0-05d9-02ec-7f59-34b34a66be2c@redhat.com>
	<20181018124328.GA1040@flamenco>
	<590abdea-cd12-651b-7130-86c1786da99a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d6f3d79-fc23-4cdc-1a4c-7b3c4cf939f0@redhat.com>
Date: Fri, 19 Oct 2018 12:42:45 +0200
MIME-Version: 1.0
In-Reply-To: <590abdea-cd12-651b-7130-86c1786da99a@redhat.com>
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
To: Wei Huang <wei@redhat.com>, "Emilio G. Cota" <cota@braap.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, quintela@redhat.com, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, i.maximets@samsung.com, den@openvz.org

On 2018-10-18 16:53, Wei Huang wrote:
> 
> 
> On 10/18/2018 07:43 AM, Emilio G. Cota wrote:
>> On Thu, Oct 18, 2018 at 14:38:01 +0200, Thomas Huth wrote:
>>> On 2018-10-17 21:28, Emilio G. Cota wrote:
>>>> Can anyone reproduce this? Otherwise, let me know what other info
>>>> I could provide.
>>>
>>> I've finally been able to reproduce it - seems like it only happens here
>>> when the host is under heavy load.
> 
> Given that it only happens under heavy load, could the failure be caused
> by migration thresholds defined in migrate_postcopy_prepare()? You can
> play with "max-bandwidth", "downtime-limit" and others to see if it helps.

David suggested on IRC yesterday that this problem might be the same as
with the ppc64 migration test: It does not work with TCG, only with KVM.

I've now done some tests, and indeed, I can not reproduce the problem
when running with KVM on a s390x host. But as soon as I disable the kvm
kernel module and run the test with TCG there, the problem occurs again.

So I think I'll send a patch to disable this test with TCG for now. Once
the problem with TCG has been solved, we can enable it again.

 Thomas
