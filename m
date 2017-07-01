Received: from eggs.gnu.org ([2001:4830:134:3::10]:42571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRR85-0008PH-SF
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 18:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRR84-0000vO-Le
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 18:44:41 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865244195.17063.11938084353514091141.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <84fef40a-7e4c-25b5-583f-fe151de06f51@twiddle.net>
Date: Sat, 1 Jul 2017 15:44:29 -0700
MIME-Version: 1.0
In-Reply-To: <149865244195.17063.11938084353514091141.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 01/29] Pass generic CPUState to
 gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>, Alexander Graf <agraf@suse.de>, "Emilio G. Cota" <cota@braap.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Stafford Horne <shorne@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 06/28/2017 05:20 AM, Lluís Vilanova wrote:
> -void gen_intermediate_code(CPUArchState *env, struct TranslationBlock *tb);
> +void gen_intermediate_code(CPUState *env, struct TranslationBlock *tb);

Ought to change the argument name too.


r~
