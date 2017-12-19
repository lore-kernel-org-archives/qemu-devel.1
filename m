Received: from eggs.gnu.org ([2001:4830:134:3::10]:55903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eRLiI-0007yi-OI
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eRLiE-0004Xp-20
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:29:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eRLiD-0004XT-Rl
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:29:53 -0500
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-5-marcel@redhat.com>
	<20171219181158-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <2af2c1a1-c099-0dde-211e-361c29f6a3ce@redhat.com>
Date: Tue, 19 Dec 2017 19:29:45 +0200
MIME-Version: 1.0
In-Reply-To: <20171219181158-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com

On 19/12/2017 18:12, Michael S. Tsirkin wrote:
> On Sun, Dec 17, 2017 at 02:54:56PM +0200, Marcel Apfelbaum wrote:
>> @@ -2847,15 +2847,16 @@ if test "$rdma" != "no" ; then
>>   #include <rdma/rdma_cma.h>
>>   int main(void) { return 0; }
>>   EOF
>> -  rdma_libs="-lrdmacm -libverbs"
>> +  rdma_libs="-lrdmacm -libverbs -libumad"
>>     if compile_prog "" "$rdma_libs" ; then
>>       rdma="yes"
>>     else
>> +    libs_softmmu="$libs_softmmu $rdma_libs"
>>       if test "$rdma" = "yes" ; then
>>           error_exit \
>> -            " OpenFabrics librdmacm/libibverbs not present." \
>> +            " OpenFabrics librdmacm/libibverbs/libibumad not present." \
>>               " Your options:" \
>> -            "  (1) Fast: Install infiniband packages from your distro." \
>> +	    "  (1) Fast: Install infiniband packages (devel) from your distro." \
>>               "  (2) Cleanest: Install libraries from www.openfabrics.org" \
>>               "  (3) Also: Install softiwarp if you don't have RDMA hardware"
>>       fi
> 
> Some whitespace damage here.
> 

Thanks Michael, we will take care of that and go over
the code again to spot similar issues.

Marcel
