Received: from eggs.gnu.org ([2001:4830:134:3::10]:52377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAuAP-0002jw-Rd
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAuAK-0004i4-RP
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAuAK-0004hq-LZ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:18:40 -0400
References: <4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
	<ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
	<f9c33614-be36-e789-b72b-b4ffcc8bb6a8@redhat.com>
	<20170512193840.GA22454@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB6CBF@ORSMSX112.amr.corp.intel.com>
	<20170513000141.GA542@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB6DEF@ORSMSX112.amr.corp.intel.com>
	<20170516162442.GA4177@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB8B3D@ORSMSX112.amr.corp.intel.com>
	<20170516214211.GA21896@morn.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <078ed476-45c8-6320-75ca-dad2a4008f3b@redhat.com>
Date: Wed, 17 May 2017 10:18:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170516214211.GA21896@morn.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>, "Xu, Anthony" <anthony.xu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 16/05/2017 23:42, Kevin O'Connor wrote:
> 
> As for adding a new SeaBIOS build option to compile out support for
> A20 - that seems like a very small optimization that would risk memory
> corruption and hard to diagnose crashes.  SeaBIOS runs natively on
> real hardware (with coreboot and as a CSM on UEFI) as well as on
> QEMU/KVM.

Haswell (2013) no longer has A20 support (and hypervisors never had it,
not just KVM).

Thanks,

Paolo
