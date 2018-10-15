Received: from eggs.gnu.org ([2001:4830:134:3::10]:53462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC5OT-0008WP-4x
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC5OP-0005HC-T2
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:57 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:33093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC5OP-0005Gu-F4
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:53 -0400
Received: by mail-pg1-x52a.google.com with SMTP id y18-v6so9396726pge.0
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:06:53 -0700 (PDT)
References: <20181015055333.32030-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4ea9bd98-22bd-9a2e-cae5-94bb888086be@linaro.org>
Date: Mon, 15 Oct 2018 09:06:49 -0700
MIME-Version: 1.0
In-Reply-To: <20181015055333.32030-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] edid: fix alignment issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 10/14/18 10:53 PM, Gerd Hoffmann wrote:
> Use stl_le_p() & friends instead of casts.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/edid-generate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
