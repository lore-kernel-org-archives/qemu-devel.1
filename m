Received: from eggs.gnu.org ([2001:4830:134:3::10]:52439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVMcU-0005kb-Gn
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVMcR-0000dL-Fe
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:44:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVMcR-0000cV-B8
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:44:15 -0400
Received: by mail-qk0-f194.google.com with SMTP id q66so5189938qki.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 11:44:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170711212123.4368-1-rth@twiddle.net>
	<5316bcf4-63b5-5ce3-05d8-a6c5b75cff65@twiddle.net>
	<CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <66a7981d-4938-eea9-ef7a-c7622596eaf6@twiddle.net>
Date: Wed, 12 Jul 2017 08:43:07 -1000
MIME-Version: 1.0
In-Reply-To: <CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] target/i386: Implement all TBM
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com

On 07/12/2017 03:28 AM, Ricardo Ribalda Delgado wrote:
> Hi Richard
> 
> Thanks for your patch! I have applied it to my tree, but i still get
> SIGSEGV. I think that I might have found the problem. It seems to be
> related to the bmi instruction blsr, which seems to be not properly
> implemented.

You're absolutely right.


r~
