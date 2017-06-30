Received: from eggs.gnu.org ([2001:4830:134:3::10]:36833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQypk-00027c-Dg
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQypf-0005cS-Gc
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQypf-0005bP-Ae
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:31:47 -0400
Date: Fri, 30 Jun 2017 17:31:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170630163139.GC2437@work-vm>
References: <70ef6f1f-27f4-133f-ab33-03a30f19867b@de.ibm.com>
	<20170424105344.GF2362@work-vm>
	<75a4c5ff-385e-31ac-5f86-883b082cd94e@de.ibm.com>
	<20170424143516.GD2075@work-vm>
	<5c0608dd-ba22-dc09-71a1-bb95c977f77d@de.ibm.com>
	<20170424191202.GQ2362@work-vm>
	<097a5085-1128-cf2d-abc4-54660a608f36@de.ibm.com>
	<20170426110144.GF2098@work-vm>
	<cbf8c55d-9473-9f6f-eb89-779afe7c1fd2@de.ibm.com>
	<cec279c5-9900-ca28-103b-b95c36d9d989@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec279c5-9900-ca28-103b-b95c36d9d989@de.ibm.com>
Subject: Re: [Qemu-devel] postcopy migration hangs while loading virtio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, thuth@redhat.com

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> On 04/26/2017 01:45 PM, Christian Borntraeger wrote:
> 
> >> Hmm, I have a theory, if the flags field has bit 1 set, i.e. RAM_SAVE_FLAG_COMPRESS
> >> then try changing ram_handle_compressed to always do the memset.
> > 
> > FWIW, changing ram_handle_compressed to always memset makes the problem go away.
> 
> It is still running fine now with the "always memset change"

Did we ever nail down a fix for this; as I remember Andrea said
we shouldn't need to do that memset, but we came to the conclusion
it was something specific to how s390 protection keys worked.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
