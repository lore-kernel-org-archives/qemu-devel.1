Received: from eggs.gnu.org ([2001:4830:134:3::10]:38450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC66j-0001Sc-Dk
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC66g-0007dz-2a
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:52:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC66f-0007dF-R0
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:52:38 -0400
Received: by mail-pg1-x544.google.com with SMTP id r9-v6so9444278pgv.6
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:52:37 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bb01827c-c6ab-d792-56f2-3beb2a2b618f@linaro.org>
Date: Mon, 15 Oct 2018 09:52:33 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 11/21] trace: expose a plugin fn
 pointer in TraceEvent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru

On 10/5/18 8:49 AM, Alex Bennée wrote:
> We'll need somewhere to stash this later. It's up to the generated
> code to do the funky casting to what it really is.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  trace/control-internal.h | 6 ++++++
>  trace/event-internal.h   | 3 +++
>  2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
