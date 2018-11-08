Received: from eggs.gnu.org ([2001:4830:134:3::10]:55165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKnrs-0003yZ-I6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKnro-0001lQ-ER
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:13:20 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKnro-0001k5-58
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:13:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id f1-v6so1999090wmg.1
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:13:16 -0800 (PST)
References: <20181108163329.19940-1-alex.bennee@linaro.org>
	<20181108163329.19940-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8f40ec14-1e86-c865-c396-6ce5cb09115f@linaro.org>
Date: Thu, 8 Nov 2018 18:13:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181108163329.19940-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] target/arm64: kvm debug set
 target_el when passing exception to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 11/8/18 5:33 PM, Alex Bennée wrote:
> When we are debugging the guest all exceptions come our way but might
> be for the guest's own debug exceptions. We use the ->do_interrupt()
> infrastructure to inject the exception into the guest. However, we are
> missing a full setup of the exception structure, causing an assert
> later down the line.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
