Received: from eggs.gnu.org ([2001:4830:134:3::10]:40128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctbdT-0003F8-1P
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctbdN-0007y6-Gh
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:05:15 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctbdN-0007vo-9i
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:05:09 -0400
Received: by mail-lf0-x22e.google.com with SMTP id z15so29105072lfd.1
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 08:05:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170329111620.GH10462@stefanha-x1.localdomain>
References: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
	<20170329111620.GH10462@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 16:04:47 +0100
Message-ID: <CAFEAcA_7xhcDo-cfZzgZLwnov+2VE1LOiQsjUFKDUrStt3pYRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>

On 29 March 2017 at 12:16, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Wed, Mar 29, 2017 at 12:53:24AM +0200, Samuel Thibault wrote:
>> The following changes since commit df9046363220e57d45818312759b954c033c58ab:
>>
>>   Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)
>>
>> are available in the git repository at:
>>
>>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>>
>> for you to fetch changes up to a2f80fdfc683019901cdf4c0863a5920c0ca7245:
>>
>>   slirp: Send RDNSS in RA only if host has an IPv6 DNS server (2017-03-29 00:51:25 +0200)
>>
>> ----------------------------------------------------------------
>> slirp updates
>>
>> ----------------------------------------------------------------
>> Laurent Vivier (1):
>>       slirp: fix compilation errors with DEBUG set
>>
>> Samuel Thibault (2):
>>       slirp: Make RA build more flexible
>>       slirp: Send RDNSS in RA only if host has an IPv6 DNS server
>>
>>  slirp/ip6_icmp.c | 47 ++++++++++++++++++++++-------------------------
>>  slirp/slirp.c    |  2 +-
>>  2 files changed, 23 insertions(+), 26 deletions(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Applied, thanks.

-- PMM
