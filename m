Received: from eggs.gnu.org ([2001:4830:134:3::10]:47585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fxyis-0007pZ-5T
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 14:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fxyio-0008Vn-Uj
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 14:09:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fxyio-0008VY-LL
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 14:09:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w86I8qkX095514
	for <qemu-devel@nongnu.org>; Thu, 6 Sep 2018 14:09:37 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mb6j27qw3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 14:09:36 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 6 Sep 2018 12:09:36 -0600
References: <1532115624-27568-1-git-send-email-walling@linux.ibm.com>
	<20180808190023.GN2734@work-vm>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 6 Sep 2018 14:09:31 -0400
MIME-Version: 1.0
In-Reply-To: <20180808190023.GN2734@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c7781746-5bc5-be44-9596-b4504ea1d5a2@linux.ibm.com>
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

On 08/08/2018 03:00 PM, Dr. David Alan Gilbert wrote:
> * Collin Walling (walling@linux.ibm.com) wrote:
>> When typing 'help' followed by an unknown command, QEMU will
>> not print anything to the command line to let the user know
>> they typed a bad command. Let's fix this by printing a message
>> to the monitor when this happens. For example:
>>
>>     (qemu) help xyz
>>     unknown command: 'xyz'
>>
>> Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 

Thank you for the R-b. 

And pardon my impatience, but any chance this patch might get picked up, or
does it require some more review first?

[...]


-- 
Respectfully,
- Collin Walling
