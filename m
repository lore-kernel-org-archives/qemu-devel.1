Received: from eggs.gnu.org ([2001:4830:134:3::10]:53455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cRy0N-0005mY-UG
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cRy0J-00025N-SE
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:18:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59375
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cRy0J-00025F-KW
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:18:35 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0D9DWv3087500
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 04:18:34 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27xqsdgkad-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 04:18:34 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 13 Jan 2017 02:18:34 -0700
References: <20170111021820.24416-1-rth@twiddle.net>
	<20170111021820.24416-11-rth@twiddle.net>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 13 Jan 2017 10:18:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170111021820.24416-11-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <e426028a-0763-e9bb-1508-a3dfd26395e9@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 10/65] tcg/s390: Expose host facilities to
 tcg-target.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 01/11/2017 03:17 AM, Richard Henderson wrote:
> This lets us expose facilities to TCG_TARGET_HAS_* defines
> directly, rather than hiding behind function calls.
>=20
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/s390/tcg-target.h     | 126 ++++++++++++++++++++++++--------------=
--------
>  tcg/s390/tcg-target.inc.c |  74 +++++++++++----------------
>  2 files changed, 96 insertions(+), 104 deletions(-)

This broke compilation.Seems that you forgot one replacement:

In file included from /home/cborntra/REPOS/qemu/tcg/tcg.c:253:0:
/home/cborntra/REPOS/qemu/tcg/s390/tcg-target.inc.c: In function =91tgen_=
cmp=92:
/home/cborntra/REPOS/qemu/tcg/s390/tcg-target.inc.c:1096:19: error: =91fa=
cilities=92 undeclared (first use in this function)
             if (!(facilities & FACILITY_EXT_IMM)) {
                   ^~~~~~~~~~
/home/cborntra/REPOS/qemu/tcg/s390/tcg-target.inc.c:1096:19: note: each u=
ndeclared identifier is reported only once for each function it appears i=
n
/home/cborntra/REPOS/qemu/rules.mak:64: recipe for target 'tcg/tcg.o' fai=
led
make[1]: *** [tcg/tcg.o] Error 1
Makefile:203: recipe for target 'subdir-s390x-softmmu' failed
make: *** [subdir-s390x-softmmu] Error 2
make: Leaving directory '/home/cborntra/REPOS/qemu/build'
