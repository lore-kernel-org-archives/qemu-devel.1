Received: from eggs.gnu.org ([2001:4830:134:3::10]:34318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dVq9m-0004HN-LC
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dVq9i-0001Xx-JY
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:16:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongdwdw@linux.vnet.ibm.com>)
	id 1dVq9i-0001WX-9V
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:16:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6E2FC4R090350
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 22:16:31 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpmjah0xk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 22:16:30 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <dongdwdw@linux.vnet.ibm.com>;
	Fri, 14 Jul 2017 12:16:27 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v6E2GPId26280044
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 12:16:25 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v6E2GGQ5012015
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 12:16:17 +1000
References: <f7206d1d-addb-1f69-1a77-dc83c1b50e36@linux.vnet.ibm.com>
	<f462bb68-fc63-baec-235c-726066e25d44@gmail.com>
	<8b8c84aa-16c0-2bac-3b8a-9be595682356@linux.vnet.ibm.com>
	<2f6d682c-68af-b689-701b-b7b05a598d7a@gmail.com>
From: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Date: Fri, 14 Jul 2017 10:16:23 +0800
MIME-Version: 1.0
In-Reply-To: <2f6d682c-68af-b689-701b-b7b05a598d7a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <dcc90618-bef2-5572-3350-695686a62323@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] About the trace framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com



On 07/11/2017 05:39 PM, Xie Changlong wrote:
> =E5=9C=A8 7/11/2017 9:33 AM, Wang Dong =E5=86=99=E9=81=93:
>>
>>
>> On 07/10/2017 01:24 PM, Xie Changlong wrote:
>>> =E5=9C=A8 7/9/2017 5:57 PM, Wang Dong =E5=86=99=E9=81=93:
>>>> Hi,
>>>>
>>>> I am new to QEMU. But I got some problem so that  I want to figure=20
>>>> it out.
>>>>
>>>> So I try to debug qemu to see what happened.
>>>>
>>>> And I found trace framework. I think this will help me understand=20
>>>> the point.
>>>>
>>>> So I compiled qemu with option:
>>>>
>>>> ## *--enable-trace-backends=3Dsimple*
>>>>
>>>> And did as the docs/tracing.txt tell. But when I execute the=20
>>>> example command in it, nothing just happens.
>>>>
>>>> *./scripts/simpletrace.py trace-events-all trace-xxxxxx(my trace=20
>>>> file produced by qemu)
>>>> I am not sure what happened. Just ask this.
>>>> Any clue will be appreciated. Thanks in advance.
>>>> *
>>>>
>>>
>>> Did you set *trace-event*? I've encountered this issue in the past :)
>>> (qemu) help trace-event
>>> trace-event name on|off -- changes status of a specific trace event
>>> (qemu) info trace-events
>> yes, I set it. I just did as the docs told. If this does not work or=20
>> misses something, it should be corrected I think.
>>
>> Have you also tried out the examples in docs? how did you do that? I=20
>
> Yes, just follow the docs. No something special.
>
>> think I misses some. Could you tell more about
>> it? Thanks.
>
> You should confirm the *trace-event*s you set are really triggered by=20
> qemu. Use gdb breakpoint to verify it is a good choice.
>
>>
OK, I will try that. Thanks for your advice.

--=20
Best regards. Wang Dong
