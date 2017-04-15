Received: from eggs.gnu.org ([2001:4830:134:3::10]:35931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czLoT-0007fM-5y
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 07:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czLoS-00040L-Es
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 07:24:21 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
	<1491959850-30756-4-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <44eff6ee-1059-8a77-aa91-ca5d9fd332de@twiddle.net>
Date: Sat, 15 Apr 2017 04:24:07 -0700
MIME-Version: 1.0
In-Reply-To: <1491959850-30756-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] target/arm: optimize cross-page
 block chaining in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, Claudio Fontana <claudio.fontana@huawei.com>, Alexander Graf <agraf@suse.de>, alex.bennee@linaro.org, qemu-arm@nongnu.org, Pranith Kumar <bobby.prani+qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 04/11/2017 06:17 PM, Emilio G. Cota wrote:
> +uint32_t HELPER(cross_page_check)(CPUARMState *env, target_ulong vaddr)
> +{
> +    return !!tb_from_jmp_cache(env, vaddr);
> +}

FWIW, helpers like this that are intended to be used by more than one target 
should go into tcg-runtime.[ch].

That said, I don't think this is the proper abstraction.  More later...


r~
