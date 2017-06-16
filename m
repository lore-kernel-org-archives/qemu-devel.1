Received: from eggs.gnu.org ([2001:4830:134:3::10]:40921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLmg4-0004K2-3k
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLmfz-0003fj-5I
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:32:24 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLmfy-0003fM-Us
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:32:19 -0400
Received: by mail-wm0-f46.google.com with SMTP id x70so19353407wme.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 01:32:18 -0700 (PDT)
References: <1497567879-13734-1-git-send-email-cota@braap.org>
	<1497567879-13734-2-git-send-email-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df6ef6c7-6bb5-a509-5e8e-66757598b11f@redhat.com>
Date: Fri, 16 Jun 2017 10:32:14 +0200
MIME-Version: 1.0
In-Reply-To: <1497567879-13734-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
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
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>



On 16/06/2017 01:04, Emilio G. Cota wrote:
>              va = dest_gpr(ctx, ra);
>              if (ctx->tb->cflags & CF_USE_ICOUNT) {
> -                gen_io_start();
> +                gen_io_start(cpu_env);
>                  gen_helper_load_pcc(va, cpu_env);
> -                gen_io_end();
> +                gen_io_start(cpu_env);

Careful, looks like a cut-and-paste issue here.

Paolo

>                  ret = EXIT_PC_STALE;
