Received: from eggs.gnu.org ([2001:4830:134:3::10]:40061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g8FPk-0003Uk-6T
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 22:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g8FPj-00079S-GG
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 22:00:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Oct 2018 10:00:02 +0800
From: yuchenlin <yuchenlin@synology.com>
In-Reply-To: <20180913083449.GQ2526@lemon.usersys.redhat.com>
References: <20180913082952.3675-1-yuchenlin@synology.com>
	<20180913083449.GQ2526@lemon.usersys.redhat.com>
Message-ID: <4e0dfed2afdc5a551f37ecbcbf5f4ade@synology.com>
Subject: Re: [Qemu-devel] [PATCH v3] vmdk: align end of file to a sector
 boundary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Ping?

On 2018-09-13 16:34, Fam Zheng wrote:
> On Thu, 09/13 16:29, yuchenlin@synology.com wrote:
>> From: yuchenlin <yuchenlin@synology.com>
>> 
>> There is a rare case which the size of last compressed cluster
>> is larger than the cluster size, which will cause the file is
>> not aligned at the sector boundary.
>> 
>> There are three reasons to do it. First, if vmdk doesn't align at
>> the sector boundary, there may be many undefined behaviors,
>> such as, in vbox it will show VMDK: Compressed image is corrupted
>> 'syno-vm-disk1.vmdk' (VERR_ZIP_CORRUPTED) when we try to import an
>> ova with unaligned vmdk. Second, all the cluster_sector is aligned
>> to sector, the last one should be like this, too. Third, it ease
>> reading with sector based I/Os.
>> 
>> Signed-off-by: yuchenlin <yuchenlin@synology.com>
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
