Received: from eggs.gnu.org ([2001:4830:134:3::10]:50290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHFZ-0008IF-62
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHFY-0006Gr-HA
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:34:01 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEHFY-0006Gm-Cy
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:34:00 -0400
Received: by mail-qt0-x243.google.com with SMTP id j13so1712371qta.3
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 08:34:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-17-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fd59462a-765a-8692-edae-e848e8326791@twiddle.net>
Date: Fri, 26 May 2017 08:33:57 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-17-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/26] target/s390x: implement COMPARE
 LOGICAL LONG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/25/2017 02:04 PM, Aurelien Jarno wrote:
> +static ExitStatus op_clcl(DisasContext *s, DisasOps *o)
> +{
> +    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
> +    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));

Need to force r1 and r2 even.  I guess we didn't do that for clcle either...


r~
