Received: from eggs.gnu.org ([2001:4830:134:3::10]:46242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1emJhJ-00054p-44
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1emJhF-0004pe-0z
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:35:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55314
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1emJhE-0004pW-Qc
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:35:32 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FDYKJF034236
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 08:35:31 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5atn9446-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 08:35:31 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 06:35:30 -0700
References: <1518657666-3997-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CKSzx6a-V+3Tco90+qBs4i_NjAsxsL68AihaEaxhpS0Dw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 08:35:28 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKSzx6a-V+3Tco90+qBs4i_NjAsxsL68AihaEaxhpS0Dw@mail.gmail.com>
Message-Id: <d77d6eb7-5d03-b953-9ae7-e009df975912@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: add test for TPM TIS device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On 02/15/2018 07:35 AM, Marc-Andr=C3=A9 Lureau wrote:
>> +#define DPRINTF_STS \
>> >+    DPRINTF("%s: %d: sts =3D 0x%08x\n", __func__, __LINE__, sts)
>> >+
>> >+typedef struct TestState {
>> >+    CompatGMutex data_mutex;
>> >+    CompatGCond data_cond;
>> >+    SocketAddress *addr;
>> >+    QIOChannel *tpm_ioc;
>> >+    GThread *emu_tpm_thread;
>> >+    struct tpm_hdr *tpm_msg;
>> >+} TestState;
> We could avoid code duplication. What about adding a tests/tpm-emu.c/h =
?
>
ok, let me give that a try.
