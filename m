Received: from eggs.gnu.org ([2001:4830:134:3::10]:36912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eJKt4-0002vE-DX
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eJKsz-0005k4-G7
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:59:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eJKsz-0005ii-6n
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:59:53 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAREwk0q038704
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 09:59:49 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eghxca3fu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 09:59:48 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 09:59:47 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 09:59:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <d1bb0f60-1c09-8189-a5d1-0b762b3ceecb@linux.vnet.ibm.com>
Subject: [Qemu-devel] tpm: swtpm and libtpms projects tagged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, tpm2@lists.01.org
Cc: Patrick Ohly <patrick.ohly@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, amarnath.valluri@intel.com

Hello!

I tagged libtpms with TPM 1.2 and TPM 2 support with tag/v0.6.0-dev1 and 
swtpm with TPM 1.2 and TPM 2 support with tag/v0.1.0-dev2. The git repos 
of the respective projects are here:

libtpms: https://github.com/stefanberger/libtpms

swtpm: https://github.com/stefanberger/swtpm


Note: Recent modifications to libtpms will produce a state file 
(tpm2-00.permall) of 64kb. Previous state files will not work anymore, 
so you may have to remove them.

Compilation instructions can be found on the git hub Wiki pages of these 
projects.

Regards,
     Stefan
