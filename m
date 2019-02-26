Received: from eggs.gnu.org ([209.51.188.92]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gycpB-0002MG-6u
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gycp9-0005Qo-7H
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:31:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gycp7-0005E2-GM
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:31:05 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-18-git-send-email-pbonzini@redhat.com>
	<20190225084428.c7qon3btox2jvxq2@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30737edd-4b8c-a458-27c6-cd3fb5da22c3@redhat.com>
Date: Tue, 26 Feb 2019 14:23:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190225084428.c7qon3btox2jvxq2@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/51] i386: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Yang Zhong <yang.zhong@intel.com>, thuth@redhat.com, philmd@redhat.com

On 25/02/19 09:44, Stefano Garzarella wrote:
>>  config I440FX
>>      bool
>> +    select PC_PCI
>> +    select PC_ACPI
>> +    select ACPI_SMBUS
>> +    select PCI_PIIX
>> +    select FDC
> Should we move "select FDC" under "config PC"?
> 
> I'm not able to build the Q35 machine without enable FDC, since some fdc
> functions are used in hw/i386/pc.c (eg. isa_fdc_get_drive_type())

Yes, that's a good idea.  I mistakenly thought that Q35 could be built
without FDC.

Paolo
