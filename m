Received: from eggs.gnu.org ([2001:4830:134:3::10]:35078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dUk4V-0007P8-8v
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 21:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dUk4S-0001AW-67
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 21:34:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongdwdw@linux.vnet.ibm.com>)
	id 1dUk4R-0001AB-TK
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 21:34:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6B1YJRQ133367
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 21:34:33 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bmd1pfd39-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 21:34:33 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <dongdwdw@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 11:34:30 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v6B1XCb026148958
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 11:33:12 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
	by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v6B1XCWQ014443
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 11:33:12 +1000
References: <f7206d1d-addb-1f69-1a77-dc83c1b50e36@linux.vnet.ibm.com>
	<f462bb68-fc63-baec-235c-726066e25d44@gmail.com>
From: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 09:33:10 +0800
MIME-Version: 1.0
In-Reply-To: <f462bb68-fc63-baec-235c-726066e25d44@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <8b8c84aa-16c0-2bac-3b8a-9be595682356@linux.vnet.ibm.com>
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



On 07/10/2017 01:24 PM, Xie Changlong wrote:
> =E5=9C=A8 7/9/2017 5:57 PM, Wang Dong =E5=86=99=E9=81=93:
>> Hi,
>>
>> I am new to QEMU. But I got some problem so that  I want to figure it=20
>> out.
>>
>> So I try to debug qemu to see what happened.
>>
>> And I found trace framework. I think this will help me understand the=20
>> point.
>>
>> So I compiled qemu with option:
>>
>> ## *--enable-trace-backends=3Dsimple*
>>
>> And did as the docs/tracing.txt tell. But when I execute the example=20
>> command in it, nothing just happens.
>>
>> *./scripts/simpletrace.py trace-events-all trace-xxxxxx(my trace file=20
>> produced by qemu)
>> I am not sure what happened. Just ask this.
>> Any clue will be appreciated. Thanks in advance.
>> *
>>
>
> Did you set *trace-event*? I've encountered this issue in the past :)
> (qemu) help trace-event
> trace-event name on|off -- changes status of a specific trace event
> (qemu) info trace-events
yes, I set it. I just did as the docs told. If this does not work or=20
misses something, it should be corrected I think.

Have you also tried out the examples in docs? how did you do that? I=20
think I misses some. Could you tell more about
it? Thanks.

--=20
Best regards. Wang Dong
