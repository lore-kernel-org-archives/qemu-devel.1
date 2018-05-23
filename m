Received: from eggs.gnu.org ([2001:4830:134:3::10]:40158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fLSj7-0008TG-S4
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fLSj3-0000ig-GQ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:18:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fLSj3-0000iZ-78
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:18:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4NCG0ED042558
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 08:18:39 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j557jsgy9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 08:18:37 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Wed, 23 May 2018 06:17:40 -0600
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader>
	<20180518075212.GE3416@dnr> <20180518091916.GA22292@vader>
	<20180518130729.GF3416@dnr>
	<7149dfa9-7d3a-a2ff-b326-7e9ba71f8fe1@linux.ibm.com>
	<20180523074757.GI26766@dnr>
	<397e4f8c-0913-6ffd-13fa-743abbbd47e4@linux.ibm.com>
	<eb079c9d-9251-bb2a-7cbc-5cb6423778db@redhat.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Wed, 23 May 2018 20:17:36 +0800
MIME-Version: 1.0
In-Reply-To: <eb079c9d-9251-bb2a-7cbc-5cb6423778db@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c113aa1c-a829-7a96-9874-b8ab48e84a29@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: otubo@redhat.com, =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
Cc: borntraeger@de.ibm.com, fiuczy@linux.ibm.com, qemu-devel@nongnu.org, pbonzini@redhat.com



=E5=9C=A8 2018/5/23 =E4=B8=8B=E5=8D=886:33, Eduardo Otubo =E5=86=99=E9=81=
=93:
> On 05/23/2018 11:16 AM, Yi Min Zhao wrote:
>>
>>
>> =E5=9C=A8 2018/5/23 =E4=B8=8B=E5=8D=883:47, J=C3=A1n Tomko =E5=86=99=E9=
=81=93:
>>> On Sat, May 19, 2018 at 04:20:37PM +0800, Yi Min Zhao wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2018/5/18 =E4=B8=8B=E5=8D=889:07, J=C3=A1n Tomko =E5=86=99=
=E9=81=93:
>>>>> On Fri, May 18, 2018 at 11:19:16AM +0200, Eduardo Otubo wrote:
>>>>>> On 18/05/2018 - 09:52:12, J=C3=A1n Tomko wrote:
>>>>>>> But now libvirt requires QEMU >=3D 1.5.0 which already supports
>>>>>>> query-command-line-options, so if you want the option gone=20
>>>>>>> completely
>>>>>>> --without-seccomp, I can add the code that probes for it and
>>>>>>> make seccomp_sandbox =3D 0 a no-op if it's compiled out.
>>>>>>
>>>>>> This looks like a good solution for the libvirt side. Can you add
>>>>>> this support
>>>>>> so we can merge this fix?
>>>>>>
>>>>>
>>>>> Patches proposed:
>>>>> https://www.redhat.com/archives/libvir-list/2018-May/msg01430.html
>>>>>
>>>>> Jano
>>>> Thanks for your work!
>>>
>>> Now pushed in libvirt master:
>>> commit b87222a90919040c12fb6d7c8dcc20f944a66495
>>> Author:=C2=A0=C2=A0=C2=A0=C2=A0 J=C3=A1n Tomko <jtomko@redhat.com>
>>> AuthorDate: 2018-05-18 14:57:51 +0200
>>> Commit:=C2=A0=C2=A0=C2=A0=C2=A0 J=C3=A1n Tomko <jtomko@redhat.com>
>>> CommitDate: 2018-05-23 09:45:48 +0200
>>>
>>> =C2=A0=C2=A0 qemu: only pass -sandbox off if supported
>>>
>>> =C2=A0=C2=A0 This way we don't rely on QEMU supplying the -sandbox op=
tion
>>> =C2=A0=C2=A0 without CONFIG_SECCOMP.
>>>
>>> =C2=A0=C2=A0 Signed-off-by: J=C3=A1n Tomko <jtomko@redhat.com>
>>> =C2=A0=C2=A0 Reviewed-by: John Ferlan <jferlan@redhat.com>
>>>
>>> git describe: v4.3.0-258-gb87222a909
>>> https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dcommitdiff;h=3Db87222a90=
919040c12fb6d7c8dcc20f944a66495=20
>>>
>>>
>>> Jano
>> Thanks! But I have not got response from Paolo.=C2=A0 I have added him=
 to=20
>> CC list.
>>
> =C2=A0I'll just wait one more ACK and will send a pull request on the=20
> seccomp queue. Thanks for the contribution.
>
>
So... what I should do is wait?
