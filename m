Received: from eggs.gnu.org ([2001:4830:134:3::10]:39484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBCd-0005md-EB
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUBCb-00005n-BV
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:57:31 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUBCZ-0008VM-GE
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:57:27 -0500
Received: by mail-ot1-x343.google.com with SMTP id 32so15178910ota.12
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:57:27 -0800 (PST)
References: <20181204132952.2601-1-peter.maydell@linaro.org>
	<20181204132952.2601-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f79fa7ae-3d36-651b-a123-e048c925bf50@linaro.org>
Date: Tue, 4 Dec 2018 07:57:22 -0600
MIME-Version: 1.0
In-Reply-To: <20181204132952.2601-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] target/arm: Free name string in
 ARMCPRegInfo hashtable entries
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

On 12/4/18 7:29 AM, Peter Maydell wrote:
> When we add a new entry to the ARMCPRegInfo hash table in
> add_cpreg_to_hashtable(), we allocate memory for tehe
> ARMCPRegInfo struct itself, and we also g_strdup() the
> name string. So the hashtable's value destructor function
> must free the name string as well as the struct.
> 
> Spotted by clang's leak sanitizer. The leak here is a
> small one-off leak at startup, because we don't support
> CPU hotplug, and so the only time when we destroy
> hash table entries is for the case where ARM_CP_OVERRIDE
> means we register a wildcard entry and then override it later.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
