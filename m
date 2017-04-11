Received: from eggs.gnu.org ([2001:4830:134:3::10]:37745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cxwLA-00088z-Kh
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cxwL7-0000IX-I1
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:00:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cxwL7-0000I1-C4
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:00:13 -0400
References: <20170411080154.12474.20009.malonedeb@gac.canonical.com>
	<20170411082140.1520.57032.malone@chaenomeles.canonical.com>
	<CAOGPPbctB_RKy1G9+MuKwVN7T7hn6dwKuQ27hVpoVWX8CVyhYg@mail.gmail.com>
	<20170411135700.GM4516@noname.str.redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <fe15d207-3e01-dd4a-737d-1a3e1acd2f15@redhat.com>
Date: Tue, 11 Apr 2017 16:00:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170411135700.GM4516@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1681688] Re: qemu live migration failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, 858585 jemmy <jemmy858585@gmail.com>
Cc: Bug 1681688 <1681688@bugs.launchpad.net>, qemu-devel@nongnu.org

On 11/04/2017 15:57, Kevin Wolf wrote:
> Am 11.04.2017 um 15:35 hat 858585 jemmy geschrieben:
>> Hi Kevin:
>>    Can you provide some information about the original bug which you want fix?
>>
>>    the original comment:
>>    Usually guest devices don't like other writers to the same image, so
>>    they use blk_set_perm() to prevent this from happening.
>>
>>    i don't find where the dest qemu will use blk_set_perm during migration.
>>    but after apply this patch, blkconf_apply_backend_options don't update the
>>    blk->root->perm.
> 
> Do I understand correctly that this is not simply live migration, but
> block live migration (with 'migrate -b')?
> 
> Can you please post a backtrace not of the successful case, but of the
> failing assertion?

Kevin,

I've also reproduced this problem without the block live migration while
I was testing my patch to fix the virtio-rng migration.

Laurent
