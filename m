Received: from eggs.gnu.org ([2001:4830:134:3::10]:58204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQdSi-0007Og-Sz
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQdSh-0000NI-Tc
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:10:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cQdSh-0000Mv-OF
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:10:23 -0500
References: <1483628868-10496-1-git-send-email-nutarojj@ornl.gov>
	<0f3d6652-e633-c02e-7234-0d5b885d31ea@redhat.com>
	<283fd6b709734ccdbeb6d217f8b32043@EXCHCS32.ornl.gov>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33a6f57d-4563-ec4a-f77f-1a15ca57c19d@redhat.com>
Date: Mon, 9 Jan 2017 18:10:20 +0100
MIME-Version: 1.0
In-Reply-To: <283fd6b709734ccdbeb6d217f8b32043@EXCHCS32.ornl.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] qqq: module for synchronizing with a
 simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Nutaro, James J." <nutarojj@ornl.gov>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 09/01/2017 18:04, Nutaro, James J. wrote:
> Thanks again Paolo. When I change the command line switches, is it best to submit a whole new version of the patch? Or is there another method for managing patch revisions?

Yes, submit a new version, then put

v6->v7: did this and that [Paolo]

at the end of the commit message, where the square brackets mean
"suggested by...".

Thanks,

Paolo

> 
> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com] 
> Sent: Thursday, January 05, 2017 10:27 AM
> To: Nutaro, James J.; qemu-devel@nongnu.org
> Subject: Re: [PATCH v6] qqq: module for synchronizing with a simulation
> 
> 
> 
> On 05/01/2017 16:07, James J. Nutaro wrote:
>> This patch adds an interface for pacing the execution of QEMU to match an external
>> simulation clock. Its aim is to permit QEMU to be used as a module within a
>> larger simulation system.
>>
>> Signed-off-by: James J. Nutaro <nutarojj@ornl.gov>
> 
> What's the difference between v5 and v6?
> 
>> +(2) Fork QEMU with the appropriate command line arguments.
>> +    The -qqq part of the argument will look something like
>> +
>> +       -qqq sock=socks[1]
> 
> No need for -qqq, just make it "-icount extclock=FD".
> 
> Paolo
> 
