Received: from eggs.gnu.org ([2001:4830:134:3::10]:37884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRG54-0007BE-Oq
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRG50-0004bf-Pi
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:01:22 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRG50-0004am-CA
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:01:18 -0400
Received: by mail-ot0-x242.google.com with SMTP id w9-v6so9861913otj.7
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 05:01:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606173233.28080-1-berrange@redhat.com>
References: <20180606173233.28080-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 13:00:56 +0100
Message-ID: <CAFEAcA-XYrfRjnbQarWx5hbVoGSFEZbHt+foSpSZFf_8ONM5Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] glib: update the min required
 version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On 6 June 2018 at 18:32, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrot=
e:
> The previous patch to bump glib to 2.42 hit problems with Peter's build
> environment for testing merge:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02557.html
>
> This posting drops back to 2.40, which allows Ubuntu 14.04 from GLibC
> compile farm to be supported.
>
> It does NOT try to go back to 2.34, because it is hoped that the mxe.cc
> Debian packages will be suitable for Peter to test Windows
> cross-compile. Alternatively the docker environments provided in tree
> can be used for mingw build testing on any host able to run docker.
>
> I also dropped some more GLIB_CHECK_VERSION checks that are redundant
> given the new min version.

Note that updating to MXE is still on my todo list; I'll let
you know when I get to it...

thanks
-- PMM
