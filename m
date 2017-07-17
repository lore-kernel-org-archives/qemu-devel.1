Received: from eggs.gnu.org ([2001:4830:134:3::10]:52928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXF7P-0007bJ-BN
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXF7O-00041H-IU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:07:59 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:35010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXF7O-00040x-E2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:07:58 -0400
Received: by mail-qk0-x230.google.com with SMTP id p73so3453538qka.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:07:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-12-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <02c5e9bd-d2da-fc12-d0bf-b9812a327af0@twiddle.net>
Date: Mon, 17 Jul 2017 13:07:53 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-12-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/45] exec-all: bring tb->invalid into
 tb->cflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:03 AM, Emilio G. Cota wrote:
> -    tb->invalid = true;
> +    tb->cflags |= CF_INVALID;

Modulo the store_release comment for the last patch,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
