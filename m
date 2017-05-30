Received: from eggs.gnu.org ([2001:4830:134:3::10]:45072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnaG-0001eq-SA
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnaD-0000yD-K4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:17:40 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnaD-0000y7-Ft
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:17:37 -0400
Received: by mail-qt0-x244.google.com with SMTP id a46so13736535qte.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:17:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-30-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <849ff156-5fc7-22fc-2228-69ac5440a11a@twiddle.net>
Date: Tue, 30 May 2017 13:17:33 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-30-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 29/29] target/s390x: update maximum TCG
 model to z800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> At the same time fix the TCG version of get_max_cpu_model to return the
> maximum model like on KVM. Remove the long-displacement facility from
> the additional features as it is included in the z800.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/cpu_models.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
