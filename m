Received: from eggs.gnu.org ([2001:4830:134:3::10]:47333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fFf0R-0002DU-Ro
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fFf0M-0000b6-Sw
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:12:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fFf0M-0000aK-Kr
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:12:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w47C5H4L008578
	for <qemu-devel@nongnu.org>; Mon, 7 May 2018 08:12:33 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2htmq24ret-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 08:12:32 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 7 May 2018 13:12:30 +0100
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<df015c61-0dde-da33-86eb-31abbd6ec805@de.ibm.com>
	<20180507103320.GE17261@vader> <20180507120216.GB25952@dnr>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 7 May 2018 14:12:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180507120216.GB25952@dnr>
Content-Language: en-US
Message-Id: <4c14dbef-2469-304e-d637-d3a8af20637c@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/1] Bug: Sandbox: libvirt
 breakdowns qemu guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>, Eduardo Otubo <otubo@redhat.com>
Cc: fiuczy@linux.ibm.com, libvir-list@redhat.com, qemu-devel@nongnu.org, Yi Min Zhao <zyimin@linux.ibm.com>



On 05/07/2018 02:02 PM, J=E1n Tomko wrote:
> On Mon, May 07, 2018 at 12:33:20PM +0200, Eduardo Otubo wrote:
>> On 07/05/2018 - 11:29:57, Christian Borntraeger wrote:
>>> On 05/07/2018 05:32 AM, Yi Min Zhao wrote:
>>> > 1. Problem Description
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> > If QEMU is built without seccomp support, 'elevatorprivileges' rema=
ins compiled.
>>> > This option of sandbox is treated as an indication for seccomp blac=
klist support
>>> > in libvirt. This behavior is introduced by the libvirt commits 31ca=
6a5 and
>>> > 3527f9d. It would make libvirt build wrong QEMU cmdline, and then t=
he guest
>>> > startup would fail.
>>>
>>> Adding libvirt list.
>>>
>>> This would still fail with older QEMUs, so the question is if we shou=
ld also OR instead
>>> change something in libvirt.
>>
>> Perhaps I'm missing something here, but libvirt can differentiate betw=
een
>> different versions of QEMU, therefore not calling it with wrong or out=
dated
>> arguments.
>>
>=20
> The code introduced in libvirt commit 31ca6a5 specifically looks for
> 'elevateprivileges' in 'parameters' of the 'sandbox' option through
> query-command-line-options.
>=20
> Outdated QEMUs should not have this option there.
>=20
> However, libvirtd does add the option by default not knowing whether it
> can fail for other reasons, e.g. SECCOMP not being enabled in the
> running kernel. I wonder if that is worth addressing.

So you prefer the qemu patch (with cc stable) as the best solution?
