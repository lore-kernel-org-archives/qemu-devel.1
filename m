Received: from eggs.gnu.org ([2001:4830:134:3::10]:40899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSiGg-000316-8N
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSiGc-0004iI-6K
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:19:22 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:45989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSiGb-0004h9-VQ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:19:18 -0400
Received: from player697.ha.ovh.net (unknown [10.109.122.80])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 932811C0370
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 14:19:15 +0200 (CEST)
References: <20180612101135.23852-1-clg@kaod.org>
	<20180612134104.11bd1b62@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <60c95cc0-fb8f-bb46-17c6-cccc9b1c3d67@kaod.org>
Date: Tue, 12 Jun 2018 14:19:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180612134104.11bd1b62@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] xics_kvm: fix a build break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

On 06/12/2018 01:41 PM, Greg Kurz wrote:
> On Tue, 12 Jun 2018 12:11:35 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On CentOS 7.5, gcc-4.8.5-28.el7_5.1.ppc64le fails to build QEMU due to=
 :
>>
>>   hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_state=E2=80=99:
>>   hw/intc/xics_kvm.c:281:13: error: =E2=80=98ret=E2=80=99 may be used =
uninitialized in this
>>     function [-Werror=3Dmaybe-uninitialized]
>>              return ret;
>>
>> Fix the breakage and also remove the extra error reporting as
>> kvm_device_access() already provides a substantial error message.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Greg, can you please test ? RHEL7.5 does not catch the issue with the
>>  same compiler level :/ I don't understand why.
>>
>=20
> This fixes the build breakage for me. Now this should really be squashe=
d
> into your original patch to preserve bisect on master.

After some analysis, you need to configure with '--enable-debug' to repro=
duce=20
the breakage. '--enable-debug' removes -O2.=20

With -O2, the compiler doesn't catch the error. It looks very much like a=
 gcc=20
issue to me.

Thanks,

C.=20
