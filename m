Received: from eggs.gnu.org ([2001:4830:134:3::10]:55621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZKB8-0000fw-5I
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZKB5-0000Rp-4y
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:56:26 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:37426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZKB4-0000QJ-VQ
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:56:23 -0400
Received: by mail-pg0-x236.google.com with SMTP id y129so47408796pgy.4
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:56:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500648359-25931-1-git-send-email-thuth@redhat.com>
	<1500648359-25931-4-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c5ea5507-9b06-ae1b-cf86-d27c11ec20ef@twiddle.net>
Date: Sun, 23 Jul 2017 06:56:16 -1000
MIME-Version: 1.0
In-Reply-To: <1500648359-25931-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/s390x: Rework
 program_interrupt() and related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 07/21/2017 04:45 AM, Thomas Huth wrote:
> +static void tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
> +                                       int ilen)
> +{
> +    trigger_pgm_exception(env, code, ilen);
> +#ifdef CONFIG_TCG
> +    cpu_loop_exit(CPU(s390_env_get_cpu(env)));
> +#endif
> +}
> +

How about the whole body as g_assert_not_reached ifndef.

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
