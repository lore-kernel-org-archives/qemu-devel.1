Received: from eggs.gnu.org ([2001:4830:134:3::10]:45259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNbt-0002Wy-VU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNbs-0006DM-V3
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:10:41 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:33186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNNbs-0006DH-DB
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:10:40 -0400
Received: by mail-pg0-x232.google.com with SMTP id f185so65971957pgc.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 11:10:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
	<1497937927-19738-7-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b0286775-b82c-a473-7203-4b734679e5f0@twiddle.net>
Date: Tue, 20 Jun 2017 11:10:37 -0700
MIME-Version: 1.0
In-Reply-To: <1497937927-19738-7-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/8] include/exec/poison: Mark
 CONFIG_SOFTMMU as poisoned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/19/2017 10:52 PM, Thomas Huth wrote:
> CONFIG_SOFTMMU should never be used in common code, so mark
> it as poisoned, too.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   include/exec/poison.h | 1 +
>   include/qom/cpu.h     | 8 ++++++++
>   2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
