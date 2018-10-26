Received: from eggs.gnu.org ([2001:4830:134:3::10]:33065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFyy2-0004bl-Ii
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFyxw-0003Ne-LX
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:03:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gFyxw-0003N7-Bw
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:03:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so861912wme.5
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 03:03:40 -0700 (PDT)
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
	<nycvar.YSQ.7.76.1810261213001.8270@xnncv>
	<20181026094208.GD31390@redhat.com> <20181026095943.GG31390@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e377111-8b95-c65a-e456-a7a8a4580ecb@redhat.com>
Date: Fri, 26 Oct 2018 12:03:35 +0200
MIME-Version: 1.0
In-Reply-To: <20181026095943.GG31390@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, P J P <ppandit@redhat.com>
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 26/10/2018 11:59, Daniel P. Berrangé wrote:
> I should also say that QEMU as an upstream project has multiple goals.
> Running KVM guests with modern PV hardware is only one of them, albeit
> a widely used one. Being able to run old legacy OS with old hardware,
> and running arbitrary embedded boards/devices with emulation are both
> use cases that QEMU project aims to address. To eliminate all the old
> "crufty" device emulation in name of improving security for KVM, would
> be to eliminate core use cases of the project. THis is why we're trying
> to persue the direction of making it easier for vendors to disable
> features and devices they don't wish to support & thus limit their
> downstream CVE exposure.

Indeed.  If we had to deprecate a feature just because it had an
off-by-one bug, no C program would grow beyond 1000 lines of code...

Paolo
