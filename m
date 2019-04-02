Received: from eggs.gnu.org ([209.51.188.92]:44057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBLAP-0006lF-Eb
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBLAO-0003za-H2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:17:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBLAO-0003yZ-73
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:17:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
	<20190311060823.18360-2-richardw.yang@linux.intel.com>
	<87pnq4hq6z.fsf@dusky.pond.sub.org>
	<20190402150710.gz4rs3rn4sy7khcl@master>
Date: Tue, 02 Apr 2019 17:17:32 +0200
In-Reply-To: <20190402150710.gz4rs3rn4sy7khcl@master> (Wei Yang's message of
	"Tue, 2 Apr 2019 15:07:10 +0000")
Message-ID: <87sgv08mib.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] vl.c: make find_default_machine() local
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>, ehabkost@redhat.com, qemu-devel@nongnu.org

Wei Yang <richard.weiyang@gmail.com> writes:

> On Tue, Apr 02, 2019 at 08:33:08AM +0200, Markus Armbruster wrote:
>>Wei Yang <richardw.yang@linux.intel.com> writes:
>>
>>> Function find_default_machine() is introduced by commit 2c8cffa599b7
>>> "vl: make find_default_machine externally visible", while it seems no
>>> one outside use it.
>>It was used outside of vl.c until commit a904410af5f.
>>
>>> This patch make it local again.
>>
>>Suggest:
>>
>>  Commit a904410af5f removed the only user of find_default_machine()
>>  outside vl.c, but neglected to make it static.  Do that now.
>>
>
> Markus
>
> Thanks for your comments.
>
> BTW, I think I need to spin a v2, right?

A v2 with the review comments addressed and my two patches included
would help.
