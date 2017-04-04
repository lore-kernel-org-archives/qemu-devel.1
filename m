Received: from eggs.gnu.org ([2001:4830:134:3::10]:50165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvSNw-00060A-8W
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvSNt-0005AT-6e
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvSNt-0005AL-1O
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:36:49 -0400
Date: Tue, 4 Apr 2017 14:36:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170404173645.GX1910@thinpad.lan.raisama.net>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-5-alex.bennee@linaro.org>
	<ac3d8bc5-d4e1-6313-f1a2-7cc4867cd153@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ac3d8bc5-d4e1-6313-f1a2-7cc4867cd153@twiddle.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v1 4/9] target/i386/misc_helper: wrap
 BQL around another IRQ generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, dovgaluk@ispras.ru, pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com

On Tue, Apr 04, 2017 at 09:53:15AM -0700, Richard Henderson wrote:
> On 04/03/2017 05:45 AM, Alex Benn=E9e wrote:
> > Anything that calls into HW emulation must be protected by the BQL.
> >=20
> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > ---
> >  target/i386/misc_helper.c | 3 +++
> >  1 file changed, 3 insertions(+)
>=20
> Reviewed-by: Richard Henderson <rth@twiddle.net>

In case somebody is going to queue the whole series in one take:

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
