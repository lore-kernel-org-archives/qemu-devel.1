Received: from eggs.gnu.org ([209.51.188.92]:58666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h23dj-0002IA-2o
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h23de-0007ko-Mw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:45:29 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1h23dc-0007fo-NU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:45:26 -0500
Received: by mail-wm1-x344.google.com with SMTP id g20so10878177wmh.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 16:45:24 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<cf14255c576fd361c6cdf941f8c637e613f6cb68.1550698466.git.DirtY.iCE.hu@gmail.com>
	<63250655-a4a3-ef36-5882-65188093ff57@gmail.com>
	<20190307155643.cuypwvu7znhqng5y@sirius.home.kraxel.org>
Message-ID: <80f2cc3a-2695-cd41-b379-74751c702771@gmail.com>
Date: Fri, 8 Mar 2019 01:45:20 +0100
MIME-Version: 1.0
In-Reply-To: <20190307155643.cuypwvu7znhqng5y@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 04/14] audio: -audiodev command line
 option basic implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 2019-03-07 16:56, Gerd Hoffmann wrote:
> On Tue, Feb 26, 2019 at 02:39:38AM +0100, Zoltán Kővágó wrote:
>> On 2019-02-20 22:37, Kővágó, Zoltán wrote:
>> [...]
>>> diff --git a/audio/audio.c b/audio/audio.c
>>> index ce8e6ea8c2..8ad8cbe559 100644
>>> --- a/audio/audio.c
>>> +++ b/audio/audio.c
>> [...]
>>> @@ -2129,3 +1866,170 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
>>>          }
>>>      }
>>>  }
>>> +
>>> +void audio_create_pdos(Audiodev *dev)
>>> +{
>>> +    switch (dev->driver) {
>>> +#define CASE(DRIVER, driver, pdo_name)                              \
>>> +    case AUDIODEV_DRIVER_##DRIVER:                                  \
>>> +        dev->u.driver.in = g_malloc0(                               \
>>> +            sizeof(Audiodev##pdo_name##PerDirectionOptions));       \
>> This should check has_in before overwriting. It'll work correctly when
>> called from audio_legacy.c, but when using -audiodev it will overwrite
>> the options passed by user (and leak memory) when called from
>> audio_validate_opts. I'll fix it in the next update.
> 
> Ping.  4.0 freeze is next tuesday.  Any chance for a v6 early enough
> that we have a chance to get the first chunk into 4.0?  Monday latest,
> preferably earlier ...

I'll try to do something this weekend, but I can't promise anything. I
still haven't got to reading through Markus' comments...

Regards,
Zoltan
