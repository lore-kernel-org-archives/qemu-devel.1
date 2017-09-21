Received: from eggs.gnu.org ([2001:4830:134:3::10]:41926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1duwhi-0006yp-FL
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1duwhf-0004rT-9Q
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:19:26 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28568
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1duwhe-0004pz-U9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:19:23 -0400
References: <1505464398-28897-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170918110846.74476f91@nial.brq.redhat.com>
	<857a7c4c-7593-2365-cee1-7d217be15817@cn.fujitsu.com>
	<81826b6c-0b4b-0b06-b354-e07bded5b7cf@cn.fujitsu.com>
	<20170921095445.78b41837@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <6e871827-7ec3-63bc-2063-38b3839e7fc0@cn.fujitsu.com>
Date: Thu, 21 Sep 2017 16:19:13 +0800
MIME-Version: 1.0
In-Reply-To: <20170921095445.78b41837@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] NUMA: Enable adding NUMA node
 implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, David Hildenbrand <david@redhat.com>, f4bug@amsat.org, Alistair Francis <alistair23@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Igor,

At 09/21/2017 03:54 PM, Igor Mammedov wrote:
> On Thu, 21 Sep 2017 12:19:17 +0800

[...]

>
> I've meant something like that:
>
> parse_numa_opts() {
>     if (mc->auto_enable_numa_with_memhp == true) {
>         qemu_opts_parse_noisily(qemu_find_opts("numa"), "node", true);
>     }
> }
>

Oops, Understood!  ;-) .

> where x86 sets mc->auto_enable_numa_with_memhp to true by default
> and sets it to false for 2.10 and older machine types.
> It will allow individual machines to enable feature if they need it
> but prevent guest ABI breakage for old machine types
> (i.e. won't break migration)
>

Got it.

> grep source for 'pcmc->legacy_cpu_hotplug = true' to see how
> this compact stuff works.
>

OK. Thank you very much.

Thanks,
	dou
