Received: from eggs.gnu.org ([2001:4830:134:3::10]:59048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cb7PQ-0004O0-GQ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cb7PN-0002no-Dx
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:10:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cb7PN-0002mv-94
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:10:17 -0500
References: <1485540693-31723-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1485540693-31723-3-git-send-email-imbrenda@linux.vnet.ibm.com>
	<63aaa3cc-6623-374d-8f8f-4e48fbbc21ce@redhat.com>
	<db1dcc0a-61fe-652b-b994-12fb3dc10780@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4d4404a-5966-3ed7-1c51-8ed45d626190@redhat.com>
Date: Tue, 7 Feb 2017 16:10:13 +0100
MIME-Version: 1.0
In-Reply-To: <db1dcc0a-61fe-652b-b994-12fb3dc10780@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 2/2] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, palves@redhat.com, alex.bennee@linaro.org



On 07/02/2017 10:59, Claudio Imbrenda wrote:
> static inline int cpu_index(CPUState *cpu)
> {
> #if defined(CONFIG_USER_ONLY)
>     return cpu->host_tid;
> #else
>     return cpu->cpu_index + 1;
> #endif
> }
> 
> 
> maybe that can just become  newstates[cpu->cpu_index] = 1  ?
> (since we're not in CONFIG_USER_ONLY anyway)

Yes, I think it should be like that, especially if in the future we want
to support CONFIG_USER_ONLY it makes no sense to use host PIDs.

Paolo
