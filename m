Received: from eggs.gnu.org ([2001:4830:134:3::10]:51151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1eCJyn-0005VX-8v
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1eCJyk-0004qs-3e
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:36:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40092
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1eCJyj-0004qi-Up
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:36:50 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA86YQ9v092717
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 01:36:44 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e3q8f7sxs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 01:36:44 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 01:36:43 -0500
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
	<a6b1668e-b646-186b-8036-193100f15d54@redhat.com>
	<7c5f5d15-2275-7493-d311-73c21e1e1924@linux.vnet.ibm.com>
	<16218abe-3484-333e-e3b7-3f35d0b3f57b@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Wed, 8 Nov 2017 14:36:31 +0800
MIME-Version: 1.0
In-Reply-To: <16218abe-3484-333e-e3b7-3f35d0b3f57b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <423d0de8-f7e2-c6a5-7bfd-31aa4d7ecc31@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>



=E5=9C=A8 2017/11/8 3:35, Eric Blake =E5=86=99=E9=81=93:
> On 11/07/2017 05:00 AM, QingFeng Hao wrote:
>
>>>> +
>>>> +##
>>>> +# @GuestPanicInformationS390:
>>>> +#
>>>> +# S390 specific guest panic information (PSW)
>>>> +#
>>>> +# Since: 2.11
>>>> +##
>>>> +{'struct': 'GuestPanicInformationS390',
>>>> + 'data': { 'psw-mask': 'uint64',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'psw-a=
ddr': 'uint64',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'reaso=
n': 'str' } }
>>> Missing documentation of the three fields; in particular, whether
>> I didn't get your point, do you mean we need to add comments
>> for the three fields? But I don't see the comments for Hyper-V either.
> Your mailer is eating blank lines, which makes it harder to visually
> distinguish where quoting ends and where new content begins (I had a
> blank line between your "'reason': 'str' } }" content and my "Missing
> documentation..." comment).
Sorry about that I am using thunderbird and I had set some related=20
configurations
but not sure what's going on. I can read it normally.
>
> I mean something like:
>
> ##
> # @GuestPanicInformationS390:
> #
> # S390 specific guest panic information (PSW)
> #
> # @psw-mask: <description of what this mask represents>
> # @psw-addr: Address that was accessed to cause the panic
> # @reason: Human-readable explanation of the panic (should not be parse=
d
> #          by a machine)
> #
> # Since: 2.11
> ##
Thanks and our new patch will contain this change.

--=20
Regards
QingFeng Hao
