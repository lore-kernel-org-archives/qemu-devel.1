Received: from eggs.gnu.org ([2001:4830:134:3::10]:47371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6ec-0004lt-E3
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6eY-0004Ub-7q
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:27:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC6eY-0004Tn-02
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:27:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id f26-v6so10018915pfn.9
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 10:27:37 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e351e6a-3134-13a9-184c-8ef7bf4f1f09@linaro.org>
Date: Mon, 15 Oct 2018 10:27:33 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 17/21] hmp: expose status of plugins to
 the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu

On 10/5/18 8:49 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  hmp-commands-info.hx   | 17 +++++++++++++++++
>  include/qemu/plugins.h |  1 +
>  monitor.c              | 14 ++++++++++++++
>  trace/plugins.c        | 15 +++++++++++++++
>  4 files changed, 47 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
