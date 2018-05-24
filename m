Received: from eggs.gnu.org ([2001:4830:134:3::10]:60159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fLsrl-0006sk-1s
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fLsrf-0002p0-Vo
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:13:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fLsrf-0002nr-Nd
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:13:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4OG9Zxl070381
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 12:13:18 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j5yq5bd42-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 12:13:18 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 24 May 2018 12:13:16 -0400
References: <20180524005741.1042749-1-stefanb@linux.vnet.ibm.com>
	<CAFEAcA9c6w0GQQYr3GQqzOuea+n5y3muuPy4dE7WZy-UPQM7sA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 24 May 2018 12:13:12 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9c6w0GQQYr3GQqzOuea+n5y3muuPy4dE7WZy-UPQM7sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <060c1af0-7300-5369-20fa-4690c1267fa9@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 0/4] Merge tpm 2018/05/23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 05/24/2018 11:04 AM, Peter Maydell wrote:
> On 24 May 2018 at 01:57, Stefan Berger <stefanb@linux.vnet.ibm.com> wro=
te:
>> This series of patches adds TPM emulator state migration support and a
>> test case for testing (local) migration.
>>
>>     Stefan
>>
>> The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79c=
d466d:
>>
>>    Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-r=
equest' into staging (2018-05-22 09:43:58 +0100)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-05-23=
-1
>>
>> for you to fetch changes up to 319bb20d1e88ea2e13baeb158a4989eceeee5e8=
6:
>>
>>    test: Add test cases that use the external swtpm with CRB interface=
 (2018-05-23 20:35:25 -0400)
>>
>> ----------------------------------------------------------------
>> Merge tpm 2018/05/23 v1
>>
>> ----------------------------------------------------------------
>> Stefan Berger (4):
>>        tpm: extend TPM emulator with state migration support
>>        tpm: extend TPM TIS with state migration support
>>        docs: tpm: add VM save/restore example and troubleshooting guid=
e
>>        test: Add test cases that use the external swtpm with CRB inter=
face
>>
> Hi. I'm afraid this fails to build on OpenBSD:
>
>    CC      hw/tpm/tpm_emulator.o
> /home/qemu/hw/tpm/tpm_emulator.c: In function 'tpm_emulator_set_state_b=
lobs':
> /home/qemu/hw/tpm/tpm_emulator.c:794:17: error: 'EBADMSG' undeclared
> (first use in this function)
>           return -EBADMSG;

Ok. Fixing to -EIO, which is also good.

 =C2=A0=C2=A0 Stefan
