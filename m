Received: from eggs.gnu.org ([2001:4830:134:3::10]:54518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEFln-0004Si-S7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEFll-0007Qb-JK
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:31:27 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:55091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEFll-0007QF-B9
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:31:25 -0500
Received: by mail-wr0-x22a.google.com with SMTP id l22so14576715wrc.11
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 06:31:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
References: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:31:03 +0000
Message-ID: <CAFEAcA9q11x+LcB6ehJc-GVv_sDbY6b8RPFKx4WVqcQDbPAEMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Command-line option to change ungrab key(s)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 13 November 2017 at 14:29, Programmingkid <programmingkidx@gmail.com> wrote:
> Would you accept a patch that allows the user to change the mouse ungrab key(s) in QEMU?
>
> It would look something like this:
>
> -ungrab <key>
>
> or
>
> -ungrab <key>,<key>,...
>
> If the user wanted the F19 key to be the ungrab key, this is what would be sent to QEMU:
>
> -ungrab F19
>
> If the user wanted F16 and F17 held down to ungrab the mouse, this is what would be sent to QEMU:
>
> -ungrab F16,F17
>
>
> Would this feature be something you would consider adding to QEMU?

Gerd is the graphics/UI overall maintainer, that kind of thing would be
his decision.

thanks
-- PMM
