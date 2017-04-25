Received: from eggs.gnu.org ([2001:4830:134:3::10]:34904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yVt-0002WH-Td
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yVt-0004H0-50
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:20:09 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
	<1493106839-10438-14-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <867b6d02-2c3e-9537-7ef9-705ce682d319@twiddle.net>
Date: Tue, 25 Apr 2017 13:19:58 +0200
MIME-Version: 1.0
In-Reply-To: <1493106839-10438-14-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/13] tb-hash: improve tb_jmp_cache
 hash function in user mode
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
> Optimizations to cross-page chaining and indirect branches make
> performance more sensitive to the hit rate of tb_jmp_cache.
> The constraint of reserving some bits for the page number
> lowers the achievable quality of the hashing function.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
