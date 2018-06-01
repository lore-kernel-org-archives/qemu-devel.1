Received: from eggs.gnu.org ([2001:4830:134:3::10]:56867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOm8B-0002tw-Tx
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fOm88-0003Bu-02
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:38:19 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:33487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fOm87-0003BY-Ni
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:38:15 -0400
Received: by mail-wm0-x231.google.com with SMTP id z6-v6so5799477wma.0
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 08:38:15 -0700 (PDT)
References: <1526945967-9687-1-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1526945967-9687-1-git-send-email-cota@braap.org>
Date: Fri, 01 Jun 2018 16:38:13 +0100
Message-ID: <87y3fyzfdm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/17] tcg: tb_lock removal redux v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> v2: https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg00656.html
>
<snip>
I'm sure you've seen something similar but currently my profile looks
like this:

   5.91%  qemu-system-aar  qemu-system-aarch64      [.] cpu_get_tb_cpu_state
   5.88%  qemu-system-aar  qemu-system-aarch64      [.] helper_lookup_tb_ptr
   5.42%  qemu-system-aar  qemu-system-aarch64      [.] get_phys_addr_lpae
   3.27%  qemu-system-aar  qemu-system-aarch64      [.] qht_lookup
   2.80%  qemu-system-aar  qemu-system-aarch64      [.] tlb_set_page_with_a=
ttrs
   2.06%  qemu-system-aar  qemu-system-aarch64      [.] address_space_ldq_le
   1.90%  qemu-system-aar  qemu-system-aarch64      [.] victim_tlb_hit
   1.89%  qemu-system-aar  qemu-system-aarch64      [.] address_space_trans=
late_internal
   1.62%  qemu-system-aar  qemu-system-aarch64      [.] object_dynamic_cast=
_assert
   1.40%  qemu-system-aar  qemu-system-aarch64      [.] get_phys_addr
   1.35%  qemu-system-aar  qemu-system-aarch64      [.] tb_htable_lookup
   1.31%  qemu-system-aar  qemu-system-aarch64      [.] flatview_do_transla=
te
   1.21%  qemu-system-aar  libc-2.27.so             [.] 0x000000000018ef2d
   1.12%  qemu-system-aar  qemu-system-aarch64      [.] get_page_addr_code
   1.06%  qemu-system-aar  libpthread-2.27.so       [.] __pthread_mutex_lock
   1.06%  qemu-system-aar  qemu-system-aarch64      [.] tlb_flush_nocheck
   1.01%  qemu-system-aar  [unknown]                [k] 0xffffffff88f95990
   0.98%  qemu-system-aar  qemu-system-aarch64      [.] tcg_gen_code


--
Alex Benn=C3=A9e
