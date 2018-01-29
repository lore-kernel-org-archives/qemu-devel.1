Received: from eggs.gnu.org ([2001:4830:134:3::10]:42935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg6PH-0001Pj-P6
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg6PC-0007Jg-RY
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:11:19 -0500
From: David Hildenbrand <david@redhat.com>
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-10-git-send-email-walling@linux.vnet.ibm.com>
	<362b0cf9-b6e5-e606-ffb7-84cf8e2a4537@redhat.com>
Message-ID: <cb76fcbb-5698-72f9-f679-6b1490456a26@redhat.com>
Date: Mon, 29 Jan 2018 11:11:11 +0100
MIME-Version: 1.0
In-Reply-To: <362b0cf9-b6e5-e606-ffb7-84cf8e2a4537@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 09/10] s390-ccw: read user
 input for boot index via the SCLP console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 29.01.2018 11:07, David Hildenbrand wrote:
> On 23.01.2018 19:26, Collin L. Walling wrote:
>> Implements an sclp_read function to capture input from the
>> console and a wrapper function that handles parsing certain
>> characters and adding input to a buffer. The input is checked
>> for any erroneous values and is handled appropriately.
>>
>> A prompt will persist until input is entered or the timeout
>> expires (if one was set). Example:
>>
>>     Please choose (default will boot in 10 seconds):
> 
> Wondering if it would be possible to print the list of boot options
> (just like zipl, if that is possible).

Just answered my question with patch 8 :)

-- 

Thanks,

David / dhildenb
