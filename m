Received: from eggs.gnu.org ([2001:4830:134:3::10]:45488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e32x4-0004Pw-JR
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e32x0-0005LY-MP
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:36:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e32x0-0005LM-GX
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:36:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9DGYEhk044131
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 12:36:38 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2djwejjthu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 12:36:38 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 13 Oct 2017 10:36:37 -0600
References: <1507751249-3035-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CK7MW5kY5eaiHGyk7hvxKyOBNJi7MHo9warfXbSp4LzPA@mail.gmail.com>
	<CAFEAcA_V-ZS+O_BsEU6OJuT_hE-RXw0dTaJbZgY-BW8soRv3vA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 12:36:33 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_V-ZS+O_BsEU6OJuT_hE-RXw0dTaJbZgY-BW8soRv3vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d4676b57-0298-a0b4-a116-3d5cd9a38807@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] tpm: Use EMSGSIZE instead of EBADMSG to
 compile on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, QEMU <qemu-devel@nongnu.org>

On 10/13/2017 12:12 PM, Peter Maydell wrote:
> On 13 October 2017 at 12:14, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>> Hi
>>
>> On Wed, Oct 11, 2017 at 9:47 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>> EBADMSG was only added to OpenBSD very recently. To make QEMU compila=
ble
>>> on older OpenBSD versions use EMSGSIZE instead when a mismatch betwee=
n
>>> number of received bytes and message size indicated in the header was
>>> found.
>>>
>>> Return -EMSGSIZE and convert all other errnos in the same functions t=
o
>>> return the negative errno.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>>
>> Looks good to me,
>> but given that the return value isn't used, perhaps you could have
>> changed the function to return a bool success instead?
> AIUI this is just test code, so we probably don't gain too much
> from extensively bikeshedding it. (Having said that, I can't
> resist asking why it's not in tests/ :-))

This is NOT test code. It's determining whether the external TPM is a=20
TPM 1.2 or TPM 2 emulation. This avoids having to start QEMU with a=20
'--tpm2' parmeter equivalent as well as the external emulator. Passing=20
this to the external emulator is enough.

    Stefan


>
> thanks
> -- PMM
>
