Received: from eggs.gnu.org ([2001:4830:134:3::10]:33334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8rfu-0003Cv-M1
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8rfr-00077v-H6
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:51:38 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8rfr-00077f-B5
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:51:35 -0400
Received: by mail-pf1-x444.google.com with SMTP id l17-v6so2184147pff.2
	for <qemu-devel@nongnu.org>; Sat, 06 Oct 2018 11:51:35 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87503b42-1a74-4a19-6e8e-012b903ab791@linaro.org>
Date: Sat, 6 Oct 2018 11:51:31 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 10/21] qom/cpu: add a cpu_exit trace
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 10/5/18 8:48 AM, Alex Bennée wrote:
> This is useful for tracing cpu_exit events where we signal the CPU to
> come back to the main loop.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  qom/cpu.c        | 3 +++
>  qom/trace-events | 4 ++++
>  2 files changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
