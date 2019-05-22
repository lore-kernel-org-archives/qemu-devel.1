Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB4C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE87121019
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE87121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48907 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTVMq-0006OR-Vp
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 13:49:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hTVLz-0005qB-PY
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hTVLy-0003wx-3F
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:48:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34238
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hTVLx-0003wF-PP
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:48:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4MHgk1l088098
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 13:48:35 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sn8778xkx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 13:48:35 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 May 2019 18:48:21 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 22 May 2019 18:48:17 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
	[9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4MHmGtU28377174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 22 May 2019 17:48:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B7724C044;
	Wed, 22 May 2019 17:48:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 091AD4C04A;
	Wed, 22 May 2019 17:48:16 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.22.187])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 22 May 2019 17:48:15 +0000 (GMT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAL1e-=i4++B0iFU7k+G_pCZYg=O_sHhKvxM-aWpTZQZk44t4-A@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
	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
	syiRa+UVlsKmx1hsEg==
Date: Wed, 22 May 2019 19:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i4++B0iFU7k+G_pCZYg=O_sHhKvxM-aWpTZQZk44t4-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19052217-0020-0000-0000-0000033F61D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052217-0021-0000-0000-000021924828
Message-Id: <060b93c9-dcb2-a73c-3f4b-42f35d46f515@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905220124
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0b-001b2d01.pphosted.com id x4MHgk1l088098
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL v3 47/55] linux headers: update
 against Linux 5.2-rc1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
	qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 22.05.19 15:50, Aleksandar Markovic wrote:
