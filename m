Received: from eggs.gnu.org ([2001:4830:134:3::10]:60787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gK2n6-0001XB-JI
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gK2n5-0003pB-N7
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:57:16 -0500
References: <154131440495.28728.6130104691310518850@015909e0f939>
	<9c68f3df-4a21-4434-6217-519d5fa2230f@ilande.co.uk>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <3890f41e-a8ac-1ef3-99ae-84275b9e6c1e@tuxfamily.org>
Date: Tue, 6 Nov 2018 15:57:05 +0100
MIME-Version: 1.0
In-Reply-To: <9c68f3df-4a21-4434-6217-519d5fa2230f@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/10] hw/m68k: add Apple Machintosh
 Quadra 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, no-reply@patchew.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net, laurent@vivier.eu

On 2018-11-04 14:41, Mark Cave-Ayland wrote:
> On 04/11/2018 06:53, no-reply@patchew.org wrote:
> 
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
>>
>> Type: series
>> Message-id: 20181102152257.20637-1-mark.cave-ayland@ilande.co.uk
>> Subject: [Qemu-devel] [PATCH v6 00/10] hw/m68k: add Apple Machintosh Quadra 800 machine
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>>
>> BASE=base
>> n=1
>> total=$(git log --oneline $BASE.. | wc -l)
>> failed=0
>>
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>> git config --local diff.algorithm histogram
>>
>> commits="$(git log --format=%H --reverse $BASE..)"
>> for c in $commits; do
>>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>>         failed=1
>>         echo
>>     fi
>>     n=$((n+1))
>> done
>>
>> exit $failed
>> === TEST SCRIPT END ===
>>
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> Switched to a new branch 'test'
>> 9245542a6d hw/m68k: define Macintosh Quadra 800
>> 4b2499b92a dp8393x: manage big endian bus
>> 9a13b06b9f hw/m68k: add a dummy SWIM floppy controller
>> bdf5c3725c hw/m68k: add Nubus support for macfb video card
>> 6feff81d33 hw/m68k: add Nubus support
>> b24a39f653 esp: add pseudo-DMA as used by Macintosh
>> 970394cb59 hw/m68k: add macfb video card
>> 30013c1b4b escc: introduce a selector for the register bit
>> 3274bd6559 hw/m68k: implement ADB bus support for via
>> b78fd7f12a hw/m68k: add via support
>>
>> === OUTPUT BEGIN ===
>> Checking PATCH 1/10: hw/m68k: add via support...
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>> #26: 
>> new file mode 100644
>>
>> ERROR: space prohibited after that '&&' (ctx:WxW)
>> #348: FILE: hw/misc/mac_via.c:318:
>> +        if (!(v1s->last_b & VIA1B_vRTCClk) && (s->b & VIA1B_vRTCClk)) {
>>                                             ^
> 
> False positive from checkpatch?

Looks like a false positive, indeed.

 Thomas
