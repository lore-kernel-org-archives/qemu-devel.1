Received: from eggs.gnu.org ([2001:4830:134:3::10]:53883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0Svd-0003GH-9w
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0Sva-0000TJ-Jt
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:49:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g0Sva-0000Sz-Dk
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:49:06 -0400
References: <1536814370-12997-1-git-send-email-zhangckid@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad44caaa-c588-f730-2c6b-dc6896a1cea5@redhat.com>
Date: Thu, 13 Sep 2018 09:49:03 -0500
MIME-Version: 1.0
In-Reply-To: <1536814370-12997-1-git-send-email-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V12-fix 01/19] filter-rewriter: Add TCP
 state machine and fix memory leak in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

On 9/12/18 11:52 PM, Zhang Chen wrote:
> We add almost full TCP state machine in filter-rewriter, except
> TCPS_LISTEN and some simplify in VM active close FIN states.
> The reason for this simplify job is because guest kernel will track
> the TCP status and wait 2MSL time too, if client resend the FIN packet,
> guest will resend the last ACK, so we needn't wait 2MSL time in filter-rewriter.
> 
> After a net connection is closed, we didn't clear its releated resources

s/releated/related/

> in connection_track_table, which will lead to memory leak.
> 
> Let't track the state of net connection, if it is closed, its related

s/Let't/Let's/

> resources will be cleared up.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

Should both of these last two S-o-b be present?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
