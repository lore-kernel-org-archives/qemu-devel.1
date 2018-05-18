Received: from eggs.gnu.org ([2001:4830:134:3::10]:43465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJZl3-0006GF-BB
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fJZl0-0005LC-Nb
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:24:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fJZl0-0005Jq-I0
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:24:54 -0400
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180504030811.28111-6-peterx@redhat.com>
	<99897d3c-ee46-977d-c886-5d23996c7f04@redhat.com>
	<20180518055939.GE2569@xz-mi>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <601036e5-a1b8-9afe-714e-e5d76e06a6d5@redhat.com>
Date: Fri, 18 May 2018 09:24:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180518055939.GE2569@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/10] intel-iommu: introduce
 vtd_page_walk_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

Hi Peter,
On 05/18/2018 07:59 AM, Peter Xu wrote:
> On Thu, May 17, 2018 at 04:32:58PM +0200, Auger Eric wrote:
>> Hi Peter,
>>
>> On 05/04/2018 05:08 AM, Peter Xu wrote:
>>> During the recursive page walking of IOVA page tables, some stack
>>> variables are constant variables and never changed during the whole page
>>> walking procedure.  Isolate them into a struct so that we don't need to
>>> pass those contants down the stack every time and multiple times.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks for the r-b, but this patch is changed in version 3.  Please
> feel free to have a look at that version.

Sure. Please apologize, I missed your v3. Looking at it now.

Thanks

Eric
> 
> (For all the review comments previously to version 2, I adopted them
>  when the contents are still there in version 3)
> 
> Regards,
> 
