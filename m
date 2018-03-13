Received: from eggs.gnu.org ([2001:4830:134:3::10]:41589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eviE1-0005Rw-93
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eviDx-0002XV-Es
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:36:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eviDx-0002Wy-8X
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:36:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id o1so9901621wro.10
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 04:36:09 -0700 (PDT)
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-29-brijesh.singh@amd.com>
	<20180308170824.GL4718@redhat.com>
	<e6db1aaa-83c7-ae5c-2311-bc247b301426@amd.com>
	<20180308214504.GE3417@localhost.localdomain>
	<20180309101200.GB3213@work-vm>
	<3c921c44-980c-7cb2-4c89-cdf251df4d8d@redhat.com>
	<537c6968-d157-6f63-4c28-e1fbbd1124f5@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27a2cacf-a6b5-5b0f-4b4e-c560262afefa@redhat.com>
Date: Tue, 13 Mar 2018 12:36:04 +0100
MIME-Version: 1.0
In-Reply-To: <537c6968-d157-6f63-4c28-e1fbbd1124f5@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 28/28] tests/qmp-test: blacklist sev
 specific qmp commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Borislav Petkov <bp@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Alistair Francis <alistair.francis@xilinx.com>, Bruce Rogers <brogers@suse.com>

On 13/03/2018 12:21, Brijesh Singh wrote:
>> The KVM side is a pretty linear use of the kernel API.  I'm not very
>> happy with the debug API for MemoryRegions (but it's not really
>> Brijesh's fault), so my plan would be to merge it without debug support.
> 
> Thanks Paolo, I am working to drop the complete debug support and will
> send series very soon. I need to run some quick smoke test to make sure
> I don't break SEV guest support.

Just test the pull request I'll send in less than an hour. :)

Paolo
