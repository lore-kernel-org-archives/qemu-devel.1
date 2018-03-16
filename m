Received: from eggs.gnu.org ([2001:4830:134:3::10]:37200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewyji-0000wD-HN
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 19:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewyjd-0005Jh-JL
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 19:26:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35400
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ewyjd-0005J6-Dq
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 19:26:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GNONAN113319
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 19:26:05 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2grhkg49f4-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 19:26:04 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 17:26:04 -0600
References: <152123762242.78.7701555143606874786@71c20359a636>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 19:26:00 -0400
MIME-Version: 1.0
In-Reply-To: <152123762242.78.7701555143606874786@71c20359a636>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <d9f3fe37-86e7-c35b-e9ed-dc427674d73c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 for 2.13 0/4] tpm: Extend TPM with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, famz@redhat.com, dgilbert@redhat.com

On 03/16/2018 06:00 PM, no-reply@patchew.org wrote:
> Hi,
>
> This series failed docker-quick@centos6 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
>
> Type: series
> Message-id: 1521236796-24551-1-git-send-email-stefanb@linux.vnet.ibm.com
> Subject: [Qemu-devel] [PATCH v5 for 2.13 0/4] tpm: Extend TPM with state migration support
>
>
> make: *** No rule to make target `tests/tpm-util.o', needed by `tests/tpm-crb-swtpm-test'.  Stop.
> make: *** Waiting for unfinished jobs....
>    CC      tests/tpm-emu.o
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:21:22: error: tpm-util.h: No such file or directory
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c: In function 'tpm_crb_swtpm_test':
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:127: warning: implicit declaration of function 'tpm_util_swtpm_start'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:127: warning: nested extern declaration of 'tpm_util_swtpm_start'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:140: warning: implicit declaration of function 'tpm_util_startup'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:140: warning: nested extern declaration of 'tpm_util_startup'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:140: error: 'tpm_util_crb_transfer' undeclared (first use in this function)
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:140: error: (Each undeclared identifier is reported only once
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:140: error: for each function it appears in.)
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:141: warning: implicit declaration of function 'tpm_util_pcrextend'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:141: warning: nested extern declaration of 'tpm_util_pcrextend'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:148: warning: implicit declaration of function 'tpm_util_pcrread'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:148: warning: nested extern declaration of 'tpm_util_pcrread'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:152: warning: implicit declaration of function 'tpm_util_swtpm_kill'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:152: warning: nested extern declaration of 'tpm_util_swtpm_kill'
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c: In function 'tpm_crb_swtpm_migration_test':
> /tmp/qemu-test/src/tests/tpm-crb-swtpm-test.c:186: error: 'tpm_util_crb_transfer' undeclared (first use in this function)

Missing new files. Thanks for pointing this out. V5.1 fixes it.

     Stefan
