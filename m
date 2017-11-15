Received: from eggs.gnu.org ([2001:4830:134:3::10]:37348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eEmWO-0007S0-9H
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eEmWK-0000Lv-OI
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:29:44 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36506
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eEmWK-0000Jw-DT
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:29:40 -0500
References: <1510626841-9928-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20171114163050.70c752bd@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <e718178a-e42d-ce5c-0037-d27c08a3990e@cn.fujitsu.com>
Date: Wed, 15 Nov 2017 09:29:22 +0800
MIME-Version: 1.0
In-Reply-To: <20171114163050.70c752bd@nial.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6] NUMA: Enable adding NUMA node implicitly
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

[...]
>> +            parse_numa_node(ms, &node, NULL);
> I get build break here:
>
> numa.c:451:13: error: too few arguments to function ‘parse_numa_node’
>              parse_numa_node(ms, &node, NULL);
>

In upstream tree, your commit

   cc001888b780 ("numa: fixup parsed NumaNodeOptions earlier")

removed a argument from parse_numa_node() recently. this definition
of function becomes

static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                             Error **errp)

this patch is based on the upstream tree, parse_numa_node() should have
three arguments.

I am not sure why you got this building failure log, can you tell me
which branch did you test?

Thanks,
	dou
