Received: from eggs.gnu.org ([2001:4830:134:3::10]:42330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRMnO-0004pP-HX
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRMnL-0007cA-Fw
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:34:46 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRMnL-0007bY-9j
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:34:43 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so37787455wmi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 09:34:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<eabc1ecd-439c-69cc-facb-281699a4d26e@redhat.com>
	<20170111171202.GG9269@stefanha-x1.localdomain>
	<20170111171646.GR12072@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d64c194-bb64-9ac2-3281-9a9329f6a52b@redhat.com>
Date: Wed, 11 Jan 2017 18:34:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170111171646.GR12072@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org



On 11/01/2017 18:16, Daniel P. Berrange wrote:
> I've been trying to get such relative includes to work most of today
> and not having much luck. The problem is that while it works in 95%
> of the time, there are some source files and header files which need
> to include trace.h files not in their local directory

Which are they?  I wouldn't have expected that to happen.

> and we can't
> use relative includes for that, since the relative include gets
> resolved wrt the source file doing the #include, but the trace.h
> file is in $BUILD_DIR.

Why would #include "../foo/trace.h" be resolved against the source
file's path only, and not against all -I directories?

Paolo
