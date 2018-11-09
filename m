Received: from eggs.gnu.org ([2001:4830:134:3::10]:41096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gL654-00007N-Jy
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gL650-0006Ic-HU
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:40:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gL650-0006Fv-5J
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 07:40:06 -0500
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<20181109111731.vxdmqmkorblcnntx@sirius.home.kraxel.org>
	<20181109112953.w4wtltwxpl4z2lpj@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1724064a-acdc-5571-4f54-f0ac021027d0@redhat.com>
Date: Fri, 9 Nov 2018 13:39:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181109112953.w4wtltwxpl4z2lpj@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2018-11-09 12:29, Gerd Hoffmann wrote:
> On Fri, Nov 09, 2018 at 12:17:31PM +0100, Gerd Hoffmann wrote:
>>   Hi,
>>
>>> I am also suspicious about hw/bt/ but don't know enough
>>> about that subsystem to say if it could benefit from
>>> using QOM objects more.
>>
>> I'm wondering whenever anyone would even notice if we just rm -rf hw/bt
>>
>> Looking through the changelog for the last five years (after hw/ split)
>> the only thing I see is fixing warnings from compiler or coverity,
>> adapting to changes in other systems (chardev for example) and treewide
>> changes.  Not a *single* patch specific to bluetooth ...
> 
> Tried this after studying docs:
> 
>   qemu -usb -device usb-bt-dongle -bt hci,vlan=0 -bt device:keyboard
> 
> Segfaults right anway on first keypress.
> I guess that qualifies as "broken and obviously unused".

Thanks for checking! I guess that means we could even get rid of it
without deprecating it first if it is broken already for more than two
releases...?

 Thomas
