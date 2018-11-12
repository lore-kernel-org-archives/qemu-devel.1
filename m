Received: from eggs.gnu.org ([2001:4830:134:3::10]:44564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMAY4-0007zs-O5
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMAXz-0005wm-Kk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:38:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMAXx-0005tD-Km
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:38:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id u5-v6so3669542wrn.9
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 03:38:21 -0800 (PST)
References: <20181109142032.1628-1-kraxel@redhat.com>
	<9b2c9e91-8904-1200-f491-4ee1d6ed42e3@amsat.org>
	<20181112091205.brrcxxzzvfthyqhk@sirius.home.kraxel.org>
	<c21b1cba-3dee-d7d8-24b3-8d04fb0a9265@redhat.com>
	<20181112112833.hcbgtwjkb3p2qpgx@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <475525e6-3eaa-b53f-f987-7f63a5383b3a@redhat.com>
Date: Mon, 12 Nov 2018 12:38:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181112112833.hcbgtwjkb3p2qpgx@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] pulseaudio: process audio data in
 smaller chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Martin Schrodt <martin@schrodt.org>, Max Ehrlich <maxehr@umiacs.umd.edu>, qemu-devel@nongnu.org

On 12/11/18 12:28, Gerd Hoffmann wrote:
> On Mon, Nov 12, 2018 at 10:51:36AM +0100, Philippe Mathieu-Daudé wrote:
>> On 12/11/18 10:12, Gerd Hoffmann wrote:
>>> On Sat, Nov 10, 2018 at 08:36:39PM +0100, Philippe Mathieu-Daudé wrote:
>>>> Hi Gerd,
>>>>
>>>> On 11/9/18 3:20 PM, Gerd Hoffmann wrote:
>>>>> The rate of pulseaudio absorbing the audio stream is used to control the
>>>>> the rate of the guests audio stream.  When the emulated hardware uses
>>>>> small chunks (like intel-hda does) we need small chunks on the audio
>>>>> backend side too, otherwise that feedback loop doesn't work very well.
>>>>
>>>> Shouldn't this be user-configurable?
>>>
>>> Why?
>>
>> When emulated hardware is not intel-hda?
> 
> Ok, maybe it is not required then, but it also doesn't hurt.
> 
> Also, when making chunk size configurable we should not leave that
> to the confused user but pick a working value automatically, probably
> depending on the emulated device.  I can't see what the benefit would
> be though, especially given that intel-hda is probably used in most
> configurations these days.

For nowadays uses I agree with your patch.
For retrocomputing and other weird stuffs, if we don't have this 
user-configurable, I think we need a comment in the code about this 
change, else it might be hard for other people to figure this change in 
the git history.

With a such comment:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.
