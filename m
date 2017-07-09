Received: from eggs.gnu.org ([2001:4830:134:3::10]:57112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJ32-0005nD-Nk
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJ2z-0002j0-N6
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:43:20 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUJ2z-0002iq-GU
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:43:17 -0400
Received: by mail-pf0-x242.google.com with SMTP id e199so11797225pfh.0
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:43:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-17-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2f659019-fc55-8e22-1dd2-d2c97880c4d9@twiddle.net>
Date: Sun, 9 Jul 2017 10:43:12 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-17-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/22] tcg: keep a list of TCGContext's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> Before we make TCGContext thread-local. Once that is done, iterating
> over all TCG contexts will be quite useful; for instance we
> will need it to gather profiling info from each TCGContext.
> 
> A possible alternative would be to keep an array of TCGContext pointers.
> However this option however is not that trivial, because vCPUs are spawned in
> parallel. So let's just keep it simple and use a list protected by a lock.

Do we not know the number of cpus?  I would have thought that we did, via -smp. 
  Even cpu-hotplug would still have some sort of bounds?

Which really suggests an array would be better.


r~
