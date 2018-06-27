Received: from eggs.gnu.org ([2001:4830:134:3::10]:34445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3a9-0005Y5-9i
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3a8-00015l-3S
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:05:32 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY3a7-00015O-TV
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:05:32 -0400
Received: by mail-pf0-x241.google.com with SMTP id c22-v6so494381pfi.2
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 23:05:31 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-10-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d5fa39d-1d3e-d8d0-9911-4440b29b5021@linaro.org>
Date: Tue, 26 Jun 2018 23:05:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 09/46] hw/scsi: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 06/25/2018 05:42 AM, Philippe Mathieu-Daudé wrote:
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
> 
> and modified manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/scsi/scsi-disk.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
