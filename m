Received: from eggs.gnu.org ([209.51.188.92]:39649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWub-00014b-Ge
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWio-0005iI-5b
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:35:54 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:37050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWim-0005gd-Ie
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:35:52 -0500
Received: by mail-pf1-x42d.google.com with SMTP id s22so12331607pfh.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:35:51 -0800 (PST)
References: <20190220172811.10588-1-alex.bennee@linaro.org>
	<20190220172811.10588-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd149cf0-122f-3d47-09b8-d1d0776fafb8@linaro.org>
Date: Wed, 20 Feb 2019 10:35:47 -0800
MIME-Version: 1.0
In-Reply-To: <20190220172811.10588-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/8] .travis.yml: split debug builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org

On 2/20/19 9:28 AM, Alex Bennée wrote:
> The builds are reaching the magic 50 minute limit with regularity so
> lets split them up. Rather than doing a full debug build on both just
> enable debug tcg for linux-user.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
