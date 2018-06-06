Received: from eggs.gnu.org ([2001:4830:134:3::10]:55293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQcvG-0000bS-JR
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQcvD-0002ID-Dj
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:12:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37122 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fQcvD-0002Hn-8w
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:12:35 -0400
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-2-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fa882626-6066-bda1-2919-95c1bfbf689d@redhat.com>
Date: Wed, 6 Jun 2018 14:12:33 -0400
MIME-Version: 1.0
In-Reply-To: <20180606173233.28080-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] glib: bump min required glib
 library version to 2.40
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 06/06/2018 01:32 PM, Daniel P. Berrang=C3=A9 wrote:
> Per supported platforms doc, the various min glib on relevant distros i=
s:

Which doc?

>=20
>   RHEL-7: 2.50.3
>   Debian (Stretch): 2.50.3
>   Debian (Jessie): 2.42.1
>   OpenBSD (Ports): 2.54.3
>   FreeBSD (Ports): 2.50.3
>   OpenSUSE Leap 15: 2.54.3
>   Ubuntu (Xenial): 2.48.0
>   macOS (Homebrew): 2.56.0
>=20
> This suggests that a minimum glib of 2.42 is a reasonable target.

Looks like useful info to check in somewhere -- though I suppose the
commit message counts.

--js
