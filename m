Received: from eggs.gnu.org ([2001:4830:134:3::10]:59184)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1emcbN-0001kX-GQ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 04:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1emcbK-0006n4-S0
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 04:46:45 -0500
Received: from mx01.kamp.de ([82.141.2.16]:56644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1emcbK-0006lo-Gw
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 04:46:42 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:46:37 +0100
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
	<1fa746ad-7640-6159-26e3-b2fb378c68af@kamp.de>
	<20180212161323.GC2545@work-vm>
From: Peter Lieven <pl@kamp.de>
Message-ID: <2fda5f4a-3b92-db47-6d74-0f88a6ef5f55@kamp.de>
Date: Fri, 16 Feb 2018 10:46:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180212161323.GC2545@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/54] Patch Round-up for
 stable 2.11.1, freeze on 2018-02-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, qemu-devel@nongnu.org

Am 12.02.2018 um 17:13 schrieb Dr. David Alan Gilbert:
> * Peter Lieven (pl@kamp.de) wrote:
>> Am 06.02.2018 um 20:14 schrieb Michael Roth:
>>> Hi everyone,
>>>
>>> The following new patches are queued for QEMU stable v2.11.1:
>>>
>>>    https://github.com/mdroth/qemu/commits/stable-2.11-staging
>>>
>>> The release is planned for 2017-02-14:
>>>
>>>    https://wiki.qemu.org/Planning/2.11
>>>
>>> Please respond here or CC qemu-stable@nongnu.org on any patches you
>>> think should be included in the release.
>>>
>>> Of particular importance would be any feedback on the various QEMU
>>> patches relating to Spectre/Meltdown mitigation. The current tree has
>>> what I understand to be the QEMU components required for x86, s390,
>>> and pseries, but feedback/confirmation from the various authors would
>>> be greatly appreciated.
>> Hi,
>>
>> I also found the following patches that affect migration:
>>
>> migration: Don't leak IO channels
>> migration: Recover block devices if failure in device state
>> migration/savevm.c: set MAX_VM_CMD_PACKAGED_SIZE to 1ul << 32
>>
>> In general it seems that migration related patches are often not tagged qemu-stable.
>> David, can you check if there are patches missing?
> I'm always a bit cautious about forwarding stuff to stable; just because
> it's landed in our main branch it doesn't mean many people have tested
> it, so I'd rather wait unless it was particularly urgent.

Understood. Maybe we need a special mechanism to track such patches.
It would be good to have them in a stable release. Maybe tag them as stable-candidate
or sth. Then we can recheck their status when a stable release is going to be released.

Peter
