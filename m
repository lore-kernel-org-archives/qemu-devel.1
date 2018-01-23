Received: from eggs.gnu.org ([2001:4830:134:3::10]:41882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edwCk-0006Kl-3p
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edwCf-00017M-9T
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:53:26 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edwCf-000165-0m
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:53:21 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id
	0M3jlp-1evTBf2Ysr-00rFwp for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018
	11:53:18 +0100
References: <mvmk1w9lreq.fsf@suse.de>
	<40b82ee1-416b-20c6-4745-218d8e3cdd24@vivier.eu>
	<mvminbsub0j.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e617b5a7-4142-45a2-5b8d-96ed18578f7e@vivier.eu>
Date: Tue, 23 Jan 2018 11:53:17 +0100
MIME-Version: 1.0
In-Reply-To: <mvminbsub0j.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: implement renameat2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Le 23/01/2018 à 11:26, Andreas Schwab a écrit :
> On Jan 23 2018, Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> And, please, test it (build/run).
> 
> This was tested by bootstrapping openSUSE Factory for RISC-V.

I have no doubt on this part, but you should test the "#else" part too,
by, for instance, undefining "__NR_renameat2" locally/temporarily.

Thanks,
Laurent
