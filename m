Received: from eggs.gnu.org ([2001:4830:134:3::10]:46051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHGpz-0002OD-Rt
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHGpw-00053r-R8
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:48:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fHGpw-00052k-Lm
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:48:28 -0400
Date: Fri, 11 May 2018 19:48:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180511224823.GR13350@localhost.localdomain>
References: <20180504160026.14017-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180504160026.14017-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Requiring Python 2.7+ (was Re: [PATCH 0/3] Document
 intent for supported build platforms and bump min glib to 2.42)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, May 04, 2018 at 05:00:23PM +0100, Daniel P. Berrang=E9 wrote:
[...]
> Based on that doc and https://repology.org/metapackage/glib/versions,
> I identified that we could feasibly set min glib to 2.42. Note that
> this would be dropping RHEL-6 as a build host (RHEL-6.0 came out in
> 2010 so that's reasonable to drop IMHO). It would still cover 2 major
> Debian versions and 2 most recent Ubuntu LTS (16.04, 18.04, but *not*
> 14.04). This min glib lets us remove almost all our compat code.

If we're dropping RHEL-6, is there anything else blocking us from
bumping the minimum required Python versino to 2.7?

>From the wording on patch 1/3, it looks like we will drop support
for SLES-11 too?

--=20
Eduardo
