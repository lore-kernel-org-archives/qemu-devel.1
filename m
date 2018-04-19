Received: from eggs.gnu.org ([2001:4830:134:3::10]:45120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f95C9-0002Ke-Ld
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f95C4-0004Hd-Q5
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:45:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f95C4-0004H6-LE
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:45:28 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cc95d6cc-97ca-f428-0b53-a0e92b64e6f8@redhat.com>
Date: Thu, 19 Apr 2018 10:45:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 18.04.2018 08:02, Gerd Hoffmann wrote:
> On Wed, Apr 18, 2018 at 12:40:54AM +0200, Laszlo Ersek wrote:
>> Add a schema that describes the different uses and properties of virtual
>> machine firmware.
> 
> Looks good to me overall.
> 
>> +{ 'enum' : 'FirmwareType',
>> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
> 
> openbios missing.

As mentioned somewhere else in this thread, I think it's best to just
use "openfirmware" here instead of "slof" and "openbios"

>> +{ 'enum' : 'FirmwareArchitecture',
>> +  'data' : [ 'aarch64', 'arm', 'i386', 'x86_64' ] }
> 
> ppc(64) missing (but you have slof above ;) ...

Since you distinguish between 32-bit and 64-bit, we need both "ppc"
(32-bit) and "ppc64" (64-bit) here.

> s390 too.

Please name that "s390x". "s390" without x means the old 31-bit
architecture which is hardly used anymore today. "s390x" is the modern
64-bit architecture.

 Thomas
