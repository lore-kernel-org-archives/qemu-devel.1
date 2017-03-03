Received: from eggs.gnu.org ([2001:4830:134:3::10]:50087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjsos-00043D-6g
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjsop-0000AA-3E
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:24:50 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cjsoo-00009s-Tn
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:24:47 -0500
Received: by mail-pg0-x241.google.com with SMTP id 77so769489pgc.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 11:24:46 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1488558530-21016-1-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <aeecd6a5-2593-c3c4-25f0-ae0d6af53653@twiddle.net>
Date: Sat, 4 Mar 2017 06:24:40 +1100
MIME-Version: 1.0
In-Reply-To: <1488558530-21016-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hppa: avoid anonymous unions in designated
 initializers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 03/04/2017 03:28 AM, Paolo Bonzini wrote:
> These cause compilation failures on CentOS 6 or other operating
> systems with older GCCs.
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	Peter, please consider applying this as a build fix, because
> 	the centos6 docker target is broken.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
