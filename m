Received: from eggs.gnu.org ([209.51.188.92]:55349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gon3q-0001yS-D2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gon3i-0005Xi-U2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:25:34 -0500
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-3-git-send-email-thuth@redhat.com>
	<1dfe0b1f-a59a-db8a-ef1e-81cb24166c24@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c26ebf71-70e5-4162-6039-4d13654c780c@redhat.com>
Date: Wed, 30 Jan 2019 11:25:13 +0100
MIME-Version: 1.0
In-Reply-To: <1dfe0b1f-a59a-db8a-ef1e-81cb24166c24@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/5] ppc: Express dependencies of the
 'prep' and '40p' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 2019-01-30 11:17, Paolo Bonzini wrote:
> On 30/01/19 10:43, Thomas Huth wrote:
>> +    select LSI_SCSI_PCI
> 
> Should NE2000_ISA and LSI_SCSI_PCI be handled the same?  Either rely on
> "default y" for both, or select both (I think I prefer the former).

Yes. IMHO we should use "select XXX" if the machine has a hard
requirement for a device, and "default y" if it can also somehow work
without the device. In this case, I did not look carefully enough, since
it is apparently possible to use the 40p machine also without the LSI
controller when you specify "-nodefaults". So I'll remove this in v2 and
rely on the "default y" instead.

 Thomas
