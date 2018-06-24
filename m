Received: from eggs.gnu.org ([2001:4830:134:3::10]:60046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXE3b-0003cs-TB
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXE3Y-0005lJ-U6
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:04:31 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:35350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXE3Y-0005kx-Oy
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:04:28 -0400
Received: by mail-pl0-x241.google.com with SMTP id k1-v6so5892424plt.2
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 16:04:28 -0700 (PDT)
References: <20180622141205.16306-1-alex.bennee@linaro.org>
	<20180622141205.16306-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc3f6e61-fe81-4666-28ff-c7889b289ffc@linaro.org>
Date: Sun, 24 Jun 2018 16:04:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180622141205.16306-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v4 22/22] risu_reginfo_aarch64: handle
 variable VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/22/2018 07:12 AM, Alex Bennée wrote:
> This involves parsing the command line parameter and calling the
> kernel to set the VQ limit. We also add dumping of the register state
> in the main register dump.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  risu_reginfo_aarch64.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
