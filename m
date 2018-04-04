Received: from eggs.gnu.org ([2001:4830:134:3::10]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3jcA-0007JN-Ki
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3jc5-0003pg-Pg
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:42:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f3jc5-0003pN-Kg
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:42:13 -0400
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1519324303-5674-4-git-send-email-aleksandar.markovic@rt-rk.com>
	<87tvsrclsh.fsf@linaro.org>
	<6b04fe74-2a84-63d8-5519-fd2fdfe3f4a3@redhat.com>
	<87bmezcch2.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81a72879-cd24-037b-6b7f-d86ef2bdc837@redhat.com>
Date: Wed, 4 Apr 2018 16:42:07 +0200
MIME-Version: 1.0
In-Reply-To: <87bmezcch2.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>

On 04/04/2018 15:44, Alex Benn=C3=A9e wrote:
>>>> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
>>>> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
>> Is this actually necessary?  What paths are not taking the lock?
> Helpers functions have to manually take the lock. AIUI from this patch
> the if (locked) dance allows a single function to be used which may
> trigger an IRQ from both helpers (no automatic locking) and hw emulatio=
n
> (locked by default).

This makes it harder to understand which paths actually need to take the
lock, and to split the lock in the future.  We do it in some cases, but
in general defining "*_locked" or "*_unlocked" functions is easier on
the brain.

Thanks,

Paolo
