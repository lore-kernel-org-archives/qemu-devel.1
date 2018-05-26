Received: from eggs.gnu.org ([2001:4830:134:3::10]:36312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fMPDa-0005ID-62
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fMPDX-0006E8-3s
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:46:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fMPDW-0006Dq-RJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:46:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4Q2iPCk005731
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:45:59 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j6sx594ah-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:45:59 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 25 May 2018 20:45:59 -0600
References: <20180524164857.3014670-1-stefanb@linux.vnet.ibm.com>
	<CAFEAcA_ZkFNJTjWsi3ssB_VwJ9kDcK72UuFx6RB3riVcx+QsiQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 22:45:54 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ZkFNJTjWsi3ssB_VwJ9kDcK72UuFx6RB3riVcx+QsiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <9ed35ab1-1c96-e0bc-0a48-fb95179c324d@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 0/4] Merge tpm 2018/05/23
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

On 05/25/2018 05:03 AM, Peter Maydell wrote:
> On 24 May 2018 at 17:48, Stefan Berger <stefanb@linux.vnet.ibm.com> wro=
te:
>> This series of patches adds TPM emulator state migration support and a
>> test case for testing (local) migration.
>>
>>     Stefan
>>
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
-3
>>
>> for you to fetch changes up to 37fa382f327405b6516e9983c1aa1ca32c72689=
2:
>>
>>    test: Add test cases that use the external swtpm with CRB interface=
 (2018-05-24 12:07:04 -0400)
>>
>> ----------------------------------------------------------------
>> Merge tpm 2018/05/23 v3
>>
>> ----------------------------------------------------------------
>> Stefan Berger (4):
>>        tpm: extend TPM emulator with state migration support
>>        tpm: extend TPM TIS with state migration support
>>        docs: tpm: add VM save/restore example and troubleshooting guid=
e
>>        test: Add test cases that use the external swtpm with CRB inter=
face
> I still see compile failures on OpenBSD, I'm afraid:
>
> In file included from /home/qemu/include/qemu/osdep.h:68:0,
>                   from /home/qemu/tests/tpm-util.c:15:
> /home/qemu/tests/tpm-util.c: In function 'tpm_util_swtpm_has_tpm2':
> /home/qemu/tests/tpm-util.c:101:10: error: expected identifier or '('
> before '&' token
>       gint stdout;
>            ^
> /home/qemu/tests/tpm-util.c:112:43: error: lvalue required as unary '&'=
 operand
>                                       NULL, &stdout, NULL, NULL);
>                                             ^
> /home/qemu/tests/tpm-util.c:117:14: warning: passing argument 1 of
> 'read' makes integer from pointer without a cast
>       n =3D read(stdout, buffer, sizeof(buffer) - 1);
>                ^
> In file included from /home/qemu/include/qemu/osdep.h:75:0,
>                   from /home/qemu/tests/tpm-util.c:15:
> /usr/include/unistd.h:372:10: note: expected 'int' but argument is of
> type 'struct FILE *'
>   ssize_t  read(int, void *, size_t)
>            ^
> gmake: *** [/home/qemu/rules.mak:66: tests/tpm-util.o] Error 1
> gmake: Leaving directory '/home/qemu/build/all'
>
>
> "stdout" is a FILE* global provided by the system headers -- you can't
> reuse it for a local variable name.

Renamed it to mystdout.

 =C2=A0=C2=A0 Stefan


>
> thanks
> -- PMM
>
