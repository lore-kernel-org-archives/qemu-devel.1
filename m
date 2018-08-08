Received: from eggs.gnu.org ([2001:4830:134:3::10]:40629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fnPTt-0006Mx-97
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fnPTs-0001gP-9L
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:30:33 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:34949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fnPTr-0001fp-Kb
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:30:31 -0400
Received: by mail-qk0-x235.google.com with SMTP id u21-v6so1652162qku.2
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 07:30:31 -0700 (PDT)
References: <153371136089.29473.12663307170219083138.malonedeb@chaenomeles.canonical.com>
	<153373459147.3443.4550096621765346347.malone@wampee.canonical.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <ac948595-187b-4caf-5fa7-e220163a41b5@gmail.com>
Date: Wed, 8 Aug 2018 11:30:27 -0300
MIME-Version: 1.0
In-Reply-To: <153373459147.3443.4550096621765346347.malone@wampee.canonical.com>
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
Cc: Greg Kurz <groug@kaod.org>, dgibson@redhat.com

Thanks Bharata!

Greg, can you take a look?



On 08/08/2018 10:23 AM, Bharata B Rao wrote:
> The first commit that causes this issue is:
>
> b94020268e0b6659499e250d25346baaa9888fed (spapr_cpu_core: migrate per-
> CPU data)
>
> Simpler way to reproduce:
> 1. Hotplug a CPU
> 2. Hot unplug it
> 3. Migrate the VM (will fail)
>
