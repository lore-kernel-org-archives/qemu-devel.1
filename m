Received: from eggs.gnu.org ([2001:4830:134:3::10]:52536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr0Vj-00025p-9R
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr0Vi-00082K-AF
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:02:31 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr0Vi-00081P-3g
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:02:30 -0400
Received: by mail-wr0-x235.google.com with SMTP id l37so144907863wrc.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 04:02:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1a35985f-ad4b-c017-b355-51d47aaffa11@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
	<87k27hxyni.fsf@linaro.org>
	<CAFEAcA-oLDW2F=L3NCdSvrLp_eh3tu9mfKR0mTfZ=3O3dpdKbQ@mail.gmail.com>
	<1a35985f-ad4b-c017-b355-51d47aaffa11@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 11:02:08 +0000
Message-ID: <CAFEAcA9oBDYqmRpwU5B2o2X-viYrccf1V3zASYGpuaQBL866ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 23 March 2017 at 10:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
> I own a MIPS Creator ci20 board (donated by Imagination Technologies).
> I cannot give it a public IP address, but I can try and use it to do
> builds every now and then.

I think our best bet is probably to fix our test suite's
overreliance on /tmp/. Then the gcc cfarm box will probably do.

I've also had a kind offer of access to a SPARC box, which
I'm following up on.

thanks
-- PMM
