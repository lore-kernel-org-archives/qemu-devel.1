Received: from eggs.gnu.org ([2001:4830:134:3::10]:39153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUsuE-0004PR-2K
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUsuA-0000tO-A0
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:05:10 -0400
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-12-david@redhat.com>
	<20180618140308.0fe78716@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9ab8d32c-a558-b460-67ad-a7c6fea638b6@redhat.com>
Date: Mon, 18 Jun 2018 14:04:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180618140308.0fe78716@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/13] nvdimm: allow setting the
 label-size to 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On 18.06.2018 14:03, Igor Mammedov wrote:
> On Fri, 15 Jun 2018 16:04:46 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> It is inititally 0, so setting it to 0 should be allowed, too.
> I'm not sure if we need to permit it.
> By default labels are disabled (label-size=0) and user are supposed to provide
> this option if labels should be enabled with a valid size. 
> 
> it could be confusing for user when asking for label and not getting it.
> 
> I suggest to drop this patch, it's not really related to this series
> nor required for your future work.
> 

As I just want to finally get this stuff off my table, I agree to
whatever you say.


-- 

Thanks,

David / dhildenb
