Received: from eggs.gnu.org ([2001:4830:134:3::10]:33622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chF4c-0007vj-MC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chF4Z-0006JY-JB
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:34:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1chF4Z-0006Ic-DQ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:34:07 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95BD081226
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:34:07 +0000 (UTC)
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<20170222183919.11928-3-ehabkost@redhat.com>
	<f3922aa6-75de-b0ca-6e56-150c166c297b@redhat.com>
	<20170224123228.GR2778@thinpad.lan.raisama.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <43b06807-de38-064b-f55a-15bd1c5b0333@redhat.com>
Date: Fri, 24 Feb 2017 13:34:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170224123228.GR2778@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] i386: Make "max" model not use any
 host CPUID info on TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

Am 24.02.2017 um 13:32 schrieb Eduardo Habkost:
> On Fri, Feb 24, 2017 at 12:09:32PM +0100, David Hildenbrand wrote:
>> Am 22.02.2017 um 19:39 schrieb Eduardo Habkost:
>>> Instead of reporting host CPUID data on "max", use the qemu64 CPU
>> Two questions:
>>
>> 1. Shouldn't "max" use cpuid of qemu64 with TARGET_X86_64 and qemu32
>> with !TARGET_X86_64?
> 
> qemu32 has family=6,model=6,stepping=3 too, and the only
> difference on TCG's "max" model on !TARGET_X86_64 will be the
> lack of CPUID_EXT2_SYSCALL and CPUID_EXT2_LM.

So this is already handled then, correct?

> 
>>
>> 2. Should we then change linux-user/main.c:main() to use the "max" model?
> 
> We could, but I would like this to be done by somebody more
> experienced with linux-user code, who could test it properly.
> 

Agreed!


-- 
Thanks,

David
