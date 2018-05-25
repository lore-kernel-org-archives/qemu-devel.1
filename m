Received: from eggs.gnu.org ([2001:4830:134:3::10]:33407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fM4GG-0004EE-Bh
	for qemu-devel@nongnu.org; Fri, 25 May 2018 00:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fM4GC-0007HK-8P
	for qemu-devel@nongnu.org; Fri, 25 May 2018 00:23:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fM4GC-0007Gy-0r
	for qemu-devel@nongnu.org; Fri, 25 May 2018 00:23:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4P4Ip3F100012
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 00:23:21 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j6atr96rg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 00:23:21 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Fri, 25 May 2018 00:23:20 -0400
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader>
	<20180518075212.GE3416@dnr> <20180518091916.GA22292@vader>
	<20180518130729.GF3416@dnr>
	<7149dfa9-7d3a-a2ff-b326-7e9ba71f8fe1@linux.ibm.com>
	<20180523074757.GI26766@dnr>
	<397e4f8c-0913-6ffd-13fa-743abbbd47e4@linux.ibm.com>
	<eb079c9d-9251-bb2a-7cbc-5cb6423778db@redhat.com>
	<c113aa1c-a829-7a96-9874-b8ab48e84a29@linux.ibm.com>
	<8de364b2-a1c8-7a29-284c-6356d687638b@redhat.com>
	<33d11137-210b-1a13-e258-d509f4876d67@redhat.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Fri, 25 May 2018 12:23:12 +0800
MIME-Version: 1.0
In-Reply-To: <33d11137-210b-1a13-e258-d509f4876d67@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1165274f-53fa-ce25-380f-d6509ec083e5@linux.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, otubo@redhat.com, =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
Cc: borntraeger@de.ibm.com, fiuczy@linux.ibm.com, qemu-devel@nongnu.org



=E5=9C=A8 2018/5/24 =E4=B8=8B=E5=8D=889:40, Paolo Bonzini =E5=86=99=E9=81=
=93:
> On 24/05/2018 09:53, Eduardo Otubo wrote:
>>>>> Thanks! But I have not got response from Paolo.=C2=A0 I have added =
him to
>>>>> CC list.
>>>>>
>>>>  =C2=A0I'll just wait one more ACK and will send a pull request on t=
he
>>>> seccomp queue. Thanks for the contribution.
>>>>
>>>>
>>> So... what I should do is wait?
>>>
>> Yes, even though I think we're safe to proceed without his explicit ac=
k.
> The patch is okay; however, as a follow-up, you could consider moving
> all the CONFIG_SECCOMP code to qemu-seccomp.c.
>
> This way, the only #ifdef remains the one around qemu_opts_foreach.
>
> Paolo
>
>
Thanks for your comment! Indeed, moving to the single C file is much=20
more clear.
I will do this after this patch.

@Otubo, what about next step?
