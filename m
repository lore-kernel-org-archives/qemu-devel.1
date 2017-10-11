Received: from eggs.gnu.org ([2001:4830:134:3::10]:35804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e25wk-0000bO-OJ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 21:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e25wh-0002Qi-LC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 21:36:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41318
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e25wh-0002Q5-G1
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 21:36:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9B1YWCc122780
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 21:36:22 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dh4wk3gba-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 21:36:22 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 21:36:21 -0400
References: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAFEAcA-Kod+DTZ5MnG4JwswtKTj2PQw4Q8mhBN7sr50000M=Hg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 21:36:19 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Kod+DTZ5MnG4JwswtKTj2PQw4Q8mhBN7sr50000M=Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <89139120-08aa-358c-f878-5c82a0d435b7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PULL v2 00/10] Merge tpm 2017/10/04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, amarnath.valluri@intel.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

On 10/10/2017 11:08 AM, Peter Maydell wrote:
> On 10 October 2017 at 02:33, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>> The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10ea:
>>
>>    Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-10-03 16:27:24 +0100)
>>
>> are available in the git repository at:
>>
>>    git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-04-2
>>
>> for you to fetch changes up to 3bfc6666c21bf9e437734bb3e90db7e5b5f6b8bf:
>>
>>    specs: Describe the TPM support in QEMU (2017-10-05 12:50:45 -0400)
>>
>> ----------------------------------------------------------------
>> Merge tpm 2017/10/04 v2
>>
>> ----------------------------------------------------------------
> Hi. This fails to build, I'm afraid:
>
> On OpenBSD:

I installed OpenBSD 6.2 for i386 . I could recreate this one. PRIx64 
solves it. I don't see the EBADMSG.  We include qemu/osdep.h in this 
file, so this is odd.

     Stefan


>
>    CC      hw/tpm/tpm_emulator.o
> /home/qemu/hw/tpm/tpm_emulator.c: In function 'tpm_emulator_probe_caps':
> /home/qemu/hw/tpm/tpm_emulator.c:223:5: warning: format '%lx' expects
> argument of type 'long unsigned int', but argument 3 has type
> 'ptm_cap' [-Wformat=]
>       DPRINTF("capbilities : 0x%lx", tpm_emu->caps);
>       ^
> gmake: Leaving directory '/home/qemu/build/all'
> gmake: Entering directory '/home/qemu/build/all'
>    CC      hw/tpm/tpm_util.o
> /home/qemu/hw/tpm/tpm_util.c: In function 'tpm_util_test':
> /home/qemu/hw/tpm/tpm_util.c:94:16: error: 'EBADMSG' undeclared (first
> use in this function)
>           return EBADMSG;
>                  ^
> /home/qemu/hw/tpm/tpm_util.c:94:16: note: each undeclared identifier
> is reported only once for each function it appears in
>
> On AArch32:
>
> /home/peter.maydell/qemu/hw/tpm/tpm_emulator.c: In function
> 'tpm_emulator_probe_caps':
> /home/peter.maydell/qemu/hw/tpm/tpm_emulator.c:53:25: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 3 has
> type 'ptm_cap {aka long long unsigned int}' [-Werror=format=]
>           fprintf(stderr, "tpm-emulator:"fmt"\n", ## __VA_ARGS__); \
>                           ^
> /home/peter.maydell/qemu/hw/tpm/tpm_emulator.c:223:5: note: in
> expansion of macro 'DPRINTF'
>       DPRINTF("capbilities : 0x%lx", tpm_emu->caps);
>       ^
>
> On OSX:
> /Users/pm215/src/qemu-for-merges/hw/tpm/tpm_emulator.c:223:36: error:
> format specifies type 'unsigned long' but the argument has type
> 'ptm_cap' (aka 'unsigned long long') [-Werror,-Wformat]
>      DPRINTF("capbilities : 0x%lx", tpm_emu->caps);
>                               ~~~   ^~~~~~~~~~~~~
>                               %llx
> /Users/pm215/src/qemu-for-merges/hw/tpm/tpm_emulator.c:53:52: note:
> expanded from macro 'DPRINTF'
>          fprintf(stderr, "tpm-emulator:"fmt"\n", ## __VA_ARGS__); \
>                                                     ^
>
> thanks
> -- PMM
>
