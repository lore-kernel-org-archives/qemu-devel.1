Received: from eggs.gnu.org ([2001:4830:134:3::10]:41665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cMGmR-00030Y-An
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cMGmO-0001Hs-26
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:08:43 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:32823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cMGmN-0001Hd-Ta
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:08:39 -0500
Received: by mail-oi0-x241.google.com with SMTP id f201so51776010oib.0
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 08:08:38 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <148293406236.28901.9490775858242540392.stgit@fimbulvetr.bsc.es>
	<148293408387.28901.10687132341063477318.stgit@fimbulvetr.bsc.es>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5187c1b7-1c34-1cc1-1e22-9d1f957d6e82@twiddle.net>
Date: Wed, 28 Dec 2016 08:08:33 -0800
MIME-Version: 1.0
In-Reply-To: <148293408387.28901.10687132341063477318.stgit@fimbulvetr.bsc.es>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 4/7] exec: [tcg] Use different TBs
 according to the vCPU's dynamic tracing state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 12/28/2016 06:08 AM, Lluís Vilanova wrote:
> @@ -83,6 +85,13 @@ uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint32_t e)
>      h32 += e * PRIME32_3;
>      h32  = rol32(h32, 17) * PRIME32_4;
>
> +    if (sizeof(TRACE_QHT_VCPU_DSTATE_TYPE) == sizeof(uint32_t)) {
> +        h32 += f * PRIME32_3;
> +        h32  = rol32(h32, 17) * PRIME32_4;
> +    } else {
> +        abort();
> +    }
> +

QEMU_BUILD_BUG_ON.


r~
