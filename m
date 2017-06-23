Received: from eggs.gnu.org ([2001:4830:134:3::10]:50644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOPBR-0000Da-Gy
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOPBN-0005vw-Hm
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:03:37 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dOPBN-0005sv-AP
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:03:33 -0400
Received: by mail-wr0-x232.google.com with SMTP id 77so67297407wrb.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 07:03:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9P0z+pgR-JWk1KiwCRd2_iNDfQyPxx+RK465n8vtMAQw@mail.gmail.com>
References: <D6FAAABF-064D-49C0-B572-C73679F34052@gmail.com>
	<CAFEAcA9P0z+pgR-JWk1KiwCRd2_iNDfQyPxx+RK465n8vtMAQw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2017 15:03:11 +0100
Message-ID: <CAFEAcA9f-SE0s9W5tzNgrSvTEUJ=1X94NJmW5WX3HXp6SoVwbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] ui/cocoa.m: add Speed menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 21 June 2017 at 16:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 14 June 2017 at 04:17, Programmingkid <programmingkidx@gmail.com> wrote:
>> Programs running inside of QEMU can sometimes use more CPU time than is really
>> needed. To solve this problem, we just need to throttle the virtual CPU. This
>> feature will stop laptops from burning up.
>>
>> This patch adds a menu called Speed that has menu items from 100% to 1% that
>> represent the speed options. 100% is full speed and 1% is slowest.
>>
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> v3 changes:
>> Changed the item deselection loop.
>> Moved speed calculation equation to main function.
>> Replaced "%c" with "%%".
>> Changed how 100% menu item is made.
>>
>> v2 changes:
>> Fixed missing space with 'if' and 'for' structures.
>> Fixed tab damage.
>> Use loop to create menu items.
>> Changed name of menu items to use percentages.
>> Use tags to determine selected menu item.
>
>> +    // Add the rest of the Speed menu items
>> +    int p, percentage, throttle_pct;
>> +    for (p = 10; p >= 0; p--)
>> +    {
>> +        percentage = p * 10 > 1 ? p * 10 : 1; // prevent a 0% menu item
>> +
>> +        if (percentage == 100) {
>> +            [menuItem setState: NSOnState];
>> +        }
>> +        menuItem = [[[NSMenuItem alloc]
>> +                   initWithTitle: [NSString stringWithFormat: @"%d%%", percentage] action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease];
>
> Here you try to call setState: on the menuItem before
> you allocate it -- these lines should be the other way
> around. (The effect is that the 100% item isn't ticked
> on startup.)
>
>> +
>> +        /* Calculate the throttle percentage */
>> +        throttle_pct = -1 * percentage + 100;
>> +
>> +        [menuItem setTag: throttle_pct];
>> +        [menu addItem: menuItem];
>> +    }
>
> That's a very minor fix, so I'll just make it locally
> when I apply this patch to master.

...now applied to master, thanks.

-- PMM
