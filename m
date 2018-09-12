Received: from eggs.gnu.org ([2001:4830:134:3::10]:49283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g09SJ-0004x0-2H
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g09SG-0005Du-CN
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:01:35 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g09SF-0005C8-PI
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:01:32 -0400
Received: by mail-pg1-x543.google.com with SMTP id b129-v6so1433161pga.13
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 11:01:29 -0700 (PDT)
References: <20180912123700.7708-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1d8dc5fa-d5db-eabf-4a9b-5ed24550f428@linaro.org>
Date: Wed, 12 Sep 2018 11:01:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180912123700.7708-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] display/edid: add edid generator to
 qemu.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 09/12/2018 05:36 AM, Gerd Hoffmann wrote:
> +static struct edid_mode {
> +    uint32_t xres;
> +    uint32_t yres;
> +    uint32_t byte;
> +    uint32_t xtra3;
> +    uint32_t bit;
> +} modes[] = {

static const?


r~
