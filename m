Received: from eggs.gnu.org ([2001:4830:134:3::10]:39929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fT4ev-0006OY-HN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fT4eu-0005K7-Jl
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:13:53 -0400
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-12-f4bug@amsat.org>
	<15d222dd-d2e9-4855-62c6-f89f2ee59c52@linaro.org>
	<76aa5170-1d18-8799-6ff1-a7c0dba0b489@redhat.com>
	<8537ca07-2645-6c2c-5945-a91da035b474@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a856ef80-fcab-0003-2bdd-89a1849fe857@redhat.com>
Date: Wed, 13 Jun 2018 07:13:43 -0500
MIME-Version: 1.0
In-Reply-To: <8537ca07-2645-6c2c-5945-a91da035b474@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/40] hw/xen: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>

On 06/12/2018 04:10 PM, Richard Henderson wrote:
>> So there's tradeoffs either way, and you at least need to document in your
>> commit messages what auditing you have done that any type changes introduced by
>> your changes are safe.
> 
> I'm more concerned about unnecessary or unintended signed vs unsigned changes
> than I am about width.  But if we're going to force a 64-bit type, use
> (int64_t)1 not 1LL.  That way the type will match the existing PRId64 printf
> markup.

Or spell it UINT64_C(1) if you don't want a cast.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
