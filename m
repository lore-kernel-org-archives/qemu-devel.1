Received: from eggs.gnu.org ([2001:4830:134:3::10]:58150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8rIV-0006UD-SI
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8rIJ-0001FE-GC
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:27:22 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:36281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8rIJ-0001EJ-9p
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:27:15 -0400
Received: by mail-pg1-x52e.google.com with SMTP id f18-v6so6108772pgv.3
	for <qemu-devel@nongnu.org>; Sat, 06 Oct 2018 11:27:15 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <62443128-9ace-5d4a-ea7d-2e573e08ca8b@linaro.org>
Date: Sat, 6 Oct 2018 11:27:11 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 06/21] trace: show trace point counts
 in the monitor
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

On 10/5/18 8:48 AM, Alex Bennée wrote:
> Now we have counts for each trace point we can expose them in the
> monitor when the user queries what trace points are available.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  monitor.c       | 5 +++--
>  qapi/trace.json | 3 ++-
>  trace/qmp.c     | 1 +
>  3 files changed, 6 insertions(+), 3 deletions(-)

I would have merged this with previous, but whatever.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
