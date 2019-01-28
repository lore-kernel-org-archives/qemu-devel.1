Received: from eggs.gnu.org ([209.51.188.92]:37545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1go3RX-0003cv-Cm
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1go3RV-0000aS-Sv
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:43:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:12790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1go3RV-0000ZG-JR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:43:01 -0500
References: <20190111153451.14304-1-tao3.xu@intel.com>
	<20190111153451.14304-5-tao3.xu@intel.com>
	<859ba7db-4129-1f8b-f4e4-8609f2d3755d@redhat.com>
	<1c57aaaf-4c12-fb6e-7d59-c113004dc3a8@intel.com>
	<e781ace4-b415-2325-d74f-88f586de6dda@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <d4fef646-8c95-aa60-b116-8f54ed2ce71e@intel.com>
Date: Mon, 28 Jan 2019 17:42:54 +0800
MIME-Version: 1.0
In-Reply-To: <e781ace4-b415-2325-d74f-88f586de6dda@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/9] Extend the command-line to provide
 memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, mst@redhat.com, imammedo@redhat.com
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, danmei.wei@intel.com, rth@twiddle.net

On 1/22/2019 1:09 AM, Eric Blake wrote:
> On 1/21/19 12:03 AM, Tao Xu wrote:
> 
>>>>    #
>>>> +# @hmat-lb: memory latency and bandwidth information (Since: 2.13)
>>> s/2.13/4.0/ (probably in multiple spots in your series)
>> Hi Eric,
>>
>> Thank you for your comments. The spell mistakes in patches 1/9 to 6/9
>> have been corrected in patch 7/9. Because patches 1/9 to 6/9 are jingqi's
>> initial V1 patchesand7/9 to 9/9 are the changes compared withV1.
> 
> Still, it's better to rebase the series to avoid the mistakes in the
> first place, instead of having churn with a mistake early in the series
> corrected only later in the series.  Even if the mistake is corrected by
> a different author than the bulk of the patch, as long as there are
> Signed-off-by lines for both the original author and the person making
> the spelling correction, then proper attribution has been made.
> 
>>
>> About s/2.13/4.0/,do you mean ACPI HMAT will not be merged before QEMU
>> 4.0?
> 
> Correct - 4.0 is the next release planned.  There was no 2.13 release;
> after 2.12 was the 3.0 release; the current release is 3.1, and the next
> release is 4.0; for more details, see
> https://www.qemu.org/2018/08/15/qemu-3-0-0/ for a description of the
> current version numbering scheme.  And even making it in time for 4.0
> means polishing this by mid-March: https://wiki.qemu.org/Planning/4.0
> 
>>
>> In addition, do you have any other comments about these patches?
> 
> I was commenting on the high-level user interface issues, but will leave
> the bulk of the technical review to those more familiar with the code
> being added.
> 
Hi Eric, I am sorry for asking you so frequently and don't mean to rush 
you. Could you tell me when I can know this comments on the high-level 
user interface issues? So that I can improve my patch in the next 
version. Thank you and looking forward to your reply!
