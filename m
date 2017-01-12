Received: from eggs.gnu.org ([2001:4830:134:3::10]:33632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRkzv-00068Q-OY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRkzs-0001JK-Lt
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:25:19 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRkzs-0001JF-Gw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:25:16 -0500
Received: by mail-oi0-x242.google.com with SMTP id 3so4202510oih.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:25:16 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484244501-20283-1-git-send-email-laurent@vivier.eu>
	<1484244501-20283-4-git-send-email-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <69192927-83c1-42c0-90ab-f1089018632c@twiddle.net>
Date: Thu, 12 Jan 2017 11:25:11 -0800
MIME-Version: 1.0
In-Reply-To: <1484244501-20283-4-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 3/4] target-m68k: Implement bfffo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 01/12/2017 10:08 AM, Laurent Vivier wrote:
> +uint32_t HELPER(bfffo_reg)(uint32_t n, uint32_t ofs, uint32_t len)
> +{
> +    return (n ? clz32(n) : len) + ofs;
> +}

I could send a follow-up to use the new tcg_gen_clz_i32 helper...


r~
