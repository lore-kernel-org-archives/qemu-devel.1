Received: from eggs.gnu.org ([2001:4830:134:3::10]:54936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSMpk-00045V-Po
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSMpi-0002pN-3D
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:21:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dSMph-0002pF-Sp
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:21:34 -0400
References: <20170704111404.28569-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f22d82b6-cd4b-b71c-179e-2f590ddb19b8@redhat.com>
Date: Tue, 4 Jul 2017 14:21:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170704111404.28569-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Document deprecated features &
 support lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 04.07.2017 13:14, Daniel P. Berrange wrote:
[...]
>  - Not listing the '-6' and '-e' args to qemu-img create. Those
>    were never deprecations, because the functionality was
>    immediately turned into a fatal error.
How did you come to that conclusion? As far as I can see, the -6 option
has been added by commit ec36ba14748e140dda2 and that was part of QEMU
v0.10. The deprecation was done in commit eec77d9e712bd415 and that was
part of QEMU v0.14.

 Thomas
