Received: from eggs.gnu.org ([2001:4830:134:3::10]:50036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYnf-0002Ll-8P
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYnc-0005oT-As
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:24:55 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:33415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTYnc-0005nq-51
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:24:52 -0400
Received: by mail-pf0-x233.google.com with SMTP id b17-v6so3782637pfi.0
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:24:52 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd909890-3c79-cb7e-6e25-c8b672361782@linaro.org>
Date: Thu, 14 Jun 2018 10:24:47 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 16/22] risu_reginfo_aarch64:
 unionify VFP regs
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

On 06/13/2018 02:55 AM, Alex Bennée wrote:
> This is preparation for the SVE work as we won't want to be carrying
> around both VFP and SVE registers at the same time as they overlap.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  risu_reginfo_aarch64.c | 16 ++++++++--------
>  risu_reginfo_aarch64.h |  9 ++++++++-
>  2 files changed, 16 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
