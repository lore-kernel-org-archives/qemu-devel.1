Received: from eggs.gnu.org ([2001:4830:134:3::10]:54464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUrlS-00089u-Rh
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUrlP-0005Cc-Qs
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:52:02 -0400
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-11-david@redhat.com>
	<20180618004950.GH25461@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <de83299d-8183-f69e-ee5b-203a0ed7c491@redhat.com>
Date: Mon, 18 Jun 2018 12:51:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180618004950.GH25461@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/13] nvdimm: convert nvdimm_mr into a
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>

On 18.06.2018 02:49, David Gibson wrote:
> On Fri, Jun 15, 2018 at 04:04:45PM +0200, David Hildenbrand wrote:
>> This way we can easily check if the region has already been inititalized
>> without having to rely on the size of an uninitialized region being 0.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> I'm not terribly convinced that this is a worthwhile change, but in
> the sense that the patch appears to be technically correct:
> 

Igor requested this, and as I had no strong feelings about it, I
included it. At least we are not able to hand out "uninitialized
regions" this way anymore.

Thanks!

-- 

Thanks,

David / dhildenb
