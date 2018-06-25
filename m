Received: from eggs.gnu.org ([2001:4830:134:3::10]:55480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXa1Z-0006kX-TA
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXa1W-00009S-Pt
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXa1W-000092-Jo
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:31:50 -0400
Date: Mon, 25 Jun 2018 19:31:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180625223147.GA914@localhost.localdomain>
References: <20180618101847.17251-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180618101847.17251-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] docs: add guidance on configuring CPU
 models for x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jun 18, 2018 at 11:18:47AM +0100, Daniel P. Berrang=E9 wrote:
> With the recent set of CPU hardware vulnerabilities on x86, it is
> increasingly difficult to understand which CPU configurations are
> good to use and what flaws they might be vulnerable to.
>=20
> This doc attempts to help management applications and administrators in
> picking sensible CPU configuration on x86 hosts. It outlines which of
> the named CPU models are good choices, and describes which extra CPU
> flags should be enabled to allow the guest to mitigate hardware flaws.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

This fails to build on a RHEL7 host:

# make qemu-doc.html V=3D1
LC_ALL=3DC makeinfo --no-split --number-sections -I docs -I . -I . --no-h=
eaders --html qemu-doc.texi -o qemu-doc.html
qemu-doc.texi:127: node `QEMU PC System emulator' lacks menu item for `cp=
u_models' despite being its Up target
qemu-doc.texi:605: node `cpu_models' lacks menu item for `recommendations=
_cpu_models_x86' despite being its Up target
docs/qemu-cpu-models.texi:40: node `recommendations_cpu_models_x86' lacks=
 menu item for `preferred_cpu_models_intel_x86' despite being its Up targ=
et
docs/qemu-cpu-models.texi:40: node `recommendations_cpu_models_x86' lacks=
 menu item for `important_cpu_features_intel_x86' despite being its Up ta=
rget
docs/qemu-cpu-models.texi:40: node `recommendations_cpu_models_x86' lacks=
 menu item for `preferred_cpu_models_amd_x86' despite being its Up target
docs/qemu-cpu-models.texi:40: node `recommendations_cpu_models_x86' lacks=
 menu item for `important_cpu_features_amd_x86' despite being its Up targ=
et
docs/qemu-cpu-models.texi:40: node `recommendations_cpu_models_x86' lacks=
 menu item for `default_cpu_models_x86' despite being its Up target
docs/qemu-cpu-models.texi:40: node `recommendations_cpu_models_x86' lacks=
 menu item for `other_non_recommended_cpu_models_x86' despite being its U=
p target
qemu-doc.texi:605: node `cpu_models' lacks menu item for `cpu_model_synta=
x_apps' despite being its Up target
docs/qemu-cpu-models.texi:357: node `cpu_model_syntax_apps' lacks menu it=
em for `cpu_model_syntax_qemu' despite being its Up target
docs/qemu-cpu-models.texi:357: node `cpu_model_syntax_apps' lacks menu it=
em for `cpu_model_syntax_libvirt' despite being its Up target
make: *** [qemu-doc.html] Error 1
# rpm -qf /usr/bin/makeinfo=20
texinfo-5.1-5.el7.x86_64

--=20
Eduardo
