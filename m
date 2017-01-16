Received: from eggs.gnu.org ([2001:4830:134:3::10]:37347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cT2eM-0004DC-Qj
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cT2eH-0004wE-Lh
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:28:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54629
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cT2eH-0004up-H4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:28:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0G8NUDo110941
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 03:28:16 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27yk2k4f66-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 03:28:15 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 16 Jan 2017 01:28:15 -0700
References: <20170111021820.24416-1-rth@twiddle.net>
	<20170111021820.24416-11-rth@twiddle.net>
	<e426028a-0763-e9bb-1508-a3dfd26395e9@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 16 Jan 2017 09:28:10 +0100
MIME-Version: 1.0
In-Reply-To: <e426028a-0763-e9bb-1508-a3dfd26395e9@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <454c8298-af6d-0190-993b-b6189cddb557@de.ibm.com>
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
Cc: peter.maydell@linaro.org, Cornelia Huck <cornelia.huck@de.ibm.com>

On 01/13/2017 10:18 AM, Christian Borntraeger wrote:
> On 01/11/2017 03:17 AM, Richard Henderson wrote:
>> This lets us expose facilities to TCG_TARGET_HAS_* defines
>> directly, rather than hiding behind function calls.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  tcg/s390/tcg-target.h     | 126 ++++++++++++++++++++++++-------------=
---------
>>  tcg/s390/tcg-target.inc.c |  74 +++++++++++----------------
>>  2 files changed, 96 insertions(+), 104 deletions(-)
>=20
> This broke compilation.Seems that you forgot one replacement:
>=20
> In file included from /home/cborntra/REPOS/qemu/tcg/tcg.c:253:0:
> /home/cborntra/REPOS/qemu/tcg/s390/tcg-target.inc.c: In function =91tge=
n_cmp=92:
> /home/cborntra/REPOS/qemu/tcg/s390/tcg-target.inc.c:1096:19: error: =91=
facilities=92 undeclared (first use in this function)
>              if (!(facilities & FACILITY_EXT_IMM)) {
>                    ^~~~~~~~~~
> /home/cborntra/REPOS/qemu/tcg/s390/tcg-target.inc.c:1096:19: note: each=
 undeclared identifier is reported only once for each function it appears=
 in
> /home/cborntra/REPOS/qemu/rules.mak:64: recipe for target 'tcg/tcg.o' f=
ailed
> make[1]: *** [tcg/tcg.o] Error 1
> Makefile:203: recipe for target 'subdir-s390x-softmmu' failed
> make: *** [subdir-s390x-softmmu] Error 2
> make: Leaving directory '/home/cborntra/REPOS/qemu/build'
>=20
>=20
>=20

Can we get a fix for this? Seems that a simple replacement of facilities =
-> s390_facilities
would do the trick.

Christian
