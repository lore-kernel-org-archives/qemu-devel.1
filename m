Received: from eggs.gnu.org ([2001:4830:134:3::10]:49759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsGce-0008HQ-JD
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsGcZ-0007g5-OT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:59:08 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:43979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsGcZ-0007eq-FM
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:59:03 -0400
Received: by mail-pf0-x22d.google.com with SMTP id y29so2404788pff.0
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 15:59:03 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2a2c4292-cfcc-0dbd-d9fa-edbe56dfe639@linaro.org>
Date: Wed, 13 Sep 2017 15:58:59 -0700
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/19] target/arm: Implement MSR/MRS access
 to NS banked registers
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

On 09/12/2017 11:13 AM, Peter Maydell wrote:
> In v8M the MSR and MRS instructions have extra register value
> encodings to allow secure code to access the non-secure banked
> version of various special registers.
> 
> (We don't implement the MSPLIM_NS or PSPLIM_NS aliases, because
> we don't currently implement the stack limit registers at all.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
