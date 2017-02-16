Received: from eggs.gnu.org ([2001:4830:134:3::10]:47131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceHbA-00043Y-Dp
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 03:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceHb5-0000ln-Fo
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 03:39:32 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceHb5-0000kt-8W
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 03:39:27 -0500
Received: by mail-wm0-x242.google.com with SMTP id r18so1928522wmd.3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 00:39:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
	<20170215153306.GF16064@stefanha-x1.localdomain>
	<58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
Date: Thu, 16 Feb 2017 09:39:28 +0100
MIME-Version: 1.0
In-Reply-To: <58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSN77yaIFJlOiBbUkZDXSB2aXJ0aW8tZmM6?=
 =?utf-8?q?_draft_idea_of_virtual_fibre_channel_HBA?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Zhiqiang Zhou <ZZhou@suse.com>, Fam Zheng <famz@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, hare@suse.de, stefanha@redhat.com



On 16/02/2017 08:16, Lin Ma wrote:
>> What are the benefits of having FC access from the guest?
> 
> Actually, I havn't dug it too much, Just thought that from virtualization's
> perspective, when interact with FC storage, having complete FC access
> from the guest is the way it should use.

How much of this requires a completely new spec?  Could we get enough of
the benefit (e.g. the ability to issue rescans or LIPs on the host) by
extending virtio-scsi?

Paolo
