Received: from eggs.gnu.org ([2001:4830:134:3::10]:49148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cm908-00057N-PM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 20:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cm903-0001vO-PW
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 20:05:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60116
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cm903-0001t3-Iv
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 20:05:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2A0wfx4112450
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 20:05:41 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 292yb1jj4q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 20:05:41 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Thu, 9 Mar 2017 20:05:41 -0500
References: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
	<20170307025328.53409-2-haoqf@linux.vnet.ibm.com>
	<20170307092951.GA5871@noname.str.redhat.com>
	<80495689-674c-5dde-ae49-d80a2eb20372@linux.vnet.ibm.com>
	<20170307100525.GD5871@noname.str.redhat.com>
	<cbd5b0ac-4cae-6f5b-2583-a6e32eb65f38@linux.vnet.ibm.com>
	<a0013bf9-4e53-7a38-3249-b7267ae33307@linux.vnet.ibm.com>
	<6c0b3128-37e6-8607-abab-4f655cd91426@linux.vnet.ibm.com>
	<e041a9d5-e5f0-dc15-5332-3a389bb4ef98@linux.vnet.ibm.com>
	<7a65f1b6-3767-cf0c-9d9e-a3357f14e8cc@linux.vnet.ibm.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Fri, 10 Mar 2017 09:04:52 +0800
MIME-Version: 1.0
In-Reply-To: <7a65f1b6-3767-cf0c-9d9e-a3357f14e8cc@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <11104a08-1001-84d4-ebca-98c68010f223@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] vmstate: draft fix for failed
 iotests case 68 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, liujbjl@linux.vnet.ibm.com, qemu-devel@nongnu.org, mreitz@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, dgilbert@redhat.com



=E5=9C=A8 2017/3/9 19:45, Halil Pasic =E5=86=99=E9=81=93:
>
> On 03/09/2017 03:55 AM, QingFeng Hao wrote:
>>
>> =E5=9C=A8 2017/3/8 19:33, Halil Pasic =E5=86=99=E9=81=93:
>>> On 03/08/2017 08:05 AM, QingFeng Hao wrote:
>>>> =E5=9C=A8 2017/3/7 18:19, Halil Pasic =E5=86=99=E9=81=93:
>>>>> On 03/07/2017 11:05 AM, Kevin Wolf wrote:
>>>>>> Am 07.03.2017 um 10:54 hat Halil Pasic geschrieben:
>>>>>>> On 03/07/2017 10:29 AM, Kevin Wolf wrote:
>>>>>>>> Am 07.03.2017 um 03:53 hat QingFeng Hao geschrieben:
> [..]
>>>> The question is: can we do that change and what the second assert of=
 field's flags is used for?
>>> The assert is there to guard against unintended use of this nullptr-m=
arker
>>> mechanism.
>>>
>>> I have tested so this should work. By the way a vmstate test covering=
 this
>>> corner-case would be a good idea too (IMHO). Would you like to write =
one?
>> Sorry, I don't know how to write that test case. Can you please write =
one?
>> thanks!
> The test is just nice to have, but we definitely need the fix!
Ok, I'll send out the discussed fix patch.
>
> Halil

--=20
Regards
QingFeng Hao
