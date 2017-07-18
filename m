Received: from eggs.gnu.org ([2001:4830:134:3::10]:33335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dXSkP-0008E4-LY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dXSkK-000764-NH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dXSkK-00075O-Cq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6IDe5xA070651
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 09:41:01 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsbxb6qq8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 09:41:01 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 07:41:00 -0600
Received: from b03ledav003.gho.boulder.ibm.com
	(b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v6IDev1g65339476
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 06:40:57 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E858E6A054
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:40:57 -0600 (MDT)
Received: from sbct-3.watson.ibm.com (unknown [9.2.141.158])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP id D00AC6A048
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:40:57 -0600 (MDT)
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+MYV+GLpGD0RZJ9gWXchfcbjrbDHQ5OsxuZ6W=chzBEw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 09:40:57 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+MYV+GLpGD0RZJ9gWXchfcbjrbDHQ5OsxuZ6W=chzBEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d3a45e88-3c10-3b45-a0c1-325f59a73f36@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 07/18/2017 08:08 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Tue, Jul 18, 2017 at 1:49 AM, Amarnath Valluri
> <amarnath.valluri@intel.com> wrote:
>> This change introduces a new TPM backend driver that can communicate w=
ith
>> swtpm(software TPM emulator) using unix domain socket interface.
>>
>> Swtpm uses two unix sockets, one for plain TPM commands and responses,=
 and one
>> for out-of-band control messages.
>>
>> The swtpm and associated tools can be found here:
>>      https://github.com/stefanberger/swtpm
>>
>> The swtpm's control channel protocol specification can be found here:
>>      https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specif=
ication
> I am afraid this isn't enough yet.


I'll put a pointer to this here on that page so that content isn't=20
replicated multiple times.

https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.p=
od

    Stefan
