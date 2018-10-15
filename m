Received: from eggs.gnu.org ([2001:4830:134:3::10]:48167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6fk-0005Ys-S7
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6fi-0005Fk-Mf
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:52 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC6fi-0005F5-F5
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:50 -0400
Received: by mail-pl1-x641.google.com with SMTP id e67-v6so654618plb.6
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 10:28:50 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-19-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54a23bbf-e2ad-e091-612c-05715b41b173@linaro.org>
Date: Mon, 15 Oct 2018 10:28:46 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 18/21] linux-user: allow dumping of
 plugin status at end of run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu

On 10/5/18 8:49 AM, Alex Bennée wrote:
> As we don't have a monitor in linux-user mode we need some way of
> exporting our data to the world. We introduce a new -d option (plugin)
> which turns on the existing LOG_TRACE flag which qemu_plugin_status()
> will dump output to before we finally exit.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/exit.c | 12 ++++++++++++
>  util/log.c        |  2 ++
>  2 files changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
