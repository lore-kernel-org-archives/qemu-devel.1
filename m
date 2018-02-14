Received: from eggs.gnu.org ([2001:4830:134:3::10]:57513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elxjS-0005l7-3B
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elxjN-000350-8P
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:08:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1elxjN-00034e-1k
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:08:17 -0500
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180213173429.19501-2-stefanha@redhat.com>
	<20180213180918.GY573@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <adc8d85b-2e7c-e00e-4eba-515327e48699@redhat.com>
Date: Wed, 14 Feb 2018 15:08:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180213180918.GY573@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 13/02/2018 19:09, Daniel P. Berrang=C3=A9 wrote:
> Why is a custom entry needed for block here (and other things
> below).   Won't running get_maintainer.pl already correctly
> report when a patch needs cc'ing to qemu-block@nongnu.org
> based on MAINTAINER rules ?

Sometimes you want to CC block people even on a non-block patch, for
example if you want their opinion about using the API.

We should probably add at least arm and ppc profiles, too.

> --nogit --nogit-fallback

QEMU's getmaintainer (unlike the Linux version!) already tries to avoid
falling back to git if a maintainer is listed.  Are these options necessa=
ry?

Paolo
