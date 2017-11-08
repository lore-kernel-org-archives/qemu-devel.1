Received: from eggs.gnu.org ([2001:4830:134:3::10]:33360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCSGH-0007f4-Im
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCSGG-0007p5-GE
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:27:29 -0500
MIME-Version: 1.0
In-Reply-To: <308c6070-e9b8-f40d-2389-96497dbe238d@redhat.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<ad7c1de551fbc497743e4dd60335a75cb5365a15.1508390588.git.alistair.francis@xilinx.com>
	<87efpmccvu.fsf@secure.laptop> <87bmke4cu9.fsf@dusky.pond.sub.org>
	<51d103e9-8d6b-8c83-dd69-effe997d4813@redhat.com>
	<87shdptdf0.fsf@dusky.pond.sub.org>
	<CAKmqyKOhnGrbZ6tnaXgBNzdJ=LdnD9NWuWVV-LHmM3zea8OBvA@mail.gmail.com>
	<308c6070-e9b8-f40d-2389-96497dbe238d@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 8 Nov 2017 07:26:54 -0800
Message-ID: <CAKmqyKNEA41=HaDJ5A8X=UXBvWzzviG7Mv63fa2Zr0tPcxrqkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 01/46] Replace all occurances of
 __FUNCTION__ with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Alistair Francis <alistair.francis@xilinx.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Wed, Nov 8, 2017 at 7:00 AM, Eric Blake <eblake@redhat.com> wrote:
> On 11/08/2017 08:51 AM, Alistair Francis wrote:
>
>>>>> Let me rephrase the question: do we really support compilers that don't
>>>>> understand __func__?  The presence of numerous unconditional uses of
>>>>> __func__ in the tree means the answer is no.  Let's replace AUDIO_FUNC
>>>>> by plain __func__.
>>>>
>>>> Answered elsewhere in patch 3/46 (where we DO replace AUDIO_FUNC by
>>>> __func__).
>>>
>>> I see.
>>>
>>> Put 03/46 first, so we don't have to mess with AUDIO_FUNC twice?
>>
>> I would really like to avoid that, as the conflicts will be a bit of a
>> mess. The way I see it there will be a lot of churn no matter what,
>> so we don't gain much by swapping the order around.
>>
>> I have a new series ready to send today, so I'm going to send that
>> through as I would like at least some of these patches to make it in
>> 2.11. After that if you think strongly the order should be changed I
>> can change it in the next version.
>
> I think the reorder is not that hard.  Put 3/46 first (changing
> AUDIO_FUNC to __func__), and then 1/46 doesn't have to touch any of the
> files that used to use AUDIO_FUNC, because there is no intermediate
> state using __FUNCTION__.
>
> If I'm reading it correctly, the rebase conflict is limited to a slight
> rewording of the commit message for 3/46, and one line in 1/46 to the
> definition of AUDIO_FUNC (that will no longer be present).

That's true, it didn't end up being that hard. I'm launching my tests
now, so I should be able to send the series out later today.

Hopefully some of this can make it in 2.11 :)

Thanks,
Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
