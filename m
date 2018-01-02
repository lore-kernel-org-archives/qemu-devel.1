Received: from eggs.gnu.org ([2001:4830:134:3::10]:57603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWRWg-0003Ct-6X
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWRWc-0002Ap-Si
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:43:02 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWRWc-0002A9-K1
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:42:58 -0500
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-9-laurent@vivier.eu>
	<9ca4c6cb-0a15-de72-b303-d05354dbda93@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bd1a6b92-c328-3b47-e32c-addfccec7c75@vivier.eu>
Date: Tue, 2 Jan 2018 19:42:55 +0100
MIME-Version: 1.0
In-Reply-To: <9ca4c6cb-0a15-de72-b303-d05354dbda93@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 08/17] target/m68k: add move16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

Le 02/01/2018 à 17:50, Richard Henderson a écrit :
> On 01/01/2018 05:10 PM, Laurent Vivier wrote:
>> +    mode = (insn >> 3) & 7;
>> +
>> +    if (mode & 4) {
> 
> Looks like mode should equal 4 as well.
>

Yes, you're right. I will replace the line by:

+    if (mode == 4) {

Thanks,
Laurent
