Received: from eggs.gnu.org ([2001:4830:134:3::10]:37931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gHTT0-0000s6-BW
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gHTSw-0000px-RK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:49:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40436
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gHTSw-0000ow-Iu
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:49:50 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9UCnFH1017169
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 08:49:49 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nenb26ddd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 08:49:49 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 30 Oct 2018 08:49:48 -0400
References: <20181029151956.2164336-1-stefanb@linux.ibm.com>
	<CAFEAcA8OOWbfC-ZpL7GuP81WYC6gGk2XC05DhGeXnceUUfv2mA@mail.gmail.com>
	<CAJ+F1CLkm7Y6_XsqoQ=UOsAarqTDKGyBnAYUeZpQOH1dginbiA@mail.gmail.com>
	<CAFEAcA8=8zQiGt90PDkZGiYvn5f-PO7uveXSP6qyVr+PKSfZkw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 30 Oct 2018 08:49:45 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8=8zQiGt90PDkZGiYvn5f-PO7uveXSP6qyVr+PKSfZkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <50cb13d4-0c8f-d90f-3960-afae8d944788@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge tpm 2018/10/29 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 10/30/18 7:26 AM, Peter Maydell wrote:
> On 30 October 2018 at 11:14, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>> Hi Peter
>>
>> On Tue, Oct 30, 2018 at 2:45 PM Peter Maydell <peter.maydell@linaro.or=
g> wrote:
>>> Hi; this gives some test failures (all hosts):
>>>
>>> TEST: tests/tpm-crb-swtpm-test... (pid=3D305)
>>>    /i386/tpm/crb-swtpm/test:                                         =
   FAIL
>>> GTester: last random seed: R02Sf628ca48da88252a6b95465fef3b855f
>>>    /i386/tpm/crb-swtpm-migration/test:                               =
   FAIL
>>> GTester: last random seed: R02Sf628ca48da88252a6b95465fef3b855f
>>> FAIL: tests/tpm-crb-swtpm-test
>>> TEST: tests/tpm-crb-test... (pid=3D311)
>>>    /i386/tpm-crb/test:                                               =
   OK
>>> PASS: tests/tpm-crb-test
>>> TEST: tests/tpm-tis-swtpm-test... (pid=3D324)
>>>    /i386/tpm/tis-swtpm/test:                                         =
   FAIL
>>> GTester: last random seed: R02Sca4f303959770d4ca9f8f12b784dba0d
>>>    /i386/tpm/tis-swtpm-migration/test:                               =
   FAIL
>>> GTester: last random seed: R02Sca4f303959770d4ca9f8f12b784dba0d
>>> FAIL: tests/tpm-tis-swtpm-test
>>> TEST: tests/tpm-tis-test... (pid=3D331)
>>>    /i386/tpm-tis/test_check_localities:                              =
   OK
>>>    /i386/tpm-tis/test_check_access_reg:                              =
   OK
>>>    /i386/tpm-tis/test_check_access_reg_seize:                        =
   OK
>>>    /i386/tpm-tis/test_check_access_reg_release:                      =
   OK
>>>    /i386/tpm-tis/test_check_transmit:                                =
   OK
>>> PASS: tests/tpm-tis-test
>>>
>> What version of swtpm & libtpms is installed?
> No idea, how do I tell? On my x86 Ubuntu machine which is one of those
> which failed there are no packages whose name includes either "swtpm"
> or "tpms".

Probably it's failing without it being installed. I had also tried=20
running it on my machine without swtpm being installed and it didn't fail.


>
> thanks
> -- PMM
>
