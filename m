Received: from eggs.gnu.org ([2001:4830:134:3::10]:37381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8Y5b-0008Aw-AN
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8Y5a-00030A-LO
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:20:03 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:34250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8Y5a-0002zm-Gi
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:20:02 -0400
Received: by mail-qt0-x232.google.com with SMTP id j29so1981511qtj.1
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 13:20:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-2-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
Date: Wed, 10 May 2017 13:19:58 -0700
MIME-Version: 1.0
In-Reply-To: <20170510200535.13268-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/8] coccinelle: add a script to optimize
 tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/10/2017 01:05 PM, Philippe Mathieu-Daudé wrote:
> +-tcg_gen_shri_tl(ret, arg, ofs);
> +-tcg_gen_andi_tl(ret, ret, len);
> ++tcg_gen_extract_tl(ret, arg, ofs, len);

You can't simply copy the and mask to the extract length.

You need to verify it's all low bits and convert that to a count of the low 
bits.  E.g. 0xff -> 8.


r~
