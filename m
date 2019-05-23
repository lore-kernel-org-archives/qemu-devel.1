Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F516C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE84920863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE84920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42187 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTtFu-0005Zv-49
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 15:19:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTtEw-0005Eb-75
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTtEu-0005ca-V7
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:18:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTtEs-0005al-9F; Thu, 23 May 2019 15:18:54 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MEmtx-1hRNBI13Pf-00GIOR; Thu, 23 May 2019 21:18:03 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
	<20190522140729.25970e17.cohuck@redhat.com>
	<6b101b85-4985-4736-acad-59389b00de55@vivier.eu>
	<20190522142421.746f7495.cohuck@redhat.com>
	<CAL1e-=j5joi3ssA-7Q2PVp841ywj41Ntz_MSKdB4w27Z9JvcEQ@mail.gmail.com>
	<20190523135602.4c80c959.cohuck@redhat.com>
	<e01100bc-50ee-5cc2-2802-a098acc720ac@vivier.eu>
	<87ftp50yo3.fsf@zen.linaroharston>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a8b401ad-57a2-db45-ce7c-f152134ec167@vivier.eu>
Date: Thu, 23 May 2019 21:18:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87ftp50yo3.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JYbf56OaafGqKQOgA/lOj+I1znDB+Ta6NmLC8nIp0A8fatxZUJn
	KMvVm1ooP3F0LKtH+aKMmP4Cu1/+XeQgc6dOpBXiH5ej9BYL3R9QAe8EdEWQpfnQJq+UncE
	cBjIIWGOFuAW8EwBXfBamSmeycgceajWMOt5t/X8G0pFCxDNzMe92BcAzrcw52F+c4OLDhm
	TLziwjoEa+Z8vOl6JtYOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y2FDu4OviBI=:XIiC8SpvhyZDHRunS8QRPI
	rXCfSeXSCLPAB4Uk/xdxe4v/RoB8/M6hrsnJx5ZO9pC4h13MpxxoADS+rX6LMXntaNXTqbyUM
	pDq4WulEK/MduKEqgOg3uhn5aLskGCzMa4x8QyAQVjAUBV/RbNf98D6Mbkhg07NaaMEbom7EN
	+QKZ6kTJp5lkJKwlEVsQ3Ki7PT6d2HNRZc6HN/vTnUREG1d5SFtIpoWYvHaDbXg0kqkayGAF3
	YrPCaUP2cct0gYIMXpcJAZLxgx78cDf2lW6yuHFIjRffrKgRfwH0HAGqXxo9Qh6sHXJxFfycj
	tAxY1+CARsZt6m9/5y5X0yY4/i2U2ltF62fgV9A5ffORb4Sjhofg2RQX3dWRogQIRVlPX31ja
	tZTxd5rKb3x3Qxan6uwcoEZ261AYngI/AZUQY9+OAM7UP7zZTyp2YCWTF4OcchAwQzyp+rX99
	tfXDQatqz4CD2//HZPBDolfmA4lGeuwr3phiZQqElcd8ySiau+s8+P/OiYUncYSyVD5uNXMiw
	QNAbRLZARyt0fUBxGrCG7za4T25mVWguZeenzDpOgfFetN8Hf2FQLyfTdvpLnDXI0q6UFONQc
	9hnlVSLKfwJZLNUdDXB45uo2UvTrgrx/b0UMrPJTccl8+XJnZ34wW9RlNbwiiBST5FA9J6330
	2atwnoL+X61tt8n7OoTEKY7E+CbLEcwd75VqnTJEzfZQC4NkU0n23/WSaqYfRGEEhxMv57FOn
	WPmy/mPuegkD9oxryQ4mDOHLt8QqG/P33Lh+UsCyulXWBqlnI6TrQNx20N4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/05/2019 21:16, Alex Bennée wrote:
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> On 23/05/2019 13:56, Cornelia Huck wrote:
>>> On Wed, 22 May 2019 15:22:23 +0200
>>> Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
>>>
>>>> The alternative way of invoking via IPCV6 (else part of “ifdef
>>>> __NR_MSGSND”) should work for MIPS in the present stage of headers and
>>>> kernel.
>>>
>>> I tried to do that so that we have at least a workaround for now; but
>>> this fails building on my x86 laptop (the safe_syscall6 for ipc
>>> complains about missing __NR_ipc). Maybe I'm holding it wrong (should
>>> that be conditional on the host?), but I think that really needs to be
>>> done by the mips maintainers...
>>>
>>
>> Perhaps a simple workaround could be:
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index e311fcda0517..5b431736032c 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -761,14 +761,8 @@ safe_syscall2(int, nanosleep, const struct timespec *, req,
>>   safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>>                 const struct timespec *, req, struct timespec *, rem)
>>   #endif
>> -#ifdef __NR_msgsnd
>> -safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
>> -              int, flags)
>> -safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
>> -              long, msgtype, int, flags)
>> -safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>> -              unsigned, nsops, const struct timespec *, timeout)
>> -#else
>> +
>> +#ifdef __NR_ipc
>>   /* This host kernel architecture uses a single ipc syscall; fake up
>>    * wrappers for the sub-operations to hide this implementation detail.
>>    * Annoyingly we can't include linux/ipc.h to get the constant definitions
>> @@ -783,14 +777,30 @@ safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>>
>>   safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
>>                 void *, ptr, long, fifth)
>> +#endif
> 
> *sigh* almost but for arches we get complaints when the ipc syscall is
>   defined but not used....
> 
>    https://app.shippable.com/github/stsquad/qemu/runs/835/summary/console

Yes, I've know.

I have sent a patch with an updated #if:

  #if !defined(__NR_msgsnd) || !defined(__NR_msgrcv) || !defined(__NR_semtimedop)

And it should work on any arch.

Thanks,
Laurent


