Received: from eggs.gnu.org ([2001:4830:134:3::10]:36502)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cUG26-0001Yj-SU
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cUG22-0002Ym-Rx
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:57:54 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:44408 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cUG22-0002Y0-Im
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 11:57:50 -0500
References: <0bb184fe-d348-a1d4-ac14-0f02f070c287@kamp.de>
	<20170119163845.GC16641@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <8e98321f-70ce-f86a-37d3-de2c1a5f45bd@kamp.de>
Date: Thu, 19 Jan 2017 17:57:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170119163845.GC16641@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-img: complains about missing iscsi option
 group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

Am 19.01.2017 um 17:38 schrieb Daniel P. Berrange:
> On Thu, Jan 19, 2017 at 05:30:20PM +0100, Peter Lieven wrote:
>> Hi all,
>>
>>
>> since commit f57b4b5 (blockdev: prepare iSCSI block driver for dynamic loading)
>>
>> qemu-img complains about a missing option group several times.
>>
>>
>> ~/git/qemu$ ./qemu-img info iscsi://172.21.200.56:3260/iqn.2001-05.com.equallogic:0-8a0906-69d384e0a-aa3004e55e15878d-00lieven-data/0
>> qemu-img: There is no option group 'iscsi'
>> qemu-img: There is no option group 'iscsi'
>> qemu-img: There is no option group 'iscsi'
>> qemu-img: There is no option group 'iscsi'
>> image: iscsi://172.21.200.56:3260/iqn.2001-05.com.equallogic:0-8a0906-69d384e0a-aa3004e55e15878d-00lieven-data/0
>> file format: raw
>> virtual size: 25G (26848788480 bytes)
>> disk size: unavailable
>> cluster_size: 15728640
>>
>> I don't know whats the proper way to fix this?
> Move the iscsi option registration out of vl.c and back into a shared file
> in block/ such that all programs see the options, not just the emulators.

Any preference which file? It seems no other block driver registers options.

Thanks,
Peter
