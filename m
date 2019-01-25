Received: from eggs.gnu.org ([209.51.188.92]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gmuVJ-0004Le-Kx
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 00:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gmuSZ-0002j9-Jc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 00:55:24 -0500
References: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
	<e18d32e6-4c6f-1d42-7e90-ef9d84721524@tuxfamily.org>
	<3d217d08-56c9-4bab-f897-9ebe67910168@vivier.eu>
	<e400f594-288d-38bb-2b15-4d7d50bfcf76@ilande.co.uk>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <536596dd-1fc1-4f86-0e6c-2cb7d1dc5b60@tuxfamily.org>
Date: Fri, 25 Jan 2019 06:55:19 +0100
MIME-Version: 1.0
In-Reply-To: <e400f594-288d-38bb-2b15-4d7d50bfcf76@ilande.co.uk>
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net

On 2019-01-24 18:37, Mark Cave-Ayland wrote:
> On 24/01/2019 17:15, Laurent Vivier wrote:
> 
>> On 24/01/2019 18:02, Thomas Huth wrote:
>>> On 2018-11-02 16:22, Mark Cave-Ayland wrote:
>>>> (MCA: here's the latest version of the q800 patchset. I've hope that I've
>>>> addressed most of the comments, plus this will now boot into the Debian
>>>> installer correctly when applied to git master.
>>>
>>> Any update on this series? Why did it get stalled again?
>>>
>>
>> I was thinking about this today.
>>
>> Mark, perhaps you can send a rebased version of the series?
>>
>> I think we need reviews for "esp: add pseudo-DMA as used by Macintosh".

I just gave it a quick review (see my separate mail) ... some few nits,
but all in all, it looks quite good to me.

> 1) Do we mind some of the more verbose comments that were taken from the Linux
> headers in some of the files? (I can also see that updates to the comment checking in
> checkpatch.pl now cause the series to fail with style issues, so these will need to
> be touched up regardless)

I personally would clean them up, but that's just a matter of taste. I
think that's nothing that should hold up this series. It can also be
done with a patch on top afterwards.

> 2) Do we need to add migration support for the ESP pseudo-DMA?

That would be cleaner, of course. But since the q800 likely can't be
migrated anyway, it's not that important. So if it is too much of a
hassle to add it, maybe simply add a comment next to the vmstate section
saying "/* TODO: Add migration support for the pdma data */" ?

 Thomas
