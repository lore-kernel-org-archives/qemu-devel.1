Received: from eggs.gnu.org ([2001:4830:134:3::10]:44598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crXeE-0001H9-Pl
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crXeB-0006Wu-Lt
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1crXeB-0006WC-GW
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:25:27 -0400
Date: Fri, 24 Mar 2017 18:25:26 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2057576564.7252834.1490394326811.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
References: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] win32: replace custom mutex and condition
 variable with native primitives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: qemu-devel@nongnu.org, Andrey Shedel <ashedel@microsoft.com>, Stefan Weil <sw@weilnetz.de>


> The major implication of this patch is that it drops support for
> pre-Vista versions of Windows. However, those OSes are past their end
> of life, and other OSS projects have dropped support. e.g.; the last
> Cygwin release supporting XP was in Jun 2016. It doesn't seem like a
> good tradeoff to invest effort in fixing broken code needed to support
> them, so hopefully this isn't too controversial.

Certainly fine by me!

The original reason to introduce these was that Wine didn't
support SRWLocks, but now it does.

Paolo
