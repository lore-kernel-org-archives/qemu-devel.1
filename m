Received: from eggs.gnu.org ([2001:4830:134:3::10]:52933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3LoF-0003Ny-8g
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3LoE-0003n1-BD
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:12:39 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-3-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <472dde45-4b3e-bad7-ef64-718e089d7a68@twiddle.net>
Date: Wed, 26 Apr 2017 14:12:27 +0200
MIME-Version: 1.0
In-Reply-To: <1493187803-4510-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/10] tcg: introduce goto_ptr opcode
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

On 04/26/2017 08:23 AM, Emilio G. Cota wrote:
> +DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_END)

One more thing:

DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_END | IMPL(TCG_TARGET_HAS_goto_ptr))

You'd have noticed this if you'd have tested this particular patch, with 
--enable-debug-tcg, before applying patch 4.


r~
