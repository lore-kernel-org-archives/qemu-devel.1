Received: from eggs.gnu.org ([2001:4830:134:3::10]:36229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eo5m2-00086M-SH
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eo5ly-00016d-TJ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:07:50 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:36891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1eo5ly-000162-PK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:07:46 -0500
Received: by mail-oi0-x22d.google.com with SMTP id f186so2198858oig.4
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 03:07:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220095254.aoi6y65xbvprhg3i@sirius.home.kraxel.org>
References: <CABLmASGFPBQV8y1Omm+S53P92Dew_aWBBbDoap+c2b2PVxeLzg@mail.gmail.com>
	<ab4612a8-5c82-5abf-cbc3-d5ec47cd9498@tuxfamily.org>
	<CABLmASFG_cT768zVJwKwrOAB=xhbhvzLa_wvJ4qjRkE6GoZvrA@mail.gmail.com>
	<20180219085648.kgkeo36adbk2tp6g@sirius.home.kraxel.org>
	<CABLmASFgZaV3OgFMykpSi3Ok46+xQ+FW0GNTM+0-wgZyhh8qNw@mail.gmail.com>
	<20180219103034.zbqxtdises26loqb@sirius.home.kraxel.org>
	<CABLmASFziChKARGJ-+R0ZJr-F4rbVFZFaixC-CZ8mPF2Sfr=9w@mail.gmail.com>
	<20180220095254.aoi6y65xbvprhg3i@sirius.home.kraxel.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Tue, 20 Feb 2018 12:07:45 +0100
Message-ID: <CABLmASHC8pwNxbVhG6iUSPTfPMYaPxv2VaQArmF6Vz05vdz_-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu SDL2 bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Tue, Feb 20, 2018 at 10:52 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> Hi,
>>
>> I went on to compile dgibson's rep which includes that commit. But the
>> issue remains.
>> I normally use -usb-mouse -usb-kbd in the command line, as these work
>> for Mac OS 9.x up to 10.5. Using -usb-tablet allows the mouse to
>> travel outside the GUI and seems to circumvent the issue in OSX
>> guests, but Mac OS 9.x  guests do not work with -usb-tablet.
>
> can you try
> https://www.kraxel.org/cgit/qemu/log/?h=sirius/sdl2-hotkey-keyup
> ?
>
> cheers,
>   Gerd
>

Hi Gerd,

Perfect! That patch fixes the issue.

Thanks,
Howard
