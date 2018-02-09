Received: from eggs.gnu.org ([2001:4830:134:3::10]:39567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ek2lE-0005YZ-Da
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ek2l9-0000DA-C3
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:06:16 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:40272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ek2l9-0000Cx-7e
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:06:11 -0500
Received: by mail-vk0-f41.google.com with SMTP id h69so4287685vke.7
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 23:06:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALAZnb1PU2gFG7gsewNvqZJsPXS=qyzZsT63eMsEG+2BdqU0fA@mail.gmail.com>
References: <7e30d2cc-6c42-15e9-78ef-1085e081a386@redhat.com>
	<CAKmqyKOgFg09RAQQVfxHr2OfaNmYouhH=2nu+NT1uD87qZXzUg@mail.gmail.com>
	<b4b9f8f0-38f3-adc5-6dbb-13d5cc7cb41f@redhat.com>
	<CALAZnb1PU2gFG7gsewNvqZJsPXS=qyzZsT63eMsEG+2BdqU0fA@mail.gmail.com>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 9 Feb 2018 15:05:40 +0800
Message-ID: <CAK1Eb9kqgXyG0zRautcUkB9nBV6+wbbZg5fuL7v4DTJKfiR5iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Functional tests (AKA Avocado-based tests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Jeff Nelson <jen@redhat.com>

On Thu, Jan 18, 2018 at 5:07 PM, Amador Pahim <apahim@redhat.com> wrote:
> Expanding on that, the vmimage lib downloads and caches the so called
> "cloud images" from distros own repositories. Here's[1] some
> documentation with usage examples, including one example on how to add
> your own image provider.

Linux distributions are easy anyway, and sometimes even Docker is
simpler and good enough ($QEMU/tests/docker). Other architectures and
OS families, such as non-x86_64, BSD, Windows, macOS are all difficult
topics. $QEMU/tests/vm tried to attack that but is still not complete.
What are your thoughts on that subject?
