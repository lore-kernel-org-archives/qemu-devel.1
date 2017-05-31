Received: from eggs.gnu.org ([2001:4830:134:3::10]:44033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dFvwd-0005EI-E9
	for qemu-devel@nongnu.org; Wed, 31 May 2017 01:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dFvwa-0000PU-57
	for qemu-devel@nongnu.org; Wed, 31 May 2017 01:13:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dFvwZ-0000PJ-S4
	for qemu-devel@nongnu.org; Wed, 31 May 2017 01:13:16 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4V595wE049816
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 01:13:14 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2asj42bsxx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 01:13:13 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 31 May 2017 15:13:10 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4V5CxZn51380448
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 15:13:07 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4V5CXI0001750
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 15:12:34 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA_EisxJa1710ngcpScjfFVvnSpAr-_2RjdmQngoxw0DJw@mail.gmail.com>
References: <1495444679-7736-1-git-send-email-sandipandas1990@gmail.com>
	<87bmqanz6i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<CAFEAcA__bsp5_yJZJr3LBbB_5yuALZ4o5ELXhJo4OO5jjz4G3A@mail.gmail.com>
	<CAFEAcA_EisxJa1710ngcpScjfFVvnSpAr-_2RjdmQngoxw0DJw@mail.gmail.com>
Date: Wed, 31 May 2017 10:42:01 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r2z5bof2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH risu v2] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sandipan Das <sandipandas1990@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 30 May 2017 at 16:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 30 May 2017 at 16:26, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
>>> Sandipan Das <sandipandas1990@gmail.com> writes:
>>>
>>>> The patterns for the following instructions are fixed:
>>>>  * Rotate Left Doubleword then Clear Right (rldcr[.])
>>>>  * Rotate Left Doubleword Immediate then Clear Right (rldicr[.])
>>>>  * Rotate Left Doubleword Immediate then Mask Insert (rldimi[.])
>>>>
>>>> The first instruction has a typo. For the other two instructions,
>>>> the extended opcodes are incorrect and the shift field 'sha' is
>>>> absent. Also, the shift field 'sh' should be used in place of the
>>>> register field 'rb'.
>>>>
>>>> Signed-off-by: Sandipan Das <sandipandas1990@gmail.com>
>>>
>>> Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>>
>> Thanks; applied to risu master.
>
> ...but I foolishly didn't run build-all-archs first, which
> points out that there's a bug:

Ouch :(

> Syntax error detected evaluating RLDIMId PPC64LE constraints string:         ]
> { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
> Global symbol "$rb" requires explicit package name (did you forget to
> declare "my $rb"?) at (eval 429) line 1.
> Global symbol "$rb" requires explicit package name (did you forget to
> declare "my $rb"?) at (eval 429) line 1.
>
> You forgot to update the constraints when you changed the
> field names... I think that the constraints on $rb should
> be removed rather than just changed to use $sh because this
> field is an immediate, not a register number, so we don't need
> to make it avoid 1 and 13. This would bring them into line with
> the other rotate-immediates. I'll post a patch in a second.

Regards
Nikunj
