Received: from eggs.gnu.org ([2001:4830:134:3::10]:45876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFy1-0005jC-DU
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFxy-0007wJ-9N
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:12:21 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:46185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFxy-0007vl-4C
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:12:18 -0500
Received: by mail-io0-x244.google.com with SMTP id f34so11102751ioi.13
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 13:12:18 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f4c92c93-286d-567d-8a4e-b247bb634f31@linaro.org>
Date: Fri, 9 Feb 2018 13:12:14 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/11] target/arm: Add AIRCR to vmstate
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/09/2018 08:58 AM, Peter Maydell wrote:
> In commit commit 3b2e934463121 we added support for the AIRCR
> register holding state, but forgot to add it to the vmstate
> structs. Since it only holds r/w state if the security extension
> is implemented, we can just add it to vmstate_m_security.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/machine.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
