Received: from eggs.gnu.org ([209.51.188.92]:46577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDsoN-0003DT-Jn
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDsoL-00006a-Sf
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:37:23 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDsoK-0008TB-2Q
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:37:21 -0400
Received: by mail-io1-xd42.google.com with SMTP id v4so14682909ioj.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:37:13 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
Date: Tue, 9 Apr 2019 11:37:10 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <98B3F0C7-6554-4455-B441-86605DA5D6C1@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
	<9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/10] block/pflash_cfi02: Add test for
 supported commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On Apr 9, 2019, at 02:13, Thomas Huth <thuth@redhat.com> wrote:

> We'd like to get rid of global_qtest in the long run (since it is
> causing trouble for tests that run multiple instances of QEMU in
> parallel, e.g. migration tests)... so if it is feasible, please don't
> use it in new code anymore. Try to use a local variable in the =
function
> that call qtest_initf() and pass the test state around via a parameter
> to the functions that need it.

One of the patches introduces a FlashConfig structure which gets passed =
around to all the functions. I could stuff the local qtest in there. The =
earlier patches would still use global_qtest. Would that be acceptable =
or would you prefer that global_qtest not appear in any of the patches?

Or rather than putting it in the FlashConfig struct, I could just pass a =
separate parameter around. Whatever you prefer.

--=20
Stephen Checkoway
