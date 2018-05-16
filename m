Received: from eggs.gnu.org ([2001:4830:134:3::10]:45691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIttH-00068W-4F
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIttG-0003SY-Dj
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:42:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIttG-0003SM-7z
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:42:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C95F777060
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 10:42:37 +0000 (UTC)
References: <20180417140802.16711-1-pbonzini@redhat.com>
	<0a51d026-8b9f-9925-1229-10e3766907bb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02617670-8b06-e5b9-d763-65453b5f706a@redhat.com>
Date: Wed, 16 May 2018 12:42:36 +0200
MIME-Version: 1.0
In-Reply-To: <0a51d026-8b9f-9925-1229-10e3766907bb@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] exec: reintroduce MemoryRegion caching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org

On 16/05/2018 12:41, Auger Eric wrote:
> This patch seems to cause a regression with ARM vsmmu +
> virtio-blk-pci. Reverting it looks to fix the issue. Otherwise I
> get:

What's the command line for a reproducer?

Thanks,

Paolo
