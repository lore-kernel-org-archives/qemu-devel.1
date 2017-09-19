Received: from eggs.gnu.org ([2001:4830:134:3::10]:47376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duL94-0005fe-Oy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duL90-0006Gq-UM
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:13:10 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:53524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duL90-0006GJ-R0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:13:06 -0400
Received: by mail-io0-x230.google.com with SMTP id q11so221345ioe.10
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:13:06 -0700 (PDT)
References: <20170914183516.19537-1-richard.henderson@linaro.org>
	<53de205c-7c24-426c-129a-7cce7ca67210@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a265b7a-c84f-fefc-41e6-0276dfc131b8@linaro.org>
Date: Tue, 19 Sep 2017 11:13:01 -0500
MIME-Version: 1.0
In-Reply-To: <53de205c-7c24-426c-129a-7cce7ca67210@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/10] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

[ Just saw this, so missed adding tags to the v2 patch set. ]

On 09/14/2017 11:53 PM, Philippe Mathieu-Daudé wrote:
> At least this msg disappeared:
> 
> "Disassembler disagrees with translator over instruction decoding"

It's back in v2.

> For i386, arm, mips32/64:
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Which patches?  Which mips versions?

Can you, by any chance, test micro-mips?  I'm certain I've got that wrong in
the v1 patch, and thus I dropped the mips patch from v2.  But in theory
capstone supports umips too and should be trivially fixable.


r~
