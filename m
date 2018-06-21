Received: from eggs.gnu.org ([2001:4830:134:3::10]:36762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVxfV-00078e-Ie
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVxfR-0005aj-Jo
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:22:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVxfR-0005af-Do
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:22:21 -0400
References: <20180620110741.gdywesuqbyhjs4hd@sirius.home.kraxel.org>
	<ce257b1b-4d04-9e76-2ded-730b2a410f91@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee3462a2-bad7-3b2f-e218-356529163663@redhat.com>
Date: Thu, 21 Jun 2018 13:22:18 +0200
MIME-Version: 1.0
In-Reply-To: <ce257b1b-4d04-9e76-2ded-730b2a410f91@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] regression: sata cdrom boot broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, f4bug@amsat.org

On 20/06/2018 20:15, Thomas Huth wrote:
> On 20.06.2018 13:07, Gerd Hoffmann wrote:
>>   Hi,
>>
>> $subject says all.  Noticed while testing the upcoming seabios update.
>> Reproducer:
>>
>>   qemu-system-x86_64 -M q35 -m 4G -cdrom Fedora-Workstation-Live-x86_64-28-1.1.iso
> 
> Once this has been fixed, please add a regression test to tests/cdrom-test.c
> for this, so that it can not happen so easily again. A line like this
> should do the job:
> 
>  qtest_add_data_func("cdrom/boot/q35", "-M q35 -cdrom ", test_cdboot);

Nice!  The patch I've sent fixes tests/ahci-test.c to match what the
code now does, but cdrom-test.c is also good.

Thanks,

Paolo
