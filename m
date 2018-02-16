Received: from eggs.gnu.org ([2001:4830:134:3::10]:55003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emp6f-0002ND-CQ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emp6b-0003wu-9t
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:07:53 -0500
References: <cover.1518730026.git.balaton@eik.bme.hu>
	<dffa45c9-48a6-ef85-3b28-d8ce1daf72e4@redhat.com>
	<alpine.BSF.2.21.1802161145230.98686@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5c7c64f7-90bd-7ddb-59f6-e3d7f4f8b21d@redhat.com>
Date: Sat, 17 Feb 2018 00:07:34 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1802161145230.98686@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 16.02.2018 11:55, BALATON Zoltan wrote:
> On Fri, 16 Feb 2018, Thomas Huth wrote:
>> On 15.02.2018 22:27, BALATON Zoltan wrote:
>>> Remaining patches for Sam460ex emulation. The original cover letter
>>> with more details is here:
>>>
>>> http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00112.html
>>>
>>> We'll need to also add binaries for firmware (customised u-boot
>>> version) and dtb but I'm not sure how to submit those.
>>
>> For the dtb, I think you could simply provide a patch that adds the dts
>> file to the pc-bios directory and another one that adds the dtb. Just
>> like it is already done with pc-bios/bamboo.dts / pc-bios/bamboo.dtb.
> 
> OK thanks, I'll do that. Does it have to be two separate patches?

I don't think so, I just thought that would be cleaner ... but one patch
should be fine, too, I guess. David?

>> For u-boot, can you use the same upstream level as e500 ? I.e. check
>> whether "git submodule status roms/u-boot" is fine for you? If that's
>> ok, just do a "git submodule update roms/u-boot" and build uboot from
>> that directory - you then can submit a binary patch with that file for
>> pc-bios, too.
>>
>> In case you need another u-boot version, I think you've got to update
>> the submodule to the newer upstream version first, and then also rebuild
>> the e500 binary... Cumbersome, but that's necessary since we've got to
>> ship the u-boot sources in the QEMU release tarballs, too, to be
>> compliant with the GPL.
> 
> Unfortunately we can't use the same u-boot as e500 because this board
> uses a forked and patched version which is not in upstream u-boot and
> upstream u-boot has even dropped support for this CPU in latest version
> so we actually need an older version (with patches) and not a newer one.

That's very unfortunate ... any chance that you could try to get that
CPU activated in upstream u-boot again and get the patches included there?

> Therefore, it needs to be a binary built from a separate source so I
> think a new submodule will need to be added for this. How to do that?
> Where to host this git repo? Should I put it on github and refer to that
> as an external repo or should it be hosted in qemu repo somehow?

No clue ... adding Stefan and Jeff to CC:, maybe they can recommend
something here.

 Thomas
