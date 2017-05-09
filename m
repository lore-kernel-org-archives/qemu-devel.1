Received: from eggs.gnu.org ([2001:4830:134:3::10]:52754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CNk-0002D5-HF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CNj-0007wJ-Qw
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:09:20 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:36113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CNj-0007wF-MW
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:09:19 -0400
Received: by mail-qt0-x22d.google.com with SMTP id m91so11914997qte.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 14:09:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-10-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a98c67f8-3c5c-b68d-beea-f1972bb3dc0d@twiddle.net>
Date: Tue, 9 May 2017 14:09:16 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-10-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/14] target/sh4: optimize
 gen_store_fpr64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> +    tcg_gen_extrl_i64_i32(cpu_fregs[reg + 1], t);
> +    tcg_gen_extrh_i64_i32(cpu_fregs[reg], t);

This is

   tcg_gen_extr_i64_i32(cpu_fregs[reg + 1], cpu_fregs[reg], t);

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
