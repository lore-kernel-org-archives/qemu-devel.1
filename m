Received: from eggs.gnu.org ([2001:4830:134:3::10]:43622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dG6OK-0004E8-Sh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dG6OH-0005sM-Mi
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:22:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60311
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dG6OH-0005ru-Fi
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:22:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4VGJ7r8041981
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:22:32 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2at0k224ke-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:22:31 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 31 May 2017 17:22:30 +0100
References: <20170529131716.94338-1-pasic@linux.vnet.ibm.com>
	<20170531160056.GC3342@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 31 May 2017 18:22:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170531160056.GC3342@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <12c80951-41da-e172-2189-7772c3425f1b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: vmstatify config migration for
 virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org



On 05/31/2017 06:00 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
>> flexibility (extending using subsections) and for fun.
>>
>> To achieve this we need to hack the config_vector, which is VirtIODevice
>> (that is common virtio) state, in the middle of the VirtioCcwDevice state
>> representation.  This somewhat ugly, but we have no choice because the

s/This somewhat/This is somewhat
                    
>> stream format needs to be preserved.
> 
> I don't think the hack you have here is any different to the existing
> code really; the flow is pretty much the same.
> 

I agree, it's the best we can do, but still a qdev device migrating the
state of some other qdev device is ugly to me. I prefer keeping the
explanation, as neither what has to be done, nor how it is done is
really straight forward. If you recommend dropping the sentence I
can do that to.

>> Almost no changes in behavior. Exception is everything that comes with
>> vmstate like extra bookkeeping about what's in the stream, and maybe some
>> extra checks and better error reporting.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> Without actually understanding any of the s390 magic, it does look
> like a faithful conversion, so:
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks a lot! I guess Connie is going to have to take the
responsibility and review the s390 magic. This has to go
trough her tree anyway. The eyes of an migration expert are
highly appreciated (even if its s390 only code)! 

Will wait for Connie and probably re-spin with your r-b and
the above typo fixed.

Cheers,
Halil
