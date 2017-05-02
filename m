Received: from eggs.gnu.org ([2001:4830:134:3::10]:58631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d5aig-0000wS-4c
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d5aic-0003ol-Uo
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:32:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37838
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1d5aic-0003nl-P5
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:32:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42GUl4D036741
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 12:32:05 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6w559vc0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:32:04 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 2 May 2017 10:32:04 -0600
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 2 May 2017 12:32:00 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <25180959-172f-610c-5a68-239e4ba8b1d7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com

On 05/02/2017 12:05 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Tue, May 2, 2017 at 3:53 PM Amarnath Valluri <amarnath.valluri@intel=
.com>
> wrote:
>
>> This change introduces a new TPM backend driver that can communicate w=
ith
>> swtpm(software TPM emulator) using unix domain socket interface.
>>
>> Swtpm uses two unix sockets, one for plain TPM commands and responses,=
 and
>> one
>> for out-of-band control messages.
>>
>>
> Let's not forget to mention the external protocol this backend rely on:
> https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specificatio=
n
>
> The protocol documentation is quite limited.

better documentation is here:

https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.p=
od
