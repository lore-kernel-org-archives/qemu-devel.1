Received: from eggs.gnu.org ([2001:4830:134:3::10]:46626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cR3Xi-0003rG-AX
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 16:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cR3Xf-0002lm-B0
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 16:01:18 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cR3Xf-0002lN-3j
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 16:01:15 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so12279920wmr.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 13:01:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<20170110165105.GR27720@redhat.com>
	<80b19297-00c4-f109-dd4f-9d2b41ee618c@redhat.com>
	<20170110183630.GA6628@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0ff9866-2001-a028-09ae-98ba0ad3693b@redhat.com>
Date: Tue, 10 Jan 2017 22:01:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170110183630.GA6628@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 10/01/2017 19:36, Daniel P. Berrange wrote:
> 
> It seems you're saying we should also trim the top level dirs, so
> we in fact get:
> 
> 
> -I/home/berrange/src/virt/qemu/hw/scsi
> -Ihw/scsi
> -I/home/berrange/src/virt/qemu/tcg
> -I/home/berrange/src/virt/qemu/tcg/i386
> -I/home/berrange/src/virt/qemu/linux-headers
> -I/home/berrange/src/virt/qemu-build/linux-headers
> -I/home/berrange/src/virt/qemu/include

Yes, and ultimately tcg too.

Paolo
