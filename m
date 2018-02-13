Received: from eggs.gnu.org ([2001:4830:134:3::10]:44623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elew4-0002hd-Hg
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elevy-000632-RH
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:04:08 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:41741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1elevy-00062I-Ml
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:04:02 -0500
Received: by mail-vk0-x22f.google.com with SMTP id g186so11330436vkd.8
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 10:04:02 -0800 (PST)
References: <20180213140029.8308-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <349e8191-35f5-5e33-3629-a195fbeaf9c2@linaro.org>
Date: Tue, 13 Feb 2018 10:03:56 -0800
MIME-Version: 1.0
In-Reply-To: <20180213140029.8308-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] log-for-trace.h: Split out parts of log.h
 used by trace.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On 02/13/2018 06:00 AM, Peter Maydell wrote:
> A persistent build problem we see is where a source file
> accidentally omits the #include of log.h. This slips through
> local developer testing because if you configure with the
> default (log) trace backend trace.h will pull in log.h for you.
> Compilation fails only if some other backend is selected.
> 
> To make this error cause a compile failure regardless of
> the configured trace backend, split out the parts of log.h
> that trace.h requires into a new log-for-trace.h header.
> Since almost all manual uses of the log.h functions will
> use constants or functions which aren't in log-for-trace.h,
> this will let us catch missing #include "qemu/log.h" more
> consistently.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qemu/log-for-trace.h     | 35 +++++++++++++++++++++++++++++++++++
>  include/qemu/log.h               | 18 ++++--------------
>  scripts/tracetool/backend/log.py | 13 ++++++-------
>  3 files changed, 45 insertions(+), 21 deletions(-)
>  create mode 100644 include/qemu/log-for-trace.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
