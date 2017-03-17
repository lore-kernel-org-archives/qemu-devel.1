Received: from eggs.gnu.org ([2001:4830:134:3::10]:56528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coous-0007p2-PS
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coour-0004BL-JX
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:15:26 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coour-0004BE-Cx
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:15:25 -0400
Received: by mail-wr0-x230.google.com with SMTP id g10so48746340wrg.2
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 03:15:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317101257.GB8050@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316154643.GT15193@redhat.com>
	<CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
	<0f504dd2-235b-7ada-98b2-e0ccbd376fa7@redhat.com>
	<7e86352b-add7-7b73-4e6b-08016b3e7a5d@redhat.com>
	<20170317101257.GB8050@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 10:15:03 +0000
Message-ID: <CAFEAcA9vYs2aCaDON6FDBzG9P8Vo73e3o1NfC=W4FbGQPSVapg@mail.gmail.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 March 2017 at 10:12, Daniel P. Berrange <berrange@redhat.com> wrote:
> In the mail thread two months back Sean Bruno did suggest he might like
> to just start over with bsd-user:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00171.html
>
> So perhaps someone should just ping him to see if he objects to us
> deleting bsd-usr now (on off chance he's got patches nearly ready to
> fix it)

It's because Sean is (on-and-off) still around that I'm not
very inclined to delete bsd-user. We actually have somebody
who cares about the code, which means we should move it into
tier 1, not dump it into tier 3 and delete.

thanks
-- PMM
