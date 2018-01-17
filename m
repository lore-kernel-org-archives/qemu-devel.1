Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ebrcC-00039w-LF
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ebrcB-0001vW-US
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:35:08 -0500
Received: from mail-yw0-x231.google.com ([2607:f8b0:4002:c05::231]:36122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ebrcB-0001v5-Oz
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:35:07 -0500
Received: by mail-yw0-x231.google.com with SMTP id q6so4608056ywg.3
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:35:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516203816-19374-18-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<1516203816-19374-18-git-send-email-imammedo@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 17 Jan 2018 09:35:06 -0800
Message-ID: <CAMo8Bf+V-9Q+apK-MHJgn8DtfPyQSbSH-Kr01JmUcD2Dk60jGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 17/24] xtensa: cpu: rename
 XTENSA_DEFAULT_CPU_TYPE to TARGET_DEFAULT_CPU_TYPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Wed, Jan 17, 2018 at 7:43 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> so naming would be in line with other targets and null-machine.c which
> uses the later would compile.
>
> Later it also would be used as default for *-user targets which is
> currently bogus cpu model 'any', that errors out.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/cpu.h | 2 +-
>  hw/xtensa/sim.c     | 2 +-
>  hw/xtensa/xtfpga.c  | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
