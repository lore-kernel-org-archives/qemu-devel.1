Received: from eggs.gnu.org ([2001:4830:134:3::10]:60727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Z9I-00013C-0e
	for qemu-devel@nongnu.org; Wed, 10 May 2017 17:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Z9E-0000XS-U0
	for qemu-devel@nongnu.org; Wed, 10 May 2017 17:27:56 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:34620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Z9E-0000XG-Oj
	for qemu-devel@nongnu.org; Wed, 10 May 2017 17:27:52 -0400
Received: by mail-qk0-x231.google.com with SMTP id k74so7769365qke.1
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 14:27:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-2-f4bug@amsat.org>
	<0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <288e527b-c817-383d-c317-b83f1cdb5994@amsat.org>
Date: Wed, 10 May 2017 18:27:47 -0300
MIME-Version: 1.0
In-Reply-To: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/10/2017 05:19 PM, Richard Henderson wrote:
> On 05/10/2017 01:05 PM, Philippe Mathieu-Daudé wrote:
>> +-tcg_gen_shri_tl(ret, arg, ofs);
>> +-tcg_gen_andi_tl(ret, ret, len);
>> ++tcg_gen_extract_tl(ret, arg, ofs, len);
>
> You can't simply copy the and mask to the extract length.
>
> You need to verify it's all low bits and convert that to a count of the
> low bits.  E.g. 0xff -> 8.

Hey Richard, this pattern can be applied as long as len << ofs does not 
overflow target_long, regardless of low bits count, right?

Phil.
