Received: from eggs.gnu.org ([2001:4830:134:3::10]:46354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgbDL-0004U8-Ow
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgbDH-0001AX-Qq
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:37:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fgbDH-00019a-Hq
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:37:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6KJXmgZ021598
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 15:37:12 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kbm3ncexh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 15:37:12 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Fri, 20 Jul 2018 13:37:11 -0600
References: <1532012617-16777-1-git-send-email-walling@linux.ibm.com>
	<87sh4f191h.fsf@dusky.pond.sub.org>
	<2dca7714-195f-1532-a907-4e43bfd9355e@linux.ibm.com>
	<e1051e1f-f3c8-d43d-feb7-10cc27b8edc0@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 20 Jul 2018 15:37:06 -0400
MIME-Version: 1.0
In-Reply-To: <e1051e1f-f3c8-d43d-feb7-10cc27b8edc0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <efb08d25-6935-7936-0486-63bdf5cd0541@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: print message when using 'help'
 with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>

On 07/20/2018 12:40 PM, Eric Blake wrote:
> On 07/19/2018 11:39 AM, Collin Walling wrote:
>> On 07/19/2018 12:31 PM, Markus Armbruster wrote:
>>> You neglected to cc: maintainers.=C2=A0 Cc'ing them increases the odd=
s your
>>> patch will be noticed and picked up.=C2=A0 You can use
>>> scripts/get_maintainer.pl to find maintainers.=C2=A0 You don't have t=
o do
>>> anything for this patch; it got noticed anyway.
>>>
>>> David, this is yours :)
>>
>> Very true. Was a minor fix that I thought I'd just toss it out there a=
nd
>> let anyone view it if they had the time. Will be more aware of who to =
CC
>> next time around.
>=20
> Or automate it: https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_re=
levant_maintainer suggests:
>=20
> git config sendemail.cccmd 'scripts/get_maintainer.pl --nogit-fallback'
>=20

This is very helpful, thank you.


--=20
Respectfully,
- Collin Walling
