Received: from eggs.gnu.org ([2001:4830:134:3::10]:57171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dLGp1-0004Ts-1n
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 18:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dLGp0-0003bO-5c
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 18:31:31 -0400
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727923488.28532.12388479748363447374.stgit@frigg.lan>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <65d56373-029a-14a0-8058-04659946cee7@vivier.eu>
Date: Thu, 15 Jun 2017 00:30:38 +0200
MIME-Version: 1.0
In-Reply-To: <149727923488.28532.12388479748363447374.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 1/6] Pass generic CPUState to
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Stafford Horne <shorne@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Walle <michael@walle.cc>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Le 12/06/2017 à 16:53, Lluís Vilanova a écrit :
> Needed to implement a target-agnostic gen_intermediate_code() in the
> future.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  include/exec/exec-all.h       |    2 +-
>  target/alpha/translate.c      |   11 +++++------
>  target/arm/translate.c        |   20 ++++++++++----------
>  target/cris/translate.c       |   17 ++++++++---------
>  target/i386/translate.c       |   13 ++++++-------
>  target/lm32/translate.c       |   22 +++++++++++-----------
>  target/m68k/translate.c       |   15 +++++++--------
>  target/microblaze/translate.c |   22 +++++++++++-----------
>  target/mips/translate.c       |   15 +++++++--------
>  target/moxie/translate.c      |   14 +++++++-------
>  target/openrisc/translate.c   |   19 ++++++++++---------
>  target/ppc/translate.c        |   15 +++++++--------
>  target/s390x/translate.c      |   13 ++++++-------
>  target/sh4/translate.c        |   15 +++++++--------
>  target/sparc/translate.c      |   11 +++++------
>  target/tilegx/translate.c     |    7 +++----
>  target/tricore/translate.c    |    9 ++++-----
>  target/unicore32/translate.c  |   17 ++++++++---------
>  target/xtensa/translate.c     |   13 ++++++-------
>  translate-all.c               |    2 +-
>  20 files changed, 130 insertions(+), 142 deletions(-)

for m68k part:

Acked-by: Laurent Vivier <laurent@vivier.eu>
