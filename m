Received: from eggs.gnu.org ([2001:4830:134:3::10]:60138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6evV-0004jj-9b
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6evS-0006C5-0i
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6evR-0006Br-Qt
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:13:45 -0400
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170505074143.GB21435@lemon.lan>
	<298bd169-6f9f-e622-1b8b-85ef126d8d0c@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca23d2f5-1296-976b-fe98-35277eb632f9@redhat.com>
Date: Fri, 5 May 2017 17:13:41 +0200
MIME-Version: 1.0
In-Reply-To: <298bd169-6f9f-e622-1b8b-85ef126d8d0c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/5] Enable virtio-scsi boot from
 /dev/sgX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>, Fam Zheng <famz@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 05/05/2017 17:03, Eric Farman wrote:
> We get a value of x3fffff when sending that to a scsi-disk from bios
> code.  That's fully emulated though, in scsi_disk_emulate_inquiry.  And
> that's the scenario that already works.
> 
> While there is indeed code in hw/scsi/scsi-generic.c to wire that in,
> that only happens after the I/O goes to the device itself.  The Block
> Limits page isn't supported [1] and thus it gets rejected with "invalid
> field in cdb".  We never get to that fixup code you reference, since the
> returned len is zero.
> 
> Should I be refactoring this code to always patch in that block limit
> regardless of a response from the host/device?  (That is, when page xb0
> isn't supported by the hw.)

What is the BLKSECTGET value you get?  Is there a sensible default value
that you can use when page 0xb0 isn't supported by the hardware?

Thanks,

Paolo
