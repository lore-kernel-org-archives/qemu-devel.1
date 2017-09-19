Received: from eggs.gnu.org ([2001:4830:134:3::10]:49662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duFph-0008Og-JB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duFpd-000133-Ie
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:32:49 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duFpd-00012u-E9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:32:45 -0400
Received: by mail-qt0-x241.google.com with SMTP id l25so2036405qtf.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 03:32:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170918214649.17550-1-eblake@redhat.com>
	<dfe4dc28-4011-e7a7-aa1f-54e340f091d2@amsat.org>
	<53ea39b4-7926-d29b-fb28-3f2295dc394d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8f30a125-040e-0c75-92c9-2c6fd8db08db@amsat.org>
Date: Tue, 19 Sep 2017 07:32:41 -0300
MIME-Version: 1.0
In-Reply-To: <53ea39b4-7926-d29b-fb28-3f2295dc394d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] nbd-client: Use correct
 macro parenthesization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On 09/18/2017 07:42 PM, Eric Blake wrote:
> On 09/18/2017 05:13 PM, Philippe Mathieu-Daudé wrote:
>> Any magic cocci script to verify there aren't no more?
> 
> I don't know if cocci can do it; checkpatch tries to check whether macro
> arguments are parenthesized, but even that's prone to missing things.  I
> just spotted this particular one while reviewing a related patch.

couldn't figure out.

grep -E '^\s*#define\s+\w+\([^\)]+\)\s+.*\(\w+\)\w+' (no multiline) 
found those unharmful:

target/mips/dsp_helper.c:#define MIPSDSP_RETURN64_16(a, b, c, d) 
(((uint64_t)a << 48) | \
target/mips/dsp_helper.c:#define MIPSDSP_RETURN64_32(a, b) 
(((uint64_t)a << 32) | (uint64_t)b)
include/hw/ppc/pnv_xscom.h:#define PNV_XSCOM_EX_CORE_BASE(base, i) (base 
| (((uint64_t)i) << 24))
