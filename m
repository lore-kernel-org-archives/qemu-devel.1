Received: from eggs.gnu.org ([2001:4830:134:3::10]:50322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1ea7SX-00076j-Sh
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 17:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1ea7SU-0000sT-OM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 17:05:57 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:33042
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1ea7SU-0000pP-Gi
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 17:05:54 -0500
From: Stefan Weil <sw@weilnetz.de>
References: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
	<129c0f17-ada9-92ce-eb0d-1596da397638@weilnetz.de>
Message-ID: <bedf8b0d-e6fd-103a-5e6f-4b25464a1368@weilnetz.de>
Date: Fri, 12 Jan 2018 23:05:47 +0100
MIME-Version: 1.0
In-Reply-To: <129c0f17-ada9-92ce-eb0d-1596da397638@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] Implements the Windows Hypervisor
 Platform accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, ehabkost@redhat.com, rth@twiddle.net

Am 12.01.2018 um 22:57 schrieb Stefan Weil:
>> Over the next few days the pre-release version of the documentation for this new
>> API will be visible at https://docs.microsoft.com/en-us/virtualization under
>> the 'Windows Hypervisor Platform' section. Here you will see the requirements,
>> API, and examples.

Please inform the qemu-devel list when the required files for building
are available.

For now, building fails:

$ ../configure --enable-whpx

ERROR: User requested feature winhvplatform
       configure was not able to find it.
       winhvemulation is not installed

Enhancing the build instructions for QEMU would also be a good idea then.

Thanks,
Stefan
