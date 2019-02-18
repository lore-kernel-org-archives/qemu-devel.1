Received: from eggs.gnu.org ([209.51.188.92]:60573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvhXo-0003MV-QG
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvhXm-0005nB-QT
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:57:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gvhXm-0005aI-JN
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:57:06 -0500
References: <20190215122808.22301-1-alex.bennee@linaro.org>
	<60e020d0-ad5d-6b86-e492-1d3c91c48a13@redhat.com>
	<87lg2hujld.fsf@dusky.pond.sub.org>
	<47ebf089-1d7a-349d-1d67-deb46f48cd3f@redhat.com>
	<87tvh4t1v7.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <36adf8c8-009e-dc91-475b-c3cbf34fbd21@redhat.com>
Date: Mon, 18 Feb 2019 12:56:37 +0100
MIME-Version: 1.0
In-Reply-To: <87tvh4t1v7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/block: report when pflash backing
 file isn't aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: stappers@stappers.nl, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 02/16/19 12:21, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
>> On 02/15/19 17:01, Markus Armbruster wrote:

>>> Using whatever size the image has is sloppy modelling.
>>
>> Maybe so, but it's also very convenient, and also quite important, right
>> now (given the multiple firmware image sizes used in the wild).
>>
>>> A machine may come in minor variations that aren't worth their own
>>> machine type.  One such variation could be a different flash chip size.
>>> Using the image size to select one from the set of fixed sizes is
>>> tolerable.
>>
>> The problem is that this requires coordination between QEMU and firmware
>> development.
>>
>> (Well, I have to agree that the present patch is *already* that kind of
>> coordination;
> 
> We've always had that kind of coordination.  It just happens to be less
> tight in the case of PC firmware in flash than in most other cases.
> 
>>               my point is that when I introduced the 4MB build for OVMF,
>> I didn't have to touch QEMU. In retrospect, I'm extremely thankful for
>> that, as the introduction of the 4MB build was difficult in itself.)
> 
> You don't actually need "flash size is whatever the image size is" for
> that.  "Use image size to select one from the set of fixed sizes" should
> suffice.
> 
> Actually, the PC machines currently comply, just with a rather large
> set: { n * 4KiB | 1 <= n <= 2048 }.
> 
> I very much doubt PC firmware sizes other than powers of two between
> 64KiB and 8MiB matter.  Have you ever seen real flash chips with sizes
> like 64140KiB?

Honestly, I wouldn't know. I haven't seen any physical flash chip (as
in, directing my gaze at it). I also don't know what the usual flash
chip sizes are on physical boards (e.g. I have no clue what my laptop uses).

I think a jump from 4MB to 8MB would be too large. It gives too much of
sudden convenience to firmware developers. I do agree "7MB" looks quite
lame. I really wonder about the flash sizes used on physical UEFI boards.

Thanks,
Laszlo
