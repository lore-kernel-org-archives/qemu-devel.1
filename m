Received: from eggs.gnu.org ([2001:4830:134:3::10]:56974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxK6-0006Eq-4W
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxK5-0008Vu-C7
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:33:38 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:32927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHxK5-0008Vg-7v
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:33:37 -0500
Received: by mail-vk0-x236.google.com with SMTP id 137so93268450vkl.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 10:33:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161209114830.9158-3-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
	<20161209114830.9158-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 18:33:16 +0000
Message-ID: <CAFEAcA9-pAKxcNjNxiEpewF8Fq2zRWfvdRb7GyyNaBnXvDSqmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v3 02/10] aarch64: add hand-coded risu
 skeleton for directed testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

On 9 December 2016 at 11:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Sometimes you want absolute control over your test set-up to feed
> explicit values into the test. This started as an experiment but might
> be useful for further developing tests.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I really don't like this patch, I'm afraid. I'd rather not have
it in the tree, because it implies that we expect that people
might want to write (or contribute back to us) handcoded test cases.
I don't think we should be encouraging that at all.

I only wrote the test_i386.s and test_arm.s originally because I hadn't
yet written the risugen script and wanted to test the C code I'd written.
Perhaps we should delete them now as being obsolete...

thanks
-- PMM
