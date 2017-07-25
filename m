Received: from eggs.gnu.org ([2001:4830:134:3::10]:47441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZyU0-0000OZ-U9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZyTx-0004XO-Sn
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dZyTx-0004Wj-MG
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:58:33 -0400
References: <20170725112656.30122-1-berrange@redhat.com>
	<20170725113638.7019-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f5a11d2c-34ce-9bf6-0ad5-8cded201192c@redhat.com>
Date: Tue, 25 Jul 2017 13:58:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170725113638.7019-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 (for 2.10) 1/1] docs: document
 deprecation policy & deprecated features in appendix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 25.07.2017 13:36, Daniel P. Berrange wrote:
> The deprecation of features in QEMU is totally adhoc currently,

s/adhoc/ad hoc/

> with no way for the user to get a list of what is deprecated
> in each release. This adds an appendix to the doc that records
> when each deprecation was made and provides text explaining
> what to use instead, if anything.
>=20
> Since there has been no formal policy around removal of deprecated
> features in the past, any deprecations prior to 2.10.0 are to be
> treated as if they had been made at the 2.10.0 release. Thus the
> earliest that existing deprecations will be deleted is the start
> of the 2.12.0 cycle.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-doc.texi | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 175 insertions(+)
[...]
> +@subsection -net vlan (since 2.9.0)
> +
> +The ``-net van=3DNN'' argument is partially replaced with the

s/van/vlan/

Apart from the nits, looks fine to me now:

Reviewed-by: Thomas Huth <thuth@redhat.com>
