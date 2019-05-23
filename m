Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B5AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBAE20851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBAE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmuE-0005uI-81
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:33:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTmsV-00052e-TJ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTmsU-0006Z2-UC
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:31:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTmsS-0006XN-JX; Thu, 23 May 2019 08:31:20 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MAPBF-1hMxEb10wd-00BvOL; Thu, 23 May 2019 14:30:54 +0200
To: Cornelia Huck <cohuck@redhat.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
	<20190522140729.25970e17.cohuck@redhat.com>
	<6b101b85-4985-4736-acad-59389b00de55@vivier.eu>
	<20190522142421.746f7495.cohuck@redhat.com>
	<CAL1e-=j5joi3ssA-7Q2PVp841ywj41Ntz_MSKdB4w27Z9JvcEQ@mail.gmail.com>
	<20190523135602.4c80c959.cohuck@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e01100bc-50ee-5cc2-2802-a098acc720ac@vivier.eu>
Date: Thu, 23 May 2019 14:30:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190523135602.4c80c959.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/F2ewAXnlg7FG7lTpEClw8Og+XDCUuOguY8/VQqSlhBp1mIKb6/
	9q94af2so6VxvPC5fn6rlOq17Qh8xZ+t/Gu8xjuAY4CncqrqW99RslqO+hV30G1wferOIOC
	TZGMMrmqu0Wh4Uk9b0s9/tyhTcqjCgjCp9LbRRP7Saa2EazxJvKUegY+ycP/1aj5VnJsJAW
	ywdzODm29i35DvhVwPWZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hpYrWZKCLJY=:deFRc6qTEOE1/0wDIfHJkl
	0jYqzzY6XsdRS7R/JByUloms36miFji2j+tYl+uGcipRXUwEGh1lRiGPrgCy4tkYJ4OwfvHiQ
	33kyocOL2yrw+n/1LIZkhUdevDJKufH2H3oCeF9xP+aXVFzR4G2eDsZ2l4ZmbRA5eZnFUUqZC
	LH/b2Q7iZWv1lBbsVxDoUDiNVRCTFq/spdliZ02iS++SsncvWH8lIQiZjonpcWvjpS1Omk6lf
	AwcpS23fuZlUGaHOI3DBSXrD63rCNRKCBHSue5SrzgP81/Zln4Tm5+1SctwUyDTlrr7jcJUeg
	pd1HGFYTNiHLAdqCB6OJ+pn7GiVqBS11fVM9ETgMhlFqfNMDqh3p0+HwaTssUx7TYIQeHsTf0
	3RFbVPRQy+2ooqi32vHZihTHuCeUDI6jQUv0mdMZ8qCu1B5ntpTJlgHgzxfbhFuL+hY6yyHZF
	65lFbHzcOYxlTbQIpo11K0RopeBo22vT43VEfttK1F+9Ll4j6F3SWKx6gih7Be+Sq0i5A48cG
	pY1rhw0cyJWQUiC63c5r370wPnrTBM+moU/XaABJ9z0tqxXQkRFcuELbgkJrprgFK0JC08u7y
	Os+OdtGY0E2ui+og8iwFrpbX3Hr9Sl3h8cqsjGJrhX1pu5cpskI3xOPyXHJdV5nPS7QL7fkuq
	MVn4GnW0+dX4SIAWSnXpeOAXb2T1Gleyja5/ZzZz2C+jIPEk2ckMtRzob1qvpwIW9EyUKZtjC
	BXk6lLbzuPS5xgpQjNYZw3ZOH4IPbNjXHiHERU7baffzGs+/+OcAYJyatYM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PULL v3 47/55] linux headers: update against
 Linux 5.2-rc1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/05/2019 13:56, Cornelia Huck wrote:
> On Wed, 22 May 2019 15:22:23 +0200
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
> 
>> The alternative way of invoking via IPCV6 (else part of “ifdef
>> __NR_MSGSND”) should work for MIPS in the present stage of headers and
>> kernel.
> 
> I tried to do that so that we have at least a workaround for now; but
> this fails building on my x86 laptop (the safe_syscall6 for ipc
> complains about missing __NR_ipc). Maybe I'm holding it wrong (should
> that be conditional on the host?), but I think that really needs to be
> done by the mips maintainers...
> 

Perhaps a simple workaround could be:

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e311fcda0517..5b431736032c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -761,14 +761,8 @@ safe_syscall2(int, nanosleep, const struct timespec *, req,
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
-#ifdef __NR_msgsnd
-safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
-              int, flags)
-safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
-              long, msgtype, int, flags)
-safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
-              unsigned, nsops, const struct timespec *, timeout)
-#else
+
+#ifdef __NR_ipc
 /* This host kernel architecture uses a single ipc syscall; fake up
  * wrappers for the sub-operations to hide this implementation detail.
  * Annoyingly we can't include linux/ipc.h to get the constant definitions
@@ -783,14 +777,30 @@ safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
 
 safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
               void *, ptr, long, fifth)
+#endif
+
+#ifdef __NR_msgsnd
+safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
+              int, flags)
+#else
 static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int flags)
 {
     return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void *)msgp, 0);
 }
+#endif
+#ifdef __NR_msgrcv
+safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
+              long, msgtype, int, flags)
+#else
 static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type, int flags)
 {
     return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp, type);
 }
+#endif
+#ifdef __NR_semtimedop
+safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
+              unsigned, nsops, const struct timespec *, timeout)
+#else
 static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nsops,
                            const struct timespec *timeout)
 {

