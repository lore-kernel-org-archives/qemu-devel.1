Received: from eggs.gnu.org ([2001:4830:134:3::10]:40143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cPPfj-0005l5-Cg
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cPPff-0006nt-DV
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:14:47 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cPPff-0006nM-6n
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:14:43 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so3119398wmi.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 00:14:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <a50ea1f9-4167-cc3f-f81c-61bd6a1853b7@freebsd.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d362b1ba-0c36-bc68-44e5-b3e55f3853e9@redhat.com>
Date: Fri, 6 Jan 2017 09:14:39 +0100
MIME-Version: 1.0
In-Reply-To: <a50ea1f9-4167-cc3f-f81c-61bd6a1853b7@freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [scripts] default shell/perl locations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Bruno <sbruno@freebsd.org>, qemu-devel@nongnu.org



On 05/01/2017 23:41, Sean Bruno wrote:
> I don't suppose it would be possible to have configure check/change the
> interpreter path for scripts so that operating systems that don't have
> /usr/bin/perl for example, would work out of the box?

We can use

#!/bin/sh
eval 'exec perl -x -wS $0 ${1+"$@"}'
    if 0;

if that works for you.

Paolo
