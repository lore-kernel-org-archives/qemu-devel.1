Received: from eggs.gnu.org ([2001:4830:134:3::10]:34622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVN53-0002DK-8K
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVN4z-0001Ga-8A
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:13:49 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVN4z-0001G1-3b
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:13:45 -0400
Received: by mail-qk0-f196.google.com with SMTP id q66so5296744qki.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 12:13:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
	<20170712184540.12352-1-rth@twiddle.net>
	<CAPybu_35LKPPZuQMxCSsRM+YaBd+jhqfj=L7kKZZEMomB0bqWg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4d0a2af9-8966-0ad5-603b-3aad5d110c31@twiddle.net>
Date: Wed, 12 Jul 2017 09:12:36 -1000
MIME-Version: 1.0
In-Reply-To: <CAPybu_35LKPPZuQMxCSsRM+YaBd+jhqfj=L7kKZZEMomB0bqWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fix BLSR and BLSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

On 07/12/2017 08:58 AM, Ricardo Ribalda Delgado wrote:
> Hi Richard
> 
> Thanks again!, When I apply this patch I get the following error:
> 
> /tmp/qemu/tcg/tcg.c:2042: tcg fatal error

Bah.  I misremembered that OR_TMP1 is unusable in this context.


r~
