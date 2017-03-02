Received: from eggs.gnu.org ([2001:4830:134:3::10]:46631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTEF-0003ej-Mj
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTED-0005nN-Up
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:05:19 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjTED-0005mO-OT
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:05:17 -0500
Received: by mail-wr0-x22f.google.com with SMTP id u48so55760808wrc.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 08:05:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DM5PR03MB28272ACE93520F5462B9EAB19E560@DM5PR03MB2827.namprd03.prod.outlook.com>
References: <20170228215801.10472-1-Andrew.Baumann@microsoft.com>
	<148832000677.258.3665878022537430417@0e2666bad730>
	<DM5PR03MB28272ACE93520F5462B9EAB19E560@DM5PR03MB2827.namprd03.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 16:04:55 +0000
Message-ID: <CAFEAcA91A+RcpBts7dR-puzT6LTpY-GQ_5q=agDe+P6vkmX=0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] misc aarch64 fixes for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "famz@redhat.com" <famz@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On 28 February 2017 at 22:22, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
>> From: no-reply@patchew.org [mailto:no-reply@patchew.org]
>> Sent: Tuesday, 28 February 2017 14:13
>>
>> Hi,
>>
>> This series failed build test on s390x host. Please find the details bel=
ow.
> [..]
>> /var/tmp/patchew-tester-tmp-64adnjjr/src/target/arm/helper.c:931:23:
>> error: =E2=80=98pmreg_access_ccntr=E2=80=99 defined but not used [-Werro=
r=3Dunused-
>> function]
>>  static CPAccessResult pmreg_access_ccntr(CPUARMState *env,
>>                        ^~~~~~~~~~~~~~~~~~
>> /var/tmp/patchew-tester-tmp-64adnjjr/src/target/arm/helper.c:917:23:
>> error: =E2=80=98pmreg_access_selr=E2=80=99 defined but not used [-Werror=
=3Dunused-function]
>>  static CPAccessResult pmreg_access_selr(CPUARMState *env,
>>                        ^~~~~~~~~~~~~~~~~
>
> Oops, these need to be protected with #ifndef CONFIG_USER_ONLY... will be=
 fixed in v2, but I'll wait for any other feedback.

I fixed up this nit applying the patch to target-arm.next.

thanks
-- PMM
