Received: from eggs.gnu.org ([2001:4830:134:3::10]:53200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gPWiJ-0008D0-GT
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gPWiF-0007G3-Fy
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:54:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gPWiF-0007EE-6e
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:54:55 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wALHmTPx077793
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 12:54:53 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwac3cs66-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 12:54:52 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Wed, 21 Nov 2018 17:54:52 -0000
References: <154281759644.30611.1427168393485755267@c26723477dc9>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Wed, 21 Nov 2018 12:54:36 -0500
MIME-Version: 1.0
In-Reply-To: <154281759644.30611.1427168393485755267@c26723477dc9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <9ace8b36-96cc-380d-4da9-f09825821624@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] tpm: check localities index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, ppandit@redhat.com
Cc: famz@redhat.com, pjp@fedoraproject.org, stefanb@linux.vnet.ibm.com, marcandre.lureau@gmail.com, PSIRT@huawei.com


> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> **
> ERROR:/tmp/qemu-test/src/tests/tpm-tis-test.c:98:tpm_tis_test_check_access_reg: assertion failed (access == TPM_TIS_ACCESS_TPM_REG_VALID_STS | TPM_TIS_ACCESS_TPM_ESTABLISHMENT): (161 == 129)
> GTester: last random seed: R02S756cd80266ded46f6af905a1750384df
> **
> ERROR:/tmp/qemu-test/src/tests/tpm-tis-test.c:252:tpm_tis_test_check_access_reg_seize: assertion failed (access == TPM_TIS_ACCESS_TPM_REG_VALID_STS | pending_request_flag | TPM_TIS_ACCESS_TPM_ESTABLISHMENT): (161 == 129)
> GTester: last random seed: R02S8673a1debdc76d0b989bf42fc8df1f9d
> **
> ERROR:/tmp/qemu-test/src/tests/tpm-tis-test.c:347:tpm_tis_test_check_access_reg_release: assertion failed (access == TPM_TIS_ACCESS_TPM_REG_VALID_STS | pending_request_flag | TPM_TIS_ACCESS_TPM_ESTABLISHMENT): (161 == 129)

Likely related to not being able to relinquish locality due to that one 
call not going through.
