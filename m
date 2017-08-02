Received: from eggs.gnu.org ([2001:4830:134:3::10]:53026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dcuMJ-00069u-2W
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dcuMF-0004EQ-Kh
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:10:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:58433)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dcuMF-0004A3-Cj
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:10:43 -0400
References: <20170717120326.27967-1-ppandit@redhat.com>
	<20170717144811.emvnjxsuulj6e3hw@var.youpi.perso.aquilenet.fr>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <1eeb45be-cc88-7f7d-f177-10f1646698b5@msgid.tls.msk.ru>
Date: Wed, 2 Aug 2017 17:10:32 +0300
MIME-Version: 1.0
In-Reply-To: <20170717144811.emvnjxsuulj6e3hw@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] slirp: check len against dhcp options
 array end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, P J P <ppandit@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>, Qemu Developers <qemu-devel@nongnu.org>, Reno Robert <renorobert@gmail.com>

17.07.2017 17:48, Samuel Thibault wrote:
> P J P, on lun. 17 juil. 2017 17:33:26 +0530, wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> While parsing dhcp options string in 'dhcp_decode', if an options'
>> length 'len' appeared towards the end of 'bp_vend' array, ensuing
>> read could lead to an OOB memory access issue. Add check to avoid it.
>>
>> Reported-by: Reno Robert <renorobert@gmail.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Oops, sure, applied to my tree, thanks!

Can we have it in 2.10 please?

This is CVE-2017-11434, which can be mentioned in the commit message.

Thanks,

/mjt
