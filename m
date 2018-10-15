Received: from eggs.gnu.org ([2001:4830:134:3::10]:43164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6Ow-0000WW-9x
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6Oq-0000Fl-H0
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:11:27 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC6Om-0000E5-7Y
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:11:22 -0400
Received: by mail-pg1-x544.google.com with SMTP id t70-v6so9454539pgd.12
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 10:11:20 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b93408f2-7c6d-5c81-e249-7944bcedf168@linaro.org>
Date: Mon, 15 Oct 2018 10:11:15 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 14/21] trace: add support for plugin
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, cota@braap.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vilanova@ac.upc.edu

On 10/5/18 8:49 AM, Alex Bennée wrote:
> +    g_module = g_module_open(filename,
> +        G_MODULE_BIND_LAZY | G_MODULE_BIND_LOCAL);

Do you really want lazy binding?  It means that if a symbol is missing you
won't see it here at load time.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
