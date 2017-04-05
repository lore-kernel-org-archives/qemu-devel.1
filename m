Received: from eggs.gnu.org ([2001:4830:134:3::10]:45139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cvlst-0002IC-EN
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cvlsq-0002fg-Aa
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:26:07 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:41264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cvlsq-0002eV-4C
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:26:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ONX00BOIXF9AZ30@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:25:57 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <36fe247f-4431-4ace-8819-9210512ac43a@samsung.com>
Date: Wed, 05 Apr 2017 17:25:54 +0300
MIME-version: 1.0
In-reply-to: <20170404175737.GL2147@work-vm>
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 7bit
References: <1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170318151330eucas1p102b9378cc23a399528fa7f2440846650@eucas1p1.samsung.com>
	<1489850003-5652-2-git-send-email-a.perevalov@samsung.com>
	<20170404175737.GL2147@work-vm>
Subject: Re: [Qemu-devel] [PATCH 1/2] userfault: add pid into uffd_msg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com

On 04/04/2017 08:57 PM, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>> ---
>>   linux-headers/linux/userfaultfd.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
>> index 2ed5dc3..7b299a2 100644
>> --- a/linux-headers/linux/userfaultfd.h
>> +++ b/linux-headers/linux/userfaultfd.h
>> @@ -77,6 +77,7 @@ struct uffd_msg {
>>   		struct {
>>   			__u64	flags;
>>   			__u64	address;
>> +			pid_t   pid;
>>   		} pagefault;
> Yes, but we'll just rerun the sync of the headers once your change
> lands in the kernel.
Like commit "update Linux headers to 4.6"? But I saw additional commit 
e.g. your.
Anyway, ok.

>
> Dave
>
>>   		struct {
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>


-- 
Best regards,
Alexey Perevalov
