Received: from eggs.gnu.org ([2001:4830:134:3::10]:51721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fOECO-0008Hy-H2
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fOECJ-0007t7-Jh
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:24:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fOECJ-0007sb-AD
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:24:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4V3J9Bq096886
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 23:24:18 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ja5gg6u7y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 23:24:18 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Wed, 30 May 2018 21:24:17 -0600
References: <20180529073140.7392-1-zyimin@linux.ibm.com>
	<c414c2a0-8591-3892-59d1-58c894f984fd@redhat.com>
	<80481571-a84c-0c62-43c6-69b87117f19a@linux.ibm.com>
	<20180530105407.GB19798@vader>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Thu, 31 May 2018 11:24:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180530105407.GB19798@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ebf94079-6f74-7e26-3aa4-f70dab74728b@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, fiuczy@linux.ibm.com, jtomko@redhat.com, jferlan@redhat.com



=E5=9C=A8 2018/5/30 =E4=B8=8B=E5=8D=886:54, Eduardo Otubo =E5=86=99=E9=81=
=93:
> Can you send a v4 with a cleaned up version? Also fixing a typo on the =
text
> (elevateDprivileges).
Why elevateDprivileges? The option name in the code is 'elevateprivileges=
'.
