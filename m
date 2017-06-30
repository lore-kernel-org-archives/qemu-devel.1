Received: from eggs.gnu.org ([2001:4830:134:3::10]:54795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQqYh-0005Ex-RL
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQqYd-00080P-Ty
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:41:43 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:33313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQqYd-000808-Oj
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:41:39 -0400
Received: by mail-qk0-x22b.google.com with SMTP id v143so10587958qkb.0
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 00:41:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<1498768109-4092-4-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c0d720c9-e63e-1d5d-8b78-a1b66e179a20@twiddle.net>
Date: Fri, 30 Jun 2017 00:41:35 -0700
MIME-Version: 1.0
In-Reply-To: <1498768109-4092-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/7] translate-all: use a binary search tree
 to track TBs in TBContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
> +/* @key is already in the tree so it's safe to use container_of on it */
> +static gint tc_ptr_cmp(gconstpointer candidate, gconstpointer key)
> +{
> +    uintptr_t a = *(uintptr_t *)candidate;
> +    const TranslationBlock *tb = container_of(key, TranslationBlock, tc_ptr);

This I'm not keen on.  It'd be one thing if it was our own datastructure, but I 
see nothing in the GTree documentation that says that the comparison must 
always be done this way.


r~
