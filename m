Received: from eggs.gnu.org ([2001:4830:134:3::10]:40123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ciGzB-0004m0-Os
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ciGz8-0008KV-H3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:48:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ciGz8-0008Jq-7k
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:48:46 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1R8hV0l063186
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 03:48:43 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u6wanab3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 03:48:42 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 27 Feb 2017 01:48:41 -0700
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<CAFEAcA8E6L7Ad1+P_YRJo4YMyQn=jGQRS6ybGMKjLS=vEHq0ZA@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 27 Feb 2017 09:48:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8E6L7Ad1+P_YRJo4YMyQn=jGQRS6ybGMKjLS=vEHq0ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8e8e8536-8d01-7c26-ea0d-9d4b8ba5c42e@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/24] MTTCG Base enabling patches with ARM
 enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 02/25/2017 10:14 PM, Peter Maydell wrote:
> On 24 February 2017 at 11:20, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>> The following changes since commit 2d896b454a0e19ec4c1ddbb0e0b65b7e54f=
cedf3:
>>
>>   Revert "hw/mips: MIPS Boston board support" (2017-02-23 18:04:45 +00=
00)
>>
>> are available in the git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-mttcg-240217-1
>>
>> for you to fetch changes up to ca759f9e387db87e1719911f019bc60c74be9ed=
8:
>>
>>   tcg: enable MTTCG by default for ARM on x86 hosts (2017-02-24 10:32:=
46 +0000)
>>
>> ----------------------------------------------------------------
>> This is the MTTCG pull-request as posted yesterday.
>>
>> ----------------------------------------------------------------
>=20
> Applied, thanks.
>=20
> -- PMM
>=20

This seems to trigger=20

/home/cborntra/REPOS/qemu/vl.c: In function =E2=80=98main=E2=80=99:
/home/cborntra/REPOS/qemu/vl.c:3700:18: error: =E2=80=98QEMU_OPTION_accel=
=E2=80=99 undeclared (first use in this function)
             case QEMU_OPTION_accel:
                  ^~~~~~~~~~~~~~~~~
/home/cborntra/REPOS/qemu/vl.c:3700:18: note: each undeclared identifier =
is reported only once for each function it appears in


on s390.

Christian
