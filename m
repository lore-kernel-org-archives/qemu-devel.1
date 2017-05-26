Received: from eggs.gnu.org ([2001:4830:134:3::10]:59619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHpP-0004P4-5O
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHpO-0002uN-23
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:11:03 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEHpN-0002uH-T8
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:11:01 -0400
Received: by mail-qt0-x244.google.com with SMTP id a46so1858470qte.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 09:11:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-20-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c975fe5d-7f2a-6d24-02ea-7d98c33d844f@twiddle.net>
Date: Fri, 26 May 2017 09:10:58 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-20-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/26] target/s390x: implement MOVE LONG
 UNICODE
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

On 05/25/2017 02:05 PM, Aurelien Jarno wrote:
> +            cpu_stb_data_ra(env, *dest, pad & 0xff, ra);
> +	    *dest += 1;
> +	    *destlen -= 1;

Tabs or alignment?

Otherwise,
Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
