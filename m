Received: from eggs.gnu.org ([2001:4830:134:3::10]:56098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZV9I-0005G6-AE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZV9D-0004pa-EZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:39:16 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZV9D-0004or-7R
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:39:11 -0400
Received: by mail-pf0-x241.google.com with SMTP id y25so2171703pfk.4
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 21:39:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-4-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ac7c2032-deed-21b5-8252-d28797e05bf6@twiddle.net>
Date: Sun, 23 Jul 2017 21:39:06 -0700
MIME-Version: 1.0
In-Reply-To: <20170721125609.11117-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/6] target/s390x: implement spm (SET
 PROGRAM MASK)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 07/21/2017 05:56 AM, David Hildenbrand wrote:
> +    tcg_gen_extrl_i64_i32(cc, o->in1);
> +    tcg_gen_shri_i32(cc, cc, 28);
> +    tcg_gen_andi_i32(cc, cc, 0x3ul);
> +    tcg_gen_mov_i32(cc_op, cc);
> +    tcg_temp_free_i32(cc);
> +    set_cc_static(s);

  tcg_gen_extrl_i64_i32(cc_op, o->in1);
  tcg_gen_extract_i32(cc_op, cc_op, 28, 2);


Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
