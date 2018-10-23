Received: from eggs.gnu.org ([2001:4830:134:3::10]:34447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gExIP-0005xO-On
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 10:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEx8r-00012b-FB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:54:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEx8r-0000zl-6I
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:54:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id r63-v6so1894247wma.4
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 06:54:39 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-2-richard.henderson@linaro.org>
	<2eb3d12f-1a2b-8194-e1a4-cfd6396f3aa5@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc2e13a8-ee93-9a73-1c19-d9ff6576f793@linaro.org>
Date: Tue, 23 Oct 2018 14:54:35 +0100
MIME-Version: 1.0
In-Reply-To: <2eb3d12f-1a2b-8194-e1a4-cfd6396f3aa5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] decodetree: Add !extern flag to
 argument sets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 10/23/18 2:27 PM, Philippe Mathieu-Daudé wrote:
>> +        if re_fullmatch('!extern', t):
>> +            extern = True
> 
> It looks odd to match a negative form then use a positive one.
> 
> Why not simply use 'extern'?

"!" is an escape character here.
Just "escape" would be a field named "escape".

It follows existing similar syntax for !function=foo


r~
