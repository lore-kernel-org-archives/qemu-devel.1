Received: from eggs.gnu.org ([2001:4830:134:3::10]:39316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5owo-0004wq-Qs
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5owl-0000pV-O4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:48:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5owl-0000ov-I9
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:48:11 -0400
Date: Tue, 10 Apr 2018 09:48:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410084801.GB5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180410054034.20479-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180410054034.20479-1-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: don't warn SDL abi if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Tue, Apr 10, 2018 at 01:40:34PM +0800, Peter Xu wrote:
> SDL has the same problem as GTK that we might get warnings on SDL ABI
> version even if SDL is disabled.  Fix that by only probing SDL if SDL i=
s
> enabled.  Also this should let configure be a little bit faster since w=
e
> don't really need to probe SDL stuff when it's off.
>=20
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Fam Zheng <famz@redhat.com>
> CC: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

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
