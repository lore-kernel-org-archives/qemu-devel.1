Received: from eggs.gnu.org ([2001:4830:134:3::10]:49714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fik2a-0004ds-0o
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fik2V-00047z-RD
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:27:04 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fik2V-00046n-D8
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:26:59 -0400
Received: by mail-oi0-x242.google.com with SMTP id v8-v6so4356158oie.5
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 10:26:59 -0700 (PDT)
References: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b707ccc3-47bb-569f-3df0-aeb91e90b820@linaro.org>
Date: Thu, 26 Jul 2018 10:26:53 -0700
MIME-Version: 1.0
In-Reply-To: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: ppc64: don't use volatile
 register during safe_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, dgibson@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu
Cc: qemu-devel@nongnu.org

On 07/25/2018 11:48 PM, Shivaprasad G Bhat wrote:
> Reference:
> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG

This document is for _CALL_ELF < 2.  For ppc64le, the document is at

https://openpowerfoundation.org/wp-content/uploads/2016/03/ABI64BitOpenPOWERv1.1_16July2015_pub4.pdf

In both cases, it appears that we can (ab)use SP+16 to save
the value of r14 across the syscall.  This slot would normally
be used for saving our own return address (LR), but we have no
need to save that value because it *is* preserved across the syscall.


r~
