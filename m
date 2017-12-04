Received: from eggs.gnu.org ([2001:4830:134:3::10]:58206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLsnh-00011i-Sq
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLsne-0004sV-2i
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:36:57 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:46944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLsnd-0004rj-Sz
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:36:54 -0500
Received: by mail-oi0-x234.google.com with SMTP id t81so11938719oih.13
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 07:36:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171204152645.fy5grsjjn5hedvko@var.youpi.perso.aquilenet.fr>
References: <20171204151705.26028-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA9CYSCJtGjRPQonyA8jvMZ6VBaWbGtrnJ7y6mJEbERMHg@mail.gmail.com>
	<20171204152645.fy5grsjjn5hedvko@var.youpi.perso.aquilenet.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 15:36:32 +0000
Message-ID: <CAFEAcA_g9_qVh+7qaZSenjnCxe53jYkVRGTJF47-oN1wukGS3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] baum braille device update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4 December 2017 at 15:26, Samuel Thibault <samuel.thibault@gnu.org> wrot=
e:
> Hello,
>
> Peter Maydell, on lun. 04 d=C3=A9c. 2017 15:21:48 +0000, wrote:
>> On 4 December 2017 at 15:17, Samuel Thibault
>> <samuel.thibault@ens-lyon.org> wrote:
>> > ----------------------------------------------------------------
>> > Samuel Thibault (1):
>> >       baum: Truncate braille device size to 84x1
>>
>> Hi. Is this pull request intended for 2.11?
>
> If possible, yes.
>
>> We're currently in freeze for that and only taking "absolutely release
>> critical" bug fixes...
>
> Ok, as you wish.
>
> It's a relatively corner case: a friend of mine does have a 88-cell
> braille display, and can not use it with guests by running qemu
> -usbdevice braille due to this bug.

Mmm. Looking at the code for baum.c for 2.10, this isn't a
regression from 2.10 or a security issue, which is what it
would need to be for us to want to put this in at this point.

Also, looking in my mail archives I couldn't find where
this patch was initially posted on the list for review. Our
process is that all patches have to be posted for review first,
they can't just go straight into a pull request.

thanks
-- PMM
