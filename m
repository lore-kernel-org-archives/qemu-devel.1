Received: from eggs.gnu.org ([2001:4830:134:3::10]:33021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeNrU-00081D-A8
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeNrP-0003H6-N7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:25:20 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeNrP-0003G4-GD
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:25:15 -0500
Received: by mail-pg0-x242.google.com with SMTP id w17so3041037pgv.6
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 08:25:15 -0800 (PST)
References: <20180124101358.GA5028@bogon.m.sigxcpu.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4ae6f99b-02ab-9692-7246-5c9b2e97f3bf@linaro.org>
Date: Wed, 24 Jan 2018 08:25:11 -0800
MIME-Version: 1.0
In-Reply-To: <20180124101358.GA5028@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix register used for 6th and
 7th syscall argument on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 01/24/2018 02:13 AM, Guido Günther wrote:
> Unbreaks the testcase from
> 
>     http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html
> 
> Thanks to Laurent Vivier for spotting the 7th one.
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/host/aarch64/safe-syscall.inc.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
