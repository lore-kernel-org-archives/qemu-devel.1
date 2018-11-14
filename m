Received: from eggs.gnu.org ([2001:4830:134:3::10]:42824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMzLJ-000829-AI
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMzLF-0006ig-BD
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:52:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gMzLF-0006i0-4k
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:52:41 -0500
Date: Wed, 14 Nov 2018 12:52:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181114175238.GD960@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-7-cota@braap.org> <87va4zd4g8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va4zd4g8.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 06/48] tcg: use QHT for helper_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, Nov 14, 2018 at 16:11:35 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> I needed to do this:
> 
> modified   tcg/tcg.c
> @@ -884,7 +884,7 @@ static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
> 
>  static inline uint32_t tcg_helper_func_hash(const void *func)
>  {
> -    return qemu_xxhash2((uint64_t)func);
> +    return qemu_xxhash2((uint64_t)(uintptr_t)func);
>  }
> 
> To prevent the compiler complaining about:
> 
>  tcg.c:887:25: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

Fixed, thanks.

		E.
