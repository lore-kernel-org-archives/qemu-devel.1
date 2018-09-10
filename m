Received: from eggs.gnu.org ([2001:4830:134:3::10]:40273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fzFkf-0007PM-LI
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fzFkc-0002rw-AP
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:32:49 -0400
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
	<20180907073155.26200-2-david@gibson.dropbear.id.au>
	<2ae5af64-c452-9d7d-ea81-6d9035a30697@redhat.com>
	<20180910042551.GB24181@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a556cf98-7902-869a-fa5b-5b7c7fedbb71@redhat.com>
Date: Mon, 10 Sep 2018 08:32:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180910042551.GB24181@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 01/14] ppc: Remove deprecated ppcemb target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>
Cc: lvivier@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org

On 2018-09-10 06:25, David Gibson wrote:
> On Fri, Sep 07, 2018 at 08:39:52AM -0500, Eric Blake wrote:
>> On 09/07/2018 02:31 AM, David Gibson wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> There is no known available OS for ppc around anymore that uses page
>>> sizes below 4k, so it does not make much sense that we keep wasting
>>> our time on building and testing the ppcemb-softmmu target. It has
>>> been deprecated since two releases, and nobody complained, so let's
>>> remove this now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>
>>> +++ b/qapi/common.json
>>> @@ -146,6 +146,6 @@
>>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>>>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>>> -             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4',
>>> +             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>>>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>>>                'x86_64', 'xtensa', 'xtensaeb' ] }
>>
>> Can we also get documentation that this was deleted (probably as a followup,
>> since I'm only now noticing this in the pull request)?  See QKeyCode in
>> qapi/ui.json for an example of documenting 'altgr: dropped in 2.10'
> 
> So, it turns out Peter isn't able to process pull requests until late
> september, so I guess we can fix it inline after all.  I've now done
> so.
> 
> Since I won't be resending the pull request for a while, you can
> review the new version at:
> 
> https://github.com/dgibson/qemu/commit/9de3048e22f73824cc1920db17f7a166ef815090

Thanks, fine for me. Maybe just swap the order of the "Since: 3.0" and
the "ppcemb: dropped in 3.1" so that these entries are listed
chronologically?

 Thomas
