Received: from eggs.gnu.org ([2001:4830:134:3::10]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clwky-0002hl-0D
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clwku-0005nr-UV
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:01:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clwku-0005n0-Oh
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:01:16 -0500
References: <20170308105409.18183-1-dgilbert@redhat.com>
	<CAFEAcA9=1c36hkJWycFWUCs5=XOATmadc=xZun7txKgJtk0NPg@mail.gmail.com>
	<20170309112635.GA2480@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad69abd5-9f15-499a-7aa5-9644d6dda337@redhat.com>
Date: Thu, 9 Mar 2017 13:01:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170309112635.GA2480@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 09/03/2017 12:26, Dr. David Alan Gilbert wrote:
>  * @name: Region name, becomes part of RAMBlock name used in migration stream
>  *        must be unique within any device

Just a note, the uniqueness constraint also applies for RAM regions only.

Paolo
