Received: from eggs.gnu.org ([2001:4830:134:3::10]:57727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yF9-0002rw-MO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yF8-0002Ke-V5
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:02:51 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
	<1493106839-10438-6-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e96f6e11-212d-45df-b237-8ff3c95313ca@twiddle.net>
Date: Tue, 25 Apr 2017 13:02:43 +0200
MIME-Version: 1.0
In-Reply-To: <1493106839-10438-6-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/13] tcg-runtime: add lookup_tb_ptr
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 04/25/2017 09:53 AM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   tcg-runtime.c     | 7 +++++++
>   tcg/tcg-runtime.h | 2 ++
>   tcg/tcg.h         | 1 +
>   3 files changed, 10 insertions(+)

Modulo what I mentioned earlier about maybe directly inlining tb_from_jmp_cache,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
