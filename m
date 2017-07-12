Received: from eggs.gnu.org ([2001:4830:134:3::10]:34814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV8tj-0000tL-39
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 00:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV8tf-0001Du-RZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 00:05:11 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dV8tf-0001CO-KC
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 00:05:07 -0400
Received: by mail-pf0-x242.google.com with SMTP id e199so1534752pfh.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 21:05:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <20170711212123.4368-1-rth@twiddle.net>
Message-ID: <5316bcf4-63b5-5ce3-05d8-a6c5b75cff65@twiddle.net>
Date: Tue, 11 Jul 2017 18:04:59 -1000
MIME-Version: 1.0
In-Reply-To: <20170711212123.4368-1-rth@twiddle.net>
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
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, ricardo.ribalda@gmail.com

On 07/11/2017 11:21 AM, Richard Henderson wrote:
> I am in the process of trying to run the gcc testsuite with -mtbm,
> with and without the patchset, to see (1) if the new insns get used
> and (2) that they run ok.

FWIW, make check-gcc RUNTESTFLAGS='--target_board=unix/-mtbm execute.exp' shows 
204 failures on a host that does not support TBM, so the extension is being 
used.  A browse through exactly one of these used only bextr.  Running the same 
tests with dejagnu using qemu-x86_64 -cpu qemu64,+tbm shows zero failures.


r~
