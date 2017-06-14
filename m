Received: from eggs.gnu.org ([2001:4830:134:3::10]:40053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0AX-0007M2-AQ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0AS-00048n-DI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:44:37 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dL0AR-00048W-Um
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:44:32 -0400
Received: by mail-qk0-x241.google.com with SMTP id r62so6413428qkf.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 21:44:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170613214736.19963-1-david@redhat.com>
	<20170613214736.19963-4-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e1193b07-a074-140d-c44b-c122d6909c12@twiddle.net>
Date: Tue, 13 Jun 2017 21:44:28 -0700
MIME-Version: 1.0
In-Reply-To: <20170613214736.19963-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] s390x/cpumodel: allow to enable
 MVCOS for qemu cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Miroslav Benes <mbenes@suse.cz>

On 06/13/2017 02:47 PM, David Hildenbrand wrote:
> +    if (!s390_has_feat(S390_FEAT_MOVE_WITH_OPTIONAL_SPEC)) {
> +        program_interrupt(env, PGM_OPERATION, 6);
> +    }

This is (supposed to be) done via the feature field of insn-data.def.

Except that we do not yet enforce that; we haven't updated that bit of the 
translator since we actually added support for the feature bits.


r~
