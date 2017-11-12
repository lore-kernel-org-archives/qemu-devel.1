Received: from eggs.gnu.org ([2001:4830:134:3::10]:52719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eDvsq-0008W6-Fi
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 12:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eDvsn-0004TM-93
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 12:17:24 -0500
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:52211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eDvsn-0004ST-5B
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 12:17:21 -0500
Received: by mail-qk0-x232.google.com with SMTP id f63so2711221qke.8
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 09:17:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171112104246.10007-1-makovick@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
Date: Sun, 12 Nov 2017 14:17:17 -0300
MIME-Version: 1.0
In-Reply-To: <20171112104246.10007-1-makovick@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] SDL2 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>, Cole Robinson <crobinso@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi Jindrich,

On 11/12/2017 07:42 AM, Jindrich Makovicka wrote:
> Hi,
> 
> here is a revised patchset:

Please increment the patchset version when you respin (this is v2).

> 
> - sdl2: Do not hide the cursor on auxilliary windows 
>     split into two
> 
> - sdl2: Only accept the hotkeys on the main window 
>     reworked, also with a more descriptive commit message
> 
> - sdl2: Do not quit the emulator when an auxilliary window is closed
>     added missing scon->hidden update
> 
> - sdl2: Fix broken display updating after the window is hidden
>     added scon->hidden update instead + the SHOWN part changed
>     the same way

You missed to add your Signed-off-by tag in the whole series.

See:
https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line

This can be added automatically using the "-s" option of the "git
format-patch" command, also the resend version using the "-v" option.

(https://wiki.qemu.org/Contribute/SubmitAPatch#Use_git_format-patch)

Regards,

Phil.
