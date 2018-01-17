Received: from eggs.gnu.org ([2001:4830:134:3::10]:50318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebplr-0008HO-FT
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebplm-0007tr-J7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:36:59 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:33302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebplm-0007sv-B7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:36:54 -0500
Received: by mail-pl0-x241.google.com with SMTP id t4so6348681plo.0
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 07:36:54 -0800 (PST)
References: <20180117131821.18700-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f580124e-75a7-749b-da1c-da4993d583da@linaro.org>
Date: Wed, 17 Jan 2018 07:36:49 -0800
MIME-Version: 1.0
In-Reply-To: <20180117131821.18700-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] add QEMU_WARN_NONNULL_ARGS() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01/17/2018 05:18 AM, Philippe Mathieu-Daudé wrote:
> BTW another useful macro for the static analizer I used is:
> 
>     #define QEMU_FALLTHROUGH __attribute__((fallthrough))
> 
> It replaces the /* fall through */ comment, i.e.:

That's unfortunate.  Does it help if you use the actual lint spelling of /*
FALLTHRU */?


r~
