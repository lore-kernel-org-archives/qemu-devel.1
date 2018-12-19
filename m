Received: from eggs.gnu.org ([2001:4830:134:3::10]:56463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZgGb-000245-FR
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZgGW-00066V-G2
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:08:21 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:45704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZgGW-00065x-8j
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:08:16 -0500
Received: by mail-pg1-x52f.google.com with SMTP id y4so9763139pgc.12
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 10:08:15 -0800 (PST)
References: <49f8df12.d1fa.167c599dfe9.Coremail.13824125580@163.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a29059b1-73fc-762c-bc2f-e6545b2dbc14@linaro.org>
Date: Wed, 19 Dec 2018 10:08:11 -0800
MIME-Version: 1.0
In-Reply-To: <49f8df12.d1fa.167c599dfe9.Coremail.13824125580@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] how to get the "intermediate tcg" string output to
 debug qemu?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tugouxp <13824125580@163.com>, qemu-devel@nongnu.org

On 12/19/18 12:34 AM, tugouxp wrote:
> hi folks:
>   i want to get the translated tcg operations printed on my test pattern, so is there any way to get this for convenient?

-D logfile -d op

will put the unoptimized tcg operations into the logfile.
Use "op_opt" for the optimized tcg operations.


r~
