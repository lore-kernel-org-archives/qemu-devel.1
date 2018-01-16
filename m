Received: from eggs.gnu.org ([2001:4830:134:3::10]:52705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebTU2-0000Ni-KR
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebTTy-0002AZ-Oc
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:49:06 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-2-git-send-email-walling@linux.vnet.ibm.com>
	<34c87c41-eb49-0e2b-3857-9bb3ba86c8d4@redhat.com>
	<e0653416-ea6a-f801-2c30-4d01ed1fcf42@linux.vnet.ibm.com>
	<b0f8289b-287b-a0c5-ab85-82e6c39d24b9@de.ibm.com>
	<b86618f5-e5cb-8953-508f-e73339b1a475@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e5a8a7a7-676f-1aa9-79b5-651d4494bc84@redhat.com>
Date: Tue, 16 Jan 2018 16:48:48 +0100
MIME-Version: 1.0
In-Reply-To: <b86618f5-e5cb-8953-508f-e73339b1a475@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/8] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Blake <eblake@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com

On 16.01.2018 16:32, Collin L. Walling wrote:
> On 01/16/2018 06:07 AM, Christian Borntraeger wrote:
>>
>> On 01/15/2018 06:23 PM, Collin L. Walling wrote:
>>> On 01/15/2018 12:05 PM, Eric Blake wrote:
[...]
>>>> I'm not a lawyer, but generically, the GPL and its variants depend o=
n a
>>>> copyright owner to actually work.=C2=A0 You may want to add a copyri=
ght
>>>> line.
>>>
>>> I'll have to check on that.=C2=A0 I was not the original author of th=
e
>>> libc.h file.
>> I think you can add the normal IBM Copyright statement. (I think all
>> authors could add theirs as well)
>=20
> "Copyright 2018 IBM Corp."
>=20
> @Thomas, git shows you as the initial creator of libc.h.=C2=A0 Shall I =
add
> "Copyright 2018 Thomas Huth, Red Hat Inc." in there as well?

Actually, I only moved the functions from s390-ccw.h and sclp.c into
that header file. I just tried to trace who introduced them first, and
it seems like it was Alex who added them. So I guess you should add:

 Copyright (c) 2013 Alexander Graf <agraf@suse.de>

to libc.h for that. Sorry that I did not do that right from the start.

 Thomas
