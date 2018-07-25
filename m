Received: from eggs.gnu.org ([2001:4830:134:3::10]:40313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fiIm5-0005j7-1C
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fiIm2-0001i1-02
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fiIm1-0001gS-RL
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:09 -0400
References: <20180713075232.9575-1-pagupta@redhat.com>
	<20180713075232.9575-4-pagupta@redhat.com>
	<783786ae-2e85-2376-448c-1e362c3d4d48@redhat.com>
	<399916154.53931292.1532494899706.JavaMail.zimbra@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d3fe397a-024d-faf7-8854-bb8e9ea17f53@redhat.com>
Date: Wed, 25 Jul 2018 07:19:53 -0500
MIME-Version: 1.0
In-Reply-To: <399916154.53931292.1532494899706.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, riel@surriel.com, niteshnarayanlal@hotmail.com, david@redhat.com, ross zwisler <ross.zwisler@intel.com>, lcapitulino@redhat.com, hch@infradead.org, mst@redhat.com, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com

On 07/25/2018 12:01 AM, Pankaj Gupta wrote:

>>
>> This patch has no n/M in the subject line; but is included in a thread
>> that also has a 0/2 cover letter, as well as 1/2 and 2/2 patches in
>> separate mails.  Is that intentional?
> 
> Yes, kernel series has 0-2 patches and Qemu has this one. I thought its
> good to keep separate numbering for both the sets.

Ah, that makes sense. The cover letter didn't make it obvious to me that 
this was two separate series to two projects, but related enough that 
both series have to be incorporated for the feature to work and thus 
cross-posted under a single cover letter.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
