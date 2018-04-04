Received: from eggs.gnu.org ([2001:4830:134:3::10]:40957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3iim-0001Zg-IU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3iih-0005Gr-Uf
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:45:04 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3iih-0005GP-Mw
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:44:59 -0400
Received: by mail-wm0-x242.google.com with SMTP id i3so18905986wmf.3
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 06:44:59 -0700 (PDT)
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1519324303-5674-4-git-send-email-aleksandar.markovic@rt-rk.com>
	<87tvsrclsh.fsf@linaro.org>
	<6b04fe74-2a84-63d8-5519-fd2fdfe3f4a3@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6b04fe74-2a84-63d8-5519-fd2fdfe3f4a3@redhat.com>
Date: Wed, 04 Apr 2018 14:44:57 +0100
Message-ID: <87bmezcch2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] hw/mips_int: hold BQL for all
 interrupt requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/04/2018 12:23, Alex Benn=C3=A9e wrote:
>>
>>> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>>>
>>> Make sure BQL is held for all interrupt requests.
>>>
>>> For MTTCG-enabled configurations, handling soft and hard interrupts
>>> between vCPUs must be properly locked. By acquiring BQL, make sure
>>> all paths triggering an IRQ are synchronized.
>>>
>>> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
>>> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
>
> Is this actually necessary?  What paths are not taking the lock?

Helpers functions have to manually take the lock. AIUI from this patch
the if (locked) dance allows a single function to be used which may
trigger an IRQ from both helpers (no automatic locking) and hw emulation
(locked by default).

>
> Thanks,
>
> Paolo


--
Alex Benn=C3=A9e
