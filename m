Received: from eggs.gnu.org ([209.51.188.92]:43894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hErR4-00047w-H1
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hErR3-0001EY-HB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:21:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hErR3-00019w-6d
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:21:21 -0400
Date: Fri, 12 Apr 2019 09:21:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190412082112.GB25308@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190411235456.12918-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411235456.12918-1-brijesh.singh@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Erik Skultety <eskultet@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

On Thu, Apr 11, 2019 at 11:55:15PM +0000, Singh, Brijesh wrote:
> There are limited numbers of the SEV guests that can be run concurrentl=
y.
> A management applications may need to know this limit so that it can pl=
ace
> SEV VMs on hosts which have suitable resources available.
>=20
> Currently, this limit is not exposed to the application. Add a new
> 'sev-max-guest' field in the query-sev-capabilities to provide this
> information.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
