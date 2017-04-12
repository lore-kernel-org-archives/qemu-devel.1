Received: from eggs.gnu.org ([2001:4830:134:3::10]:34698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cy9FG-0006Mr-2U
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cy9FF-0002on-Dg
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:47:02 -0400
References: <1491959850-30756-1-git-send-email-cota@braap.org>
	<1491959850-30756-11-git-send-email-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93ae643a-582f-8f1a-3f2a-63ae2d9261bc@redhat.com>
Date: Wed, 12 Apr 2017 11:46:47 +0800
MIME-Version: 1.0
In-Reply-To: <1491959850-30756-11-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] tb-hash: improve tb_jmp_cache hash
 function in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>



On 12/04/2017 09:17, Emilio G. Cota wrote:
> +
> +/* In user-mode we can get better hashing because we do not have a TLB */
> +static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
> +{
> +    return (pc ^ (pc >> TB_JMP_CACHE_BITS)) & (TB_JMP_CACHE_SIZE - 1);
> +}

What about multiplicative hashing?

	return (uint64_t) (pc * 2654435761) >> 32;

Paolo
