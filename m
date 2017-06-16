Received: from eggs.gnu.org ([2001:4830:134:3::10]:45077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLhOw-0000DH-1s
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 22:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLhOv-0002yo-97
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 22:54:22 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497567879-13734-1-git-send-email-cota@braap.org>
	<1497567879-13734-2-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8a6445d8-ce0f-55d9-b250-71ccb917baaa@twiddle.net>
Date: Thu, 15 Jun 2017 19:54:07 -0700
MIME-Version: 1.0
In-Reply-To: <1497567879-13734-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] gen-icount: pass cpu_env as a
 parameter to gen_* inlines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>

On 06/15/2017 04:04 PM, Emilio G. Cota wrote:
> We are relying on cpu_env being defined as a global, yet most
> targets (i.e. all but arm/a64) have it defined as a local variable.
> Luckily all of them use the same "cpu_env" name, but really
> compilation shouldn't break if the name of that local variable
> changed.
> 
> This patch fixes it by explicitly passing cpu_env to the gen_*
> inlines that need it. This change also helps paving the way for
> the upcoming "translation loop common to all targets" work.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---

Nack.  If you want to make a change, this should be tcg_ctx.tcg_env.


r~
