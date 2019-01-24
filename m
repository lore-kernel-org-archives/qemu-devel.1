Received: from eggs.gnu.org ([209.51.188.92]:58428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmfFX-0005hn-4N
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmfCx-0003na-38
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:38:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmfCw-0003hp-Qf
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:38:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so6506293wrt.4
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:38:10 -0800 (PST)
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-4-philmd@redhat.com>
	<CAFEAcA_TStmpdC0UH+_s5aqheh81_gwNsW07Nw0f0zbEcxXQZg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4776327f-fa7b-c562-9414-0b55b463df29@redhat.com>
Date: Thu, 24 Jan 2019 14:38:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TStmpdC0UH+_s5aqheh81_gwNsW07Nw0f0zbEcxXQZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] configure: Let SDL support be
 optional on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>



On 1/24/19 12:44 PM, Peter Maydell wrote:
> On Thu, 24 Jan 2019 at 01:16, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> --- a/configure
>> +++ b/configure
>> @@ -3379,7 +3379,8 @@ for drv in $audio_drv_list; do
>>
>>      sdl)
>>      if test "$sdl" = "no"; then
>> -        error_exit "sdl not found or disabled, can not use sdl audio driver"
>> +        echo "WARN: sdl not found or disabled, can not use sdl audio driver"
>> +        audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/sdl *//g')
> 
> "WARNING:" is what configure mostly uses (though sometimes
> also "warning:" and in one case "WARN:")...

Indeed, which makes me wonder why I used "WARN".

I'll fix, thanks.

Phil.
