Received: from eggs.gnu.org ([2001:4830:134:3::10]:40053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e4UiK-0004PP-3o
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e4UiJ-0001Uq-DZ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:27:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38542
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e4UiJ-0001UI-8g
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:27:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9HGOfiO062561
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 12:27:26 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dnkudna4h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 12:27:25 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 17 Oct 2017 12:27:25 -0400
References: <1508247148-25240-1-git-send-email-thuth@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 14:27:17 -0200
MIME-Version: 1.0
In-Reply-To: <1508247148-25240-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <19010e69-6abe-0888-24a9-903ca4017355@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] Improve the CPU hot plug
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, david@redhat.com, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>



On 10/17/2017 11:32 AM, Thomas Huth wrote:
> So far the CPU hot-plug qtest was only checking "cpu-add" on x86. With
> these patches, we now test "device_add" for hot-plugging CPUs on x86,
> and enable the test on ppc64 and s390x, too.

Question: is there a reason other than "no one bothered" to not have a 
CPU hot
unplug test, something around the lines of the now cpu-plug-test.c? I might
give it a shot if there is no known roadblocks against it.


Thanks,

Daniel

>
> Thomas Huth (4):
>    tests: Rename pc-cpu-test.c to cpu-plug-test.c
>    tests/cpu-plug-test: Check the CPU hot-plugging with device_add, too
>    tests/cpu-plug-test: Check CPU hot-plugging on ppc64, too
>    tests/cpu-plug-test: Test CPU hot-plugging on s390x
>
>   tests/Makefile.include |   6 +-
>   tests/cpu-plug-test.c  | 261 +++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/pc-cpu-test.c    | 135 -------------------------
>   3 files changed, 265 insertions(+), 137 deletions(-)
>   create mode 100644 tests/cpu-plug-test.c
>   delete mode 100644 tests/pc-cpu-test.c
>
