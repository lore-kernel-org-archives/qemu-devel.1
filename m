Received: from eggs.gnu.org ([2001:4830:134:3::10]:49808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYBcA-0006mE-7i
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYBc6-0003fw-A7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:40:10 -0400
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:45628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYBc6-0003fI-4d
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:40:06 -0400
Received: by mail-pl0-x232.google.com with SMTP id bi1-v6so1134154plb.12
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 07:40:06 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-44-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50b8e622-c57d-804c-a7dc-4683cbecbe56@linaro.org>
Date: Wed, 27 Jun 2018 07:40:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-44-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 43/46] vl: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 06/25/2018 05:42 AM, Philippe Mathieu-Daudé wrote:
> -            sz <<= 20;
> +            sz *= MiB;
>              if ((sz >> 20) != overflow_check) {

Missed one.

r~