>=20
> On May 22, 2019 3:42 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org <ma=
ilto:alex.bennee@linaro.org>> wrote:
>>
>>
>> Aleksandar Markovic <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.=
mail@gmail.com>> writes:
>>
>> > On May 22, 2019 2:24 PM, "Cornelia Huck" <cohuck@redhat.com <mailto:=
cohuck@redhat.com>> wrote:
>> >>
>> >> On Wed, 22 May 2019 14:10:39 +0200
>> >> Laurent Vivier <laurent@vivier.eu <mailto:laurent@vivier.eu>> wrote=
:
>> >>
>> >> > On 22/05/2019 14:07, Cornelia Huck wrote:
>> >> > > On Wed, 22 May 2019 13:47:25 +0200
>> >> > > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@r=
edhat.com>> wrote:
>> >> > >
>> >> > >> On 5/21/19 5:28 PM, Cornelia Huck wrote:
>> >> > >>> commit a188339ca5a396acc588e5851ed7e19f66b0ebd9
>> >> > >>>
>> >> > >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com <mailto:cohuc=
k@redhat.com>>
>> >> > >>> ---
>> >> > >> [...]
>> >> > >>>=C2=A0 =C2=A0#define __NR_mq_notify 184
>> >> > >>>=C2=A0 =C2=A0__SC_COMP(__NR_mq_notify, sys_mq_notify, compat_s=
ys_mq_notify)
>> >> > >>>=C2=A0 =C2=A0#define __NR_mq_getsetattr 185
>> >> > >>> @@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd,
>> > compat_sys_msgsnd)
>> >> > >>>=C2=A0 =C2=A0__SYSCALL(__NR_semget, sys_semget)
>> >> > >>>=C2=A0 =C2=A0#define __NR_semctl 191
>> >> > >>>=C2=A0 =C2=A0__SC_COMP(__NR_semctl, sys_semctl, compat_sys_sem=
ctl)
>> >> > >>> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG =
!=3D 32
>> >> > >
>> >> > > Eww. It seems only aarch64 sets __ARCH_WANT_TIME32_SYSCALLS, an=
d the
>> >> > > second condition probably catches others but not mipsel.
>> >> > >
>> >> > >>>=C2=A0 =C2=A0#define __NR_semtimedop 192
>> >> > >>> -__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtim=
edop)
>> >> > >>> +__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_ti=
me32)
>> >> > >>> +#endif
>> >> > >>>=C2=A0 =C2=A0#define __NR_semop 193
>> >> > >>>=C2=A0 =C2=A0__SYSCALL(__NR_semop, sys_semop)
>> >> > >> [...]
>> >> > >>
>> >> > >> https://app.shippable.com/github/qemu/qemu/runs/1703/summary/c=
onsole
>> >> > >>
>> >> > >> It seems this commit introduce a regression on mips32:
>> >> > >>
>> >> > >>=C2=A0 =C2=A0 CC=C2=A0 =C2=A0 =C2=A0 mipsel-linux-user/linux-us=
er/syscall.o
>> >> > >> ./linux-user/syscall.c: In function 'safe_semtimedop':
>> >> > >> ./linux-user/syscall.c:697:25: error: '__NR_semtimedop' undecl=
ared
>> >> > >> (first use in this function)
>> >> > >>=C2=A0 =C2=A0 =C2=A0 =C2=A0return safe_syscall(__NR_##name, arg=
1, arg2, arg3, arg4); \
>> >> > >
>> >> > > So, we unconditionally deal with this syscall, i.e. we assume i=
t is
>> >> > > always present? (I'm not sure of the logic in linux-user code.)
>> >> > >
>> >> >
>> >> > linux-user assumes it is present if __NR_msgsnd is present.
>> >>
>> >> Hm. The kernel change seems to break that assumption. Does anyone w=
ith
>> >> mips knowledge have an idea whether that was intentional (and the
>> >> linux-user code needs to be changed), or whether that's an issue on=
 the
>> >> kernel side?
>> >>
>> >
>> > Hi, Cornelia.
>> >
>> > Thanks for your involving into this issue!
>> >
>> > It could be that (not-originating-from-MIPS) kernel commit:
>> >
>> > https://github.com/torvalds/linux/commit/1a787fc5ba18ac767e635c58d06=
a0b46876184e3
>> >
>> > made a mess with system call availability for MIPS (I will forward t=
his to
>> > MIPS kernel maintainer Paul Burton). My impression is that this was =
not
>> > intentional, and is a temporary instability of kernel interface.
>>
>> I think this stems from 2038 time bomb work. Eventually they want it t=
o
>> be possible to build non-legacy kernels that don't expose time32 to th=
e
>> outside world. As part of that new system calls are being introduced
>> where needed. The IPC syscall which orignally multiplexed a bunch of
>> these operations on some systems would eventually be potentially phase=
d
>> out.
>>
>> > However, I think that QEMU nevertheless should not make the assumpti=
on that
>> > if __NR_MSGSND, than semtimedop() is present. It could be true, but =
it is
>> > still just self-imposed belief in QEMU, kernel never guarantied such=
 things.
>> >
>> > The alternative way of invoking via IPCV6 (else part of =E2=80=9Cifd=
ef
>> > __NR_MSGSND=E2=80=9D) should work for MIPS in the present stage of h=
eaders and
>> > kernel.
>>
>> Yeah I think #ifndef __NR_ipc would work for now. It shouldn't affect
>> architectures that never had the IPC call.
>>
>> > As a side note, perhaps we shoul update kernel headers only off of s=
table
>> > kernel releases.
>>
>> I guess that's a part of the tension for supporting new kernel APIs
>> quickly. At least 5.2-rc1 wasn't a random tree - you would expect the
>> external facing ABI to be stable after the merge window closed. It wou=
ld
>> be nice to know what new features were being exposed though.
>>
>=20
> Yes, one would expect no intentional changes in ABI kernel headers woul=
d happen after RC1. However, one must expect that there could certainly b=
e bugs in RC1 - and there is a larger risk of propagating these bugs to Q=
EMU with header updates from non-stable code.

An alternative would be to ONLY update the relevant changes of the header=
s
that are necessary for this particular pull request( in this case the s39=
0
parts) and then do a full header sync on each release (e.g. 5.1, 5.2) to =
still
make sure that we are pretty much up2date.


