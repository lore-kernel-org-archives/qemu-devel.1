Received: from eggs.gnu.org ([2001:4830:134:3::10]:46667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffsEM-0000ow-Nf
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffsEH-0002Cf-No
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:35:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffsEH-0002C4-GM
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:35:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so3979684wmf.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 12:35:17 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180711152737.GR31228@stefanha-x1.localdomain>
	<874lgwlb3w.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a4160e4-a6f3-3e85-005d-ac968d2d425b@redhat.com>
Date: Wed, 18 Jul 2018 21:35:13 +0200
MIME-Version: 1.0
In-Reply-To: <874lgwlb3w.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 18/07/2018 19:14, Markus Armbruster wrote:
>> The main challenge to me seems "how can we make tests simpler?".  The
>> presence of a new API and object model raises the bar for writing and
>> running tests.  I hope all qtests will use qgraph but if the complexity
>> is too high then qgraph may only be used in a few niche cases where
>> authors think it's worth abstracting machine types and others will
>> continue to write qtests without qgraph.
> The #1 reason for writing code a certain way is following existing
> examples.  As long as "qtest without qgraph" is prevalent in existing
> tests, it'll remain prevalent in new tests.  I'm afraid we'll need a
> conversion effort.
> 

Indeed, Emanuele is already working on converting virtio-serial tests
(virtio is possibly the largest part of libqos).  The various nop tests
are also more or less trivial to adjust.

Paolo
