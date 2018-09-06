Received: from eggs.gnu.org ([2001:4830:134:3::10]:55588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fy106-0005Hx-Sj
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 16:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fy103-0006SM-Hc
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 16:35:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53394
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fy103-0006Pt-8t
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 16:35:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w86KSp4U005901
	for <qemu-devel@nongnu.org>; Thu, 6 Sep 2018 16:35:34 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2mbb1vgtmf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 16:35:34 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 6 Sep 2018 16:35:33 -0400
References: <1532115624-27568-1-git-send-email-walling@linux.ibm.com>
	<20180808190023.GN2734@work-vm>
	<c7781746-5bc5-be44-9596-b4504ea1d5a2@linux.ibm.com>
	<20180906192841.GG2639@work-vm>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 6 Sep 2018 16:35:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180906192841.GG2639@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d86c2aaf-77ae-a6f3-521c-2ac4f45d61c3@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] monitor: print message when using
 'help' with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: stzi@linux.ibm.com, qemu-devel@nongnu.org, armbru@redhat.com

On 09/06/2018 03:28 PM, Dr. David Alan Gilbert wrote:
> * Collin Walling (walling@linux.ibm.com) wrote:
>> On 08/08/2018 03:00 PM, Dr. David Alan Gilbert wrote:
>>> * Collin Walling (walling@linux.ibm.com) wrote:
>>>> When typing 'help' followed by an unknown command, QEMU will
>>>> not print anything to the command line to let the user know
>>>> they typed a bad command. Let's fix this by printing a message
>>>> to the monitor when this happens. For example:
>>>>
>>>>     (qemu) help xyz
>>>>     unknown command: 'xyz'
>>>>
>>>> Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>
>>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>
>>
>> Thank you for the R-b. 
>>
>> And pardon my impatience, but any chance this patch might get picked up, or
>> does it require some more review first?
> 
> It will on my next HMP pull; it's just not many pulls are happening
> at the moment; it should be in by the end of the month.
> 
> Dave

Fair enough. Thank you for the update.

> 
>> [...]
>>
>>
>> -- 
>> Respectfully,
>> - Collin Walling
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


-- 
Respectfully,
- Collin Walling
