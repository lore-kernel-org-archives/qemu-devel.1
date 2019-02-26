Received: from eggs.gnu.org ([209.51.188.92]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyjC1-0000Lr-3C
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyjC0-00087Q-7S
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:19:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gyjBz-0007Wr-RT
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:19:08 -0500
References: <HK2PR0401MB1955AC7A64864AFEEE3A2E88DE7B0@HK2PR0401MB1955.apcprd04.prod.outlook.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4771b4d7-d780-1053-0441-6c3e0e2ab539@redhat.com>
Date: Tue, 26 Feb 2019 15:18:54 -0500
MIME-Version: 1.0
In-Reply-To: <HK2PR0401MB1955AC7A64864AFEEE3A2E88DE7B0@HK2PR0401MB1955.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] question about qemu-monitor-event result
 redirecting to a file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhan Adlun <zhanhouliang@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 2/26/19 6:51 AM, Zhan Adlun wrote:
> Dear Sir:
>       Sorry to bother you. I use dirty bitmap to do backup in KVM. I could get output from the terminal when I use the command ' virsh qemu-monitor-event DOMAIN --timestamp --loop', but when using ' virsh qemu-monitor-event DOMAIN --timestamp --loop > /file ' to redirect the output to a file, I got nothing both from the terminal and the file. My os version is 'Distributor ID: Ubuntu   Description: Ubuntu 12.04 LTS   Release: 12.04   Codename: precise,Linux version 4.1.0-generic (root@cvknode183) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #1 SMP Wed Nov 9 02:04:23 CST 2016'. KVM version is 'QEMU emulator version 2.7.1(Debian 1:2.7+dfsg-3)'. Hoping for you reply. Thanks!
> 

Hi, I'm not experienced with how virsh manages its IO streams. The
behavior that you see no output in the file OR the console is strange to
me, though.

If you are using bash (or a bash-alike), try
`virsh ...etc... > file.txt 2>&1`
which should really truly output everything to file, but you may have to
wait for stdout flushes to see it, or you can try:
`virsh ...etc... 2>&2 | tee file.txt`
which will hopefully let you monitor the output as it occurs.

Maybe someone else on list with more knowledge of virsh's behaviors can
comment.

--js
