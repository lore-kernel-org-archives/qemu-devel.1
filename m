Received: from eggs.gnu.org ([2001:4830:134:3::10]:48150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cdxya-0000qS-IS
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cdxyX-0000iM-Eu
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:42:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cdxyX-0000hd-5K
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:42:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1FBd6jL071948
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 06:42:19 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28m9wy0yrt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 06:42:18 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 15 Feb 2017 11:42:15 -0000
References: <20170203175217.45562-1-pasic@linux.vnet.ibm.com>
	<20170210152403.GH2568@work-vm>
	<273b267a-7458-2538-8a4b-a9f8ba6dfc5a@amsat.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 12:42:12 +0100
MIME-Version: 1.0
In-Reply-To: <273b267a-7458-2538-8a4b-a9f8ba6dfc5a@amsat.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <34825483-e6c0-085b-bb85-4d54bad6e2b1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: consolidate VMStateField.start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org



On 02/11/2017 05:26 AM, Philippe Mathieu-Daud=E9 wrote:
> On 02/10/2017 12:24 PM, Dr. David Alan Gilbert wrote:
>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>> The member VMStateField.start is used for two things, partial data
>>> migration for VBUFFER data (basically provide migration for a
>>> sub-buffer) and for locating next in QTAILQ.
>>>
>>> The implementation of the VBUFFER feature is broken when VMSTATE_ALLO=
C
>>> is used. This however goes unnoticed because actually partial migrati=
on
>>> for VBUFFER is not used at all.
>>>
>>> Let's consolidate the usage of VMStateField.start by removing support
>>> for partial migration for VBUFFER.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Thanks for the review Philippe!

@Maintainers: Softfreeze is approaching, and I would like to try
get my 'array of pointers with null pointers' (which is on top of
this) in 2.9 too if possible. Anything I can do to speed things up?

Regards,
Halil
