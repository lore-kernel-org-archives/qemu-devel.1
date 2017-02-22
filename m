Received: from eggs.gnu.org ([2001:4830:134:3::10]:37596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cge30-0001Vh-GL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 16:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cge2w-0003Bo-Hh
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 16:02:02 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cge2w-0003Be-As
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 16:01:58 -0500
Received: by mail-wm0-x230.google.com with SMTP id v77so10153129wmv.1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 13:01:58 -0800 (PST)
References: <20170222171327.26624-1-alex.bennee@linaro.org>
	<148778745330.150.5479386803551876071@0e2666bad730>
	<8737f6vw37.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8737f6vw37.fsf@linaro.org>
Date: Wed, 22 Feb 2017 21:02:04 +0000
Message-ID: <871suqvt0z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 00/24] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, rth@twiddle.net, peter.maydell@linaro.org, mttcg@listserver.greensocs.com, nikunj@linux.vnet.ibm.com, jan.kiszka@siemens.com, mark.burton@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, serge.fdrv@gmail.com, pbonzini@redhat.com, bobby.prani@gmail.com, bamvor.zhangjian@linaro.org, fred.konrad@greensocs.com


Alex Bennée <alex.bennee@linaro.org> writes:

> no-reply@patchew.org writes:
>
>> Hi,
>>
>> This series failed build test on s390x host. Please find the details
>> below.

It also failed on x86-on-x86 MTTCG as well as other tests:

>> ERROR:/var/tmp/patchew-tester-tmp-_186415r/src/cpus.c:1554:qemu_mutex_lock_iothread: assertion failed: (!qemu_mutex_iothread_locked())
>> GTester: last random seed: R02Sf1ce767b432f1559eaf8cc0c5a31eb02
>
> Well I've seen this before if the IRQ chain doesn't do locking properly
> but I'm at a loss why this breaks on an s390 host as the code is common.
>
> Does anyone have a spare s390 that I can test on?

Look like I'll have to roll this in:

  https://github.com/stsquad/qemu/commit/c6f4245ffd9df8ffcd2d4d655c322189c19a6c1a

Which conflicted with Paolo's re-factoring
(209b71b60ef3341246038e1c926c3b704969cdd3). I'll leave it running
overnight and see if I can do a cleaner fix.

14th's time is the charm ;-)

--
Alex Bennée
