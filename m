Received: from eggs.gnu.org ([2001:4830:134:3::10]:44420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.ibm.com>) id 1fEDCQ-00047n-8G
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.ibm.com>) id 1fEDCM-0002Kv-6G
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:19:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50114
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.ibm.com>)
	id 1fEDCL-0002KR-Vx
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:18:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w43C8UC8087120
	for <qemu-devel@nongnu.org>; Thu, 3 May 2018 08:18:55 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hr01r68qq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 08:18:54 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.ibm.com>;
	Thu, 3 May 2018 08:18:54 -0400
Date: Thu, 3 May 2018 09:18:47 -0300
From: joserz@linux.ibm.com
Reply-To: CAC7XEcLTBGZ815iMa_Uwz7+FiTm_8dVAT+banx4hcEbY=ui8uQ@mail.gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <20180503121847.GA28013@pacoca>
Subject: Re: [Qemu-devel] [PATCH] Allow PIR read in privileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: leandro.lupori@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, Richard Henderson <richard.henderson@linaro.org>

> According to PowerISA, the PIR register should be readable in privileged mode also, not only in hypervisor privileged mode.

The code makes sense but it doesn't seem created by git format-patch. If
so, could you please follow the instructions from
https://wiki.qemu.org/Contribute/SubmitAPatch and resend it? (note you
need to cc the maintainers)

In the next version you can include my review.

Reviewed-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>

Thanks
