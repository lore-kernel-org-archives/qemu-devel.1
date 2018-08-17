Received: from eggs.gnu.org ([2001:4830:134:3::10]:44788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqcPR-0006Mn-Qf
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqcPR-0005aw-2T
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:55:13 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:45047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqcPQ-0005a1-Fr
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:55:12 -0400
Received: by mail-oi0-x230.google.com with SMTP id s198-v6so13241776oih.11
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 03:55:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817104706.GH11124@redhat.com>
References: <CAFEAcA-bvTeWRjBbNder0Ewf_27ksefr8djsWicEC2eMjyWSxA@mail.gmail.com>
	<20180817104706.GH11124@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 11:54:51 +0100
Message-ID: <CAFEAcA_QrEUzYp7Sjn=fdkO=4kx_Rh8XjfjNjVJ6Z_7OR693HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vm-tests images disks filling up?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 17 August 2018 at 11:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
> I'd prefer to see the test process honouring the build directory instead
> of putting stuff in /var/tmp, so that a developer's normal approach to
> cleaning up build artifacts works.

That's tricky because the build directory is outside the VM and
the build is done inside it (using a copy of the sources): the
VM doesn't have access to the build directory.

thanks
-- PMM
