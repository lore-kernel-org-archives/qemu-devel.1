Received: from eggs.gnu.org ([2001:4830:134:3::10]:44448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gM8yz-00084Z-Pc
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gM8si-0005a7-7J
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:51:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gM8sg-0005ZB-99
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:51:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id i73-v6so2463138wmd.5
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 01:51:39 -0800 (PST)
References: <20181109142032.1628-1-kraxel@redhat.com>
	<9b2c9e91-8904-1200-f491-4ee1d6ed42e3@amsat.org>
	<20181112091205.brrcxxzzvfthyqhk@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c21b1cba-3dee-d7d8-24b3-8d04fb0a9265@redhat.com>
Date: Mon, 12 Nov 2018 10:51:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181112091205.brrcxxzzvfthyqhk@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Martin Schrodt <martin@schrodt.org>, Max Ehrlich <maxehr@umiacs.umd.edu>, qemu-devel@nongnu.org

On 12/11/18 10:12, Gerd Hoffmann wrote:
> On Sat, Nov 10, 2018 at 08:36:39PM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Gerd,
>>
>> On 11/9/18 3:20 PM, Gerd Hoffmann wrote:
>>> The rate of pulseaudio absorbing the audio stream is used to control the
>>> the rate of the guests audio stream.  When the emulated hardware uses
>>> small chunks (like intel-hda does) we need small chunks on the audio
>>> backend side too, otherwise that feedback loop doesn't work very well.
>>
>> Shouldn't this be user-configurable?
> 
> Why?

When emulated hardware is not intel-hda?
