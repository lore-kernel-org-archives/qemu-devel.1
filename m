Received: from eggs.gnu.org ([2001:4830:134:3::10]:37868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsHCO-00028O-MR
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsHCJ-0004qX-Q5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:36:04 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:44932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsHCJ-0004q2-IZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:35:59 -0400
Received: by mail-pf0-x233.google.com with SMTP id e1so2504232pfk.1
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:35:59 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-6-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2f92aa2-d016-5f90-3c40-c6eb19d26632@linaro.org>
Date: Wed, 13 Sep 2017 16:35:55 -0700
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/19] nvic: Implement AIRCR changes for v8M
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
> The Application Interrupt and Reset Control Register has some changes
> for v8M:
>  * new bits SYSRESETREQS, BFHFNMINS and PRIS: these all have
>    real state if the security extension is implemented and otherwise
>    are constant
>  * the PRIGROUP field is banked between security states
>  * non-secure code can be blocked from using the SYSRESET bit
>    to reset the system if SYSRESETREQS is set
> 
> Implement the new state and the changes to register read and write.
> For the moment we ignore the effects of the secure PRIGROUP.
> We will implement the effects of PRIS and BFHFNMIS later.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
