Received: from eggs.gnu.org ([2001:4830:134:3::10]:49854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gWjTo-0005H3-6F
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gWjTk-0000qM-5t
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:57:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gWjTj-0000lX-RQ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:57:44 -0500
References: <1544049446-6359-1-git-send-email-liam.merwick@oracle.com>
	<1544049446-6359-2-git-send-email-liam.merwick@oracle.com>
	<20181211140124.GA23460@stefanha-x1.localdomain>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <83b577e6-691e-08b3-e9e4-90651e988ff2@oracle.com>
Date: Tue, 11 Dec 2018 14:57:29 +0000
MIME-Version: 1.0
In-Reply-To: <20181211140124.GA23460@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/3] pvh: Add x86/HVM direct boot ABI header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, maran.wilson@oracle.com, George Kennedy <george.kennedy@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>



On 11/12/2018 14:01, Stefan Hajnoczi wrote:
> On Wed, Dec 05, 2018 at 10:37:24PM +0000, Liam Merwick wrote:
>> From: Liam Merwick <Liam.Merwick@oracle.com>
>>
>> The x86/HVM direct boot ABI permits Qemu to be able to boot directly
>> into the uncompressed Linux kernel binary without the need to run firmware.
>>
>> 	https://xenbits.xen.org/docs/unstable/misc/pvh.html
>>
>> This commit adds the header file that defines the start_info struct
>> that needs to be populated in order to use this ABI.
>>
>> Signed-off-by: Maran Wilson <Maran.Wilson@oracle.com>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> Reviewed-by: Konrad Rzeszutek Wilk <Konrad.Wilk@oracle.com>
>> ---
>>   include/hw/xen/start_info.h | 146 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 146 insertions(+)
>>   create mode 100644 include/hw/xen/start_info.h
> 
> Does it make sense to bring in Linux
> include/xen/interface/hvm/start_info.h via QEMU's
> include/standard-headers/?
> 
> QEMU has a script in scripts/update-linux-header.sh for syncing Linux
> headers into include/standard-headers/.  This makes it easy to keep
> Linux header files up-to-date.  We basically treat files in
> include/standard-headers/ as auto-generated.
> 
> If you define start_info.h yourself without using
> include/standard-headers/, then it won't be synced with Linux.
> 

That does seem better.  I will make that change.

One a related note, I'm trying to fix the mingw compilation errors [1] 
in this series also.  I can fix the format issues with PRIx64, etc but I 
can't seem to find an include file to provide a declaration of mmap() 
et. al. - has this been resolved before? A pointer to something similar 
to investigate would be very welcome.

Regards,
Liam

[1] 
http://patchew.org/logs/1544049446-6359-1-git-send-email-liam.merwick@oracle.com/testing.docker-mingw@fedora/?type=message
