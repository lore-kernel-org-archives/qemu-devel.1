Received: from eggs.gnu.org ([2001:4830:134:3::10]:34681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ct8WB-0008R3-Tj
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 03:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ct8WB-0007fV-2L
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 03:59:48 -0400
References: <1490608126-22187-1-git-send-email-eric.auger@redhat.com>
	<1490608126-22187-4-git-send-email-eric.auger@redhat.com>
	<8737dxp4js.fsf@secure.mitica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bbcc8399-523e-1ac3-47ee-9b830b355739@redhat.com>
Date: Wed, 29 Mar 2017 09:59:35 +0200
MIME-Version: 1.0
In-Reply-To: <8737dxp4js.fsf@secure.mitica>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 3/3] hw/intc/arm_gicv3_its: Allow
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, peterx@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org

Hi Juan,

On 28/03/2017 21:47, Juan Quintela wrote:
> Eric Auger <eric.auger@redhat.com> wrote:
>> We change the restoration priority of both the GICv3 and ITS. The
>> GICv3 must be restored before the ITS and the ITS needs to be restored
>> before PCIe devices since it translates their MSI transactions.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
Thank you for your time.

Eric
> 
