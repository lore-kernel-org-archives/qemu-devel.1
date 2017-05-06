Received: from eggs.gnu.org ([2001:4830:134:3::10]:52990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6uwh-000682-V0
	for qemu-devel@nongnu.org; Sat, 06 May 2017 04:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6uwe-0000kH-Ky
	for qemu-devel@nongnu.org; Sat, 06 May 2017 04:20:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6uwe-0000jd-FM
	for qemu-devel@nongnu.org; Sat, 06 May 2017 04:20:04 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AC943D95F
	for <qemu-devel@nongnu.org>; Sat,  6 May 2017 08:20:03 +0000 (UTC)
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52cabd40-1478-d200-4455-a3c87414deb4@redhat.com>
Date: Sat, 6 May 2017 10:20:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170503223846.6559-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Memory leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 04/05/2017 00:38, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> A new series of leaks spotted by ASAN. Mostly after introducing of the
> test-hmp. Would it be useful having a configure --enable-asan, and
> enabled by default with --enable-debug?

Yes, --enable-asan would be a nice idea, and we can also add a build
target for Docker tests.

Paolo
