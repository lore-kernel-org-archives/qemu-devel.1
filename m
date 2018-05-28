Received: from eggs.gnu.org ([2001:4830:134:3::10]:46687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fNHh5-0003S2-PP
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fNHh0-0006lA-TU
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:56:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fNHh0-0006im-K9
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:56:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4SCrj9w135440
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 08:56:04 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j8j1jre2v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 08:56:04 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Mon, 28 May 2018 06:56:04 -0600
Received: from b03ledav003.gho.boulder.ibm.com
	(b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id w4SCu1W222217182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 05:56:01 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A3096A03F
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 06:56:01 -0600 (MDT)
Received: from [9.200.36.132] (unknown [9.200.36.132])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP id A9DB36A03D
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 06:56:00 -0600 (MDT)
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
	<1165274f-53fa-ce25-380f-d6509ec083e5@linux.ibm.com>
	<f497ad72-b7c6-4b59-b346-9a4038531b09@redhat.com>
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Mon, 28 May 2018 20:55:59 +0800
MIME-Version: 1.0
In-Reply-To: <f497ad72-b7c6-4b59-b346-9a4038531b09@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9a758d1a-aa2d-986f-6a05-73e454dc15dc@linux.ibm.com>
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
To: qemu-devel@nongnu.org



=E5=9C=A8 2018/5/25 =E4=B8=8B=E5=8D=885:36, Eduardo Otubo =E5=86=99=E9=81=
=93:
> On 05/25/2018 06:23 AM, Yi Min Zhao wrote:
>>
>>
>> =E5=9C=A8 2018/5/24 =E4=B8=8B=E5=8D=889:40, Paolo Bonzini =E5=86=99=E9=
=81=93:
>>> On 24/05/2018 09:53, Eduardo Otubo wrote:
>>>>>>> Thanks! But I have not got response from Paolo.=C2=A0 I have adde=
d=20
>>>>>>> him to
>>>>>>> CC list.
>>>>>>>
>>>>>> =C2=A0=C2=A0I'll just wait one more ACK and will send a pull reque=
st on the
>>>>>> seccomp queue. Thanks for the contribution.
>>>>>>
>>>>>>
>>>>> So... what I should do is wait?
>>>>>
>>>> Yes, even though I think we're safe to proceed without his explicit=20
>>>> ack.
>>> The patch is okay; however, as a follow-up, you could consider moving
>>> all the CONFIG_SECCOMP code to qemu-seccomp.c.
>>>
>>> This way, the only #ifdef remains the one around qemu_opts_foreach.
>>>
>>> Paolo
>>>
>>>
>> Thanks for your comment! Indeed, moving to the single C file is much=20
>> more clear.
>> I will do this after this patch.
>>
>> @Otubo, what about next step?
>>
>>
> If you're willing to send v3 with the changes Paolo suggested, I can=20
> wait to send the pull request. No worries.
>
>
OK. I will update the new version with Paolo's suggestion.
