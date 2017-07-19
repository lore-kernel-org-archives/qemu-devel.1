Received: from eggs.gnu.org ([2001:4830:134:3::10]:49414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtTH-0008Ko-Sh
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtTE-00077t-PZ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:13:15 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXtTE-00077m-Ky
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:13:12 -0400
Received: by mail-qt0-x242.google.com with SMTP id n43so1145854qtc.4
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 11:13:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500468850-15571-1-git-send-email-thuth@redhat.com>
	<1500468850-15571-6-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2d593bd0-0019-77bf-d709-a107a29b7488@twiddle.net>
Date: Wed, 19 Jul 2017 08:13:06 -1000
MIME-Version: 1.0
In-Reply-To: <1500468850-15571-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] target/s390x: Add remaining switches
 to compile with --disable-tcg
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

On 07/19/2017 02:54 AM, Thomas Huth wrote:
>       cc->has_work = s390_cpu_has_work;
> +#ifdef CONFIG_TCG
>       cc->do_interrupt = s390_cpu_do_interrupt;
> +#endif
>       cc->dump_state = s390_cpu_dump_state;
>       cc->set_pc = s390_cpu_set_pc;
>       cc->gdb_read_register = s390_cpu_gdb_read_register;
> @@ -428,10 +430,12 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>       cc->get_phys_page_debug = s390_cpu_get_phys_page_debug;
>       cc->vmsd = &vmstate_s390_cpu;
>       cc->write_elf64_note = s390_cpu_write_elf64_note;
> +#ifdef CONFIG_TCG
>       cc->cpu_exec_interrupt = s390_cpu_exec_interrupt;
>       cc->debug_excp_handler = s390x_cpu_debug_excp_handler;
>       cc->do_unaligned_access = s390x_cpu_do_unaligned_access;
>   #endif
> +#endif

These ought to be if (tcg_enabled()), surely.


r~
