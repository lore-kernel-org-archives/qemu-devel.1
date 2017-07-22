Received: from eggs.gnu.org ([2001:4830:134:3::10]:48267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYrhi-0002Gk-CR
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 06:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYrhf-0005ky-A5
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 06:32:10 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:34637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dYrhf-0005jh-4b
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 06:32:07 -0400
Received: by mail-pf0-x22d.google.com with SMTP id q85so32224730pfq.1
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 03:32:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-4-rth@twiddle.net> <87tw25ifkh.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <20d65af7-b33b-a9db-9e55-8b56fc83ab70@twiddle.net>
Date: Sat, 22 Jul 2017 00:31:55 -1000
MIME-Version: 1.0
In-Reply-To: <87tw25ifkh.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v14 03/34] target/i386: Use generic DISAS_*
 enumerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com

On 07/21/2017 12:35 PM, Lluís Vilanova wrote:
>> +#define DISAS_TOO_MANY 5
> 
> Why is this one not added as a generic define too (like DISAS_NORETURN in prev
> patch)?

Because I use NORETURN in the arm cleanup, prior to conversion to the enum, 
whereas I do not use TOO_MANY outside the i386 port.  I suppose I could have, 
but at this stage it doesn't really matter, as it only lives 4 more patches til 
the generic enum comes in.


r~
