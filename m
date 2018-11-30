Received: from eggs.gnu.org ([2001:4830:134:3::10]:43826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSfWu-0006Q6-UG
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSfWr-0006j6-CJ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:56:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSfWr-0006hF-10
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:56:09 -0500
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
	<20181130095450.GC8101@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0070dd1f-eb02-53a9-ca20-a98a50cf0bce@redhat.com>
Date: Fri, 30 Nov 2018 10:56:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181130095450.GC8101@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] test: replace gtester with a
 TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 30/11/18 10:54, Daniel P. Berrang=C3=A9 wrote:
> FYI, for docs about the TAP protocol see:
>=20
>    https://testanything.org/tap-specification.html
>=20
> I've always liked the TAP protocol approach to test output where you pr=
int
> an ok/not ok  status for each piece of the test, as opposed to assertio=
n
> style tests where you just abort at the first piece that fails.=20

FWIW, this is not what this series does.  Each ok/not ok line
corresponds to one assertion-style test.

Paolo
