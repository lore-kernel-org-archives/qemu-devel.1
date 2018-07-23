Received: from eggs.gnu.org ([2001:4830:134:3::10]:46343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhcCG-0005E4-VD
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhcCD-0005sL-UO
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:52:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhcCD-0005rc-O1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:52:21 -0400
References: <20180720130928.6696-1-liujunjie23@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c060312-5e49-8377-1e8a-5f86baf0eca7@redhat.com>
Date: Mon, 23 Jul 2018 09:52:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180720130928.6696-1-liujunjie23@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liujunjie <liujunjie23@huawei.com>, armbru@redhat.com
Cc: wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, weidong.huang@huawei.com, qemu-devel@nongnu.org

On 07/20/2018 08:09 AM, liujunjie wrote:
> From: l00425170 <liujunjie23@huawei.com>
> 
> The incoming parameters "start" and "end" is int type in
> qstring_from_substr(), but this function can be called by
> qstring_from_str, which is size_t type in strlen(str).
> It may result in coredump when called g_malloc later.
> One scene to triger is to call hmp "into tlb", which may have
> too long length of string.
> 
> Signed-off-by: l00425170 <liujunjie23@huawei.com>

Using what looks like a username for your Author and S-o-b designation 
rather than a legal name is fishy.  If 'l00425170' is really an alias 
that you have frequently used in other open source projects, it might be 
okay (and if so, you could back it up by pointing us to a URL of such 
contributions to other projects).  But in general, it's better to own 
your patches with your real name (git supports UTF-8, if you would like 
your name to appear in native characters instead of or in addition to a 
Latin-ized form).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
