Received: from eggs.gnu.org ([2001:4830:134:3::10]:54698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dD39j-000102-R9
	for qemu-devel@nongnu.org; Tue, 23 May 2017 02:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dD39f-0007hO-T3
	for qemu-devel@nongnu.org; Tue, 23 May 2017 02:18:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50393
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dD39f-0007gk-NQ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 02:18:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4N68d9S079751
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 02:18:50 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2amf9a8yfe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 02:18:49 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 23 May 2017 16:18:46 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4N6IYCc7340342
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 16:18:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4N6I12r022476
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 16:18:03 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <BBC4E515-FE7D-4600-A5CA-BBCE26059415@gmail.com>
References: <mailman.73115.1495441935.22737.qemu-devel@nongnu.org>
	<BBC4E515-FE7D-4600-A5CA-BBCE26059415@gmail.com>
Date: Tue, 23 May 2017 11:47:30 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efvghzb9.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH risu] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Sandipan Das <sandipandas1990@gmail.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

G 3 <programmingkidx@gmail.com> writes:

> On May 22, 2017, at 4:32 AM, qemu-devel-request@nongnu.org wrote:
>
> Hello I have also done some work risu. My patches add ppc32 support.  
> Well my patches were made to work with Mac OS X but they are required  
> to work with Linux. Do you think you could help port these patches to  
> Linux?

Ziviani did the ppc64 work, lets see if he can spare some time.

The patches haven't come right on the mailing list, its tedious to pull
them. Please resend them with git send-mail.

>
> ppc.risu:
> https://patchwork.kernel.org/patch/9697489/
>
> risu_ppc.c:
> https://patchwork.kernel.org/patch/9697491/
>
> risu_reginfo_ppc.c:
> https://patchwork.kernel.org/patch/9697493/
>
> risu_reginfo_ppc.h:
> https://patchwork.kernel.org/patch/9697495/
>
> risugen_ppc.pm:
> https://patchwork.kernel.org/patch/9697497/
>
> Add ppc support to configure:
> https://patchwork.kernel.org/patch/9697499/
>
> Add verbose option:
> https://patchwork.kernel.org/patch/9697501/
>
> Add end of test message:
> https://patchwork.kernel.org/patch/9697503/
>
> Add more descriptive comment for mismatch or end of test condition:
> https://patchwork.kernel.org/patch/9697505/

Regards
Nikunj
