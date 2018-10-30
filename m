Received: from eggs.gnu.org ([2001:4830:134:3::10]:59286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHSAz-0003kK-Gz
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHSAy-0007ar-Ml
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:27:13 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHSAy-0007Zu-HO
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:27:12 -0400
Received: by mail-ot1-x341.google.com with SMTP id p23so10683974otf.11
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 04:27:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLkm7Y6_XsqoQ=UOsAarqTDKGyBnAYUeZpQOH1dginbiA@mail.gmail.com>
References: <20181029151956.2164336-1-stefanb@linux.ibm.com>
	<CAFEAcA8OOWbfC-ZpL7GuP81WYC6gGk2XC05DhGeXnceUUfv2mA@mail.gmail.com>
	<CAJ+F1CLkm7Y6_XsqoQ=UOsAarqTDKGyBnAYUeZpQOH1dginbiA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 11:26:51 +0000
Message-ID: <CAFEAcA8=8zQiGt90PDkZGiYvn5f-PO7uveXSP6qyVr+PKSfZkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 30 October 2018 at 11:14, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Hi Peter
>
> On Tue, Oct 30, 2018 at 2:45 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
>> Hi; this gives some test failures (all hosts):
>>
>> TEST: tests/tpm-crb-swtpm-test... (pid=3D305)
>>   /i386/tpm/crb-swtpm/test:                                            F=
AIL
>> GTester: last random seed: R02Sf628ca48da88252a6b95465fef3b855f
>>   /i386/tpm/crb-swtpm-migration/test:                                  F=
AIL
>> GTester: last random seed: R02Sf628ca48da88252a6b95465fef3b855f
>> FAIL: tests/tpm-crb-swtpm-test
>> TEST: tests/tpm-crb-test... (pid=3D311)
>>   /i386/tpm-crb/test:                                                  O=
K
>> PASS: tests/tpm-crb-test
>> TEST: tests/tpm-tis-swtpm-test... (pid=3D324)
>>   /i386/tpm/tis-swtpm/test:                                            F=
AIL
>> GTester: last random seed: R02Sca4f303959770d4ca9f8f12b784dba0d
>>   /i386/tpm/tis-swtpm-migration/test:                                  F=
AIL
>> GTester: last random seed: R02Sca4f303959770d4ca9f8f12b784dba0d
>> FAIL: tests/tpm-tis-swtpm-test
>> TEST: tests/tpm-tis-test... (pid=3D331)
>>   /i386/tpm-tis/test_check_localities:                                 O=
K
>>   /i386/tpm-tis/test_check_access_reg:                                 O=
K
>>   /i386/tpm-tis/test_check_access_reg_seize:                           O=
K
>>   /i386/tpm-tis/test_check_access_reg_release:                         O=
K
>>   /i386/tpm-tis/test_check_transmit:                                   O=
K
>> PASS: tests/tpm-tis-test
>>
>
> What version of swtpm & libtpms is installed?

No idea, how do I tell? On my x86 Ubuntu machine which is one of those
which failed there are no packages whose name includes either "swtpm"
or "tpms".

thanks
-- PMM
