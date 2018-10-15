Received: from eggs.gnu.org ([2001:4830:134:3::10]:37194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC61t-0007mo-JT
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC61n-0004rS-TZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:47:39 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC61g-0004iV-DW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:47:31 -0400
Received: by mail-pf1-x441.google.com with SMTP id f29-v6so9979454pff.5
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:47:17 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6635759a-d6c1-b315-18c8-042592f0f763@linaro.org>
Date: Mon, 15 Oct 2018 09:47:13 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 09/21] trace: suppress log output of
 trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru

On 10/5/18 8:48 AM, Alex Bennée wrote:
> When multiple tracers are enabled and you want to save to binary we
> shouldn't assume the user also wants to spam the log. They can always
> override it manually if they want.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  util/log.c |  3 ---
>  vl.c       | 18 ++++++++++++++++--
>  2 files changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
