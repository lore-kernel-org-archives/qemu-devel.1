Received: from eggs.gnu.org ([2001:4830:134:3::10]:53657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLqDb-0001Um-Br
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 08:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLqDX-0005E0-7Z
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 08:56:03 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gLqDW-0005Di-WE
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 08:55:59 -0500
Received: by mail-wm1-x344.google.com with SMTP id f10-v6so5982099wme.3
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 05:55:58 -0800 (PST)
References: <20181109152119.9242-1-alex.bennee@linaro.org>
	<20181109152119.9242-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c73b6e34-6d46-9b9b-7b83-ce78df1b574f@linaro.org>
Date: Sun, 11 Nov 2018 14:55:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181109152119.9242-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] target/arm64: properly handle DBGVR
 RESS bits
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

On 11/9/18 4:21 PM, Alex Bennée wrote:
> This only fails with some (broken) versions of gdb but we should
> treat the top bits of DBGBVR as RESS. Properly sign extend QEMU's
> reference copy of dbgbvr and also update the register descriptions in
> the comment.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
