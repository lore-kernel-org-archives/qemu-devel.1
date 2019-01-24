Received: from eggs.gnu.org ([209.51.188.92]:41373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gmj0W-0006FB-NE
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gmj0K-00056P-Oc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:41:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gmj0I-00054k-9I
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:41:26 -0500
References: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
	<20190107091618.GD27089@stefanha-x1.localdomain>
	<e2e14237-32be-8e3d-242c-c19e98d04d60@redhat.com>
	<alpine.LRH.2.21.1901172312550.8075@linux.fjfi.cvut.cz>
	<aeb7e3b4-b776-1ee3-d4a0-d39c3e44ac31@redhat.com>
	<alpine.LRH.2.21.1901210003120.12076@linux.fjfi.cvut.cz>
	<0bf4c4ed-ba51-7723-66ea-43bb162691a8@redhat.com>
	<alpine.LRH.2.21.1901241039400.4050@linux.fjfi.cvut.cz>
From: John Snow <jsnow@redhat.com>
Message-ID: <dec1406d-464a-1245-0e7d-7ad31e6c1d48@redhat.com>
Date: Thu, 24 Jan 2019 12:41:21 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1901241039400.4050@linux.fjfi.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Emulation of TCG OPAL self-encrypting drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Kozub <zub@linux.fjfi.cvut.cz>
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org



On 1/24/19 5:24 AM, David Kozub wrote:
>>
> 
> libata seems to support SCSI / ATA Translation, including ATA PASS
> THROUGH (12) and ATA PASS THROUGH (16). Is this not sufficient? (The
> implementation can be seen in ata_scsi_pass_thru.)
> 

Oh, I missed this! Thanks for pointing it out. I'll take a look and see
if I can recommend where to start making incisions in QEMU.

>> ...but you could create an emulated SCSI disk and then pass those SCSI
>> commands to an ATA device -- achieving a *kind* of pass through, but I
>> don't know if that's helpful to your project. If so, I'd start looking
>> at the scsi disk sources instead of the ATA sources.
> 
> Perhaps. Or maybe fogetting about pass-through and really just
> implementing OPAL in QEMU.
