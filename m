Received: from eggs.gnu.org ([2001:4830:134:3::10]:55186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijot-0006yI-CF
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijoo-000280-Ss
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:08:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dijoo-00027d-M6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:08:18 -0400
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-8-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <65be761f-752a-d63c-8654-d333bfb4bd08@redhat.com>
Date: Fri, 18 Aug 2017 18:08:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170818114353.13455-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 07/18] s390x: drop inclusion of
 sysemu/kvm.h from some files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 18.08.2017 13:43, David Hildenbrand wrote:
> s390-stattrib.c needs definition of TARGET_PAGE_SIZE, solve it via cpu.h.

Why not simply #include "exec/cpu-all.h" ? If cpu.h is not really needed
here...

 Thomas
