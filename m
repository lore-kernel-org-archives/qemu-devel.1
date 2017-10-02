Received: from eggs.gnu.org ([2001:4830:134:3::10]:38051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz5ip-00035Z-T4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz5il-000075-1X
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:45:43 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz5ik-00006d-RW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:45:38 -0400
Received: by mail-qk0-x241.google.com with SMTP id z14so4442795qkg.3
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 11:45:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-5-richard.henderson@linaro.org>
	<17f88913-12dc-b462-d6fd-9b1c6cfbd6a9@amsat.org>
	<1085a4f8-d12b-f87c-caa7-a9927247d7e8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1be5c928-43d0-e8d1-7c6b-0c37f40c7a54@amsat.org>
Date: Mon, 2 Oct 2017 15:45:35 -0300
MIME-Version: 1.0
In-Reply-To: <1085a4f8-d12b-f87c-caa7-a9927247d7e8@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 4/9] disas: Support the Capstone
 disassembler library
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 03:34 PM, Richard Henderson wrote:
> On 10/02/2017 09:36 AM, Philippe Mathieu-Daudé wrote:
>> Maybe some defines like:
>>
>> #define LARGEST_TARGET_INSTR_SIZE 32
>>
>> #define MINIMUM_TARGET_PAGE_SIZE 1024
> 
> Eh.  If I weren't simply pulling numbers out of my hat, perhaps.
> Does it really make things clearer beyond sizeof or a great big comment?

big comment is great!
