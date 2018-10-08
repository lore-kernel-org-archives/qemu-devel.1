Received: from eggs.gnu.org ([2001:4830:134:3::10]:60020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g9M14-0008J6-A7
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g9M11-0005Aa-SG
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:15:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Oct 2018 11:15:05 +0800
From: yuchenlin <yuchenlin@synology.com>
In-Reply-To: <20181008023523.GA13536@magic>
References: <20180913082952.3675-1-yuchenlin@synology.com>
	<20180913083449.GQ2526@lemon.usersys.redhat.com>
	<4e0dfed2afdc5a551f37ecbcbf5f4ade@synology.com>
	<20181008023523.GA13536@magic>
Message-ID: <9920d0329ed9ab35fc4fe3b21609de0a@synology.com>
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

On 2018-10-08 10:38, Fam Zheng wrote:
> On Fri, 10/05 10:00, yuchenlin wrote:
>> Ping?
> 
> Hi,
> 
> This was merged as 51b3c6b73acae1e3fd3c7d441fc86dd17356695f.
> 
> Fam
> 

Hi,

Thank you for your information.

yuchenlin

>> 
>> On 2018-09-13 16:34, Fam Zheng wrote:
>> > On Thu, 09/13 16:29, yuchenlin@synology.com wrote:
>> > > From: yuchenlin <yuchenlin@synology.com>
>> > >
>> > > There is a rare case which the size of last compressed cluster
>> > > is larger than the cluster size, which will cause the file is
>> > > not aligned at the sector boundary.
>> > >
>> > > There are three reasons to do it. First, if vmdk doesn't align at
>> > > the sector boundary, there may be many undefined behaviors,
>> > > such as, in vbox it will show VMDK: Compressed image is corrupted
>> > > 'syno-vm-disk1.vmdk' (VERR_ZIP_CORRUPTED) when we try to import an
>> > > ova with unaligned vmdk. Second, all the cluster_sector is aligned
>> > > to sector, the last one should be like this, too. Third, it ease
>> > > reading with sector based I/Os.
>> > >
>> > > Signed-off-by: yuchenlin <yuchenlin@synology.com>
>> >
>> > Reviewed-by: Fam Zheng <famz@redhat.com>
>> 
