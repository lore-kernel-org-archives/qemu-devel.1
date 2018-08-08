Received: from eggs.gnu.org ([2001:4830:134:3::10]:59424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fnNXU-0001Ml-GA
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fnNXT-0007hP-Gh
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:26:08 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:37013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fnNXT-0007gy-A5
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:26:07 -0400
Received: by mail-qt0-x234.google.com with SMTP id n6-v6so2114198qtl.4
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 05:26:07 -0700 (PDT)
References: <153371136089.29473.12663307170219083138.malonedeb@chaenomeles.canonical.com>
	<153371518760.32512.1848098000707200907.malone@gac.canonical.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <6d18e318-e046-3d6d-11ec-265a0dd0c726@gmail.com>
Date: Wed, 8 Aug 2018 09:26:01 -0300
MIME-Version: 1.0
In-Reply-To: <153371518760.32512.1848098000707200907.malone@gac.canonical.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1785972] Re: v3.0.0-rc4: VM fails to start
 after vcpuhotunplug, managedsave sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1785972 <1785972@bugs.launchpad.net>, qemu-devel@nongnu.org

I'll take a look.

On 08/08/2018 04:59 AM, Satheesh Rajendran wrote:
> Bisect result:
>
> v3.0.0-rc0: vcpu hotplug crashes the domain -
> https://bugs.launchpad.net/qemu/+bug/1780928, this commit fixes that
> issue, b585395b655a6c1f9d9ebf1f0890e76d0708eed6 ppc/xics: fix ICP reset
> path
>
>
> v3.0.0-rc1- v3.0.0-rc4: hotplug crash bug fixed, but now we are hitting this one.
>
