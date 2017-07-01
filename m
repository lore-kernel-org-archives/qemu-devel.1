Received: from eggs.gnu.org ([2001:4830:134:3::10]:43286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRRBu-0001UR-G2
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 18:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRRBt-0002lp-O9
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 18:48:38 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865292643.17063.14495945233139782748.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8738c294-8c73-492e-f574-5d1d88d8cb38@twiddle.net>
Date: Sat, 1 Jul 2017 15:48:28 -0700
MIME-Version: 1.0
In-Reply-To: <149865292643.17063.14495945233139782748.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 03/29] target: [tcg] Use a generic enum
 for DISAS_ values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 05:28 AM, Lluís Vilanova wrote:
> Used later. An enum makes expected values explicit and bounds the value space of
> switches.
> 
> Signed-off-by: Lluís Vilanova<vilanova@ac.upc.edu>
> ---
>   include/exec/exec-all.h       |    6 ------
>   include/exec/translator.h     |   38 ++++++++++++++++++++++++++++++++++++++
>   target/arm/translate.h        |   26 ++++++++++++++++----------
>   target/cris/translate.c       |    7 ++++++-
>   target/i386/translate.c       |    4 ++++
>   target/lm32/translate.c       |    6 ++++++
>   target/m68k/translate.c       |    7 ++++++-
>   target/microblaze/translate.c |    6 ++++++
>   target/nios2/translate.c      |    6 ++++++
>   target/openrisc/translate.c   |    6 ++++++
>   target/s390x/translate.c      |    3 ++-
>   target/unicore32/translate.c  |    7 ++++++-
>   target/xtensa/translate.c     |    4 ++++
>   13 files changed, 106 insertions(+), 20 deletions(-)
>   create mode 100644 include/exec/translator.h

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
