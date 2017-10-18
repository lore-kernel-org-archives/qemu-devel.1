Received: from eggs.gnu.org ([2001:4830:134:3::10]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4jTf-00028l-CI
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4jTb-0007SA-DX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:13:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e4jTb-0007RP-6w
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:13:19 -0400
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-2-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1a8c195e-2ffe-20bf-555d-20ea50358f1b@redhat.com>
Date: Wed, 18 Oct 2017 10:13:16 +0200
MIME-Version: 1.0
In-Reply-To: <20171017140453.51099-2-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/7] s390x/css: be more consistent if
 broken beyond repair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 17.10.2017 16:04, Halil Pasic wrote:
> Calling do_subchannel_work with no function control flags set in SCSW i=
s
> a programming error. Currently the handle this differently in
> do_subchannel_work_virtual and do_subchannel_work_passthrough. Let's be
> consistent and guard with a common assert against this programming erro=
r.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> Already applied to Connies s390-next. Included for the sake of complete=
nes
> (with) the old typo in the commit message.

Looks like Cornelia fixed it up in s390-next :-)

> ---
>  hw/s390x/css.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

FWIW:

Reviewed-by: Thomas Huth <thuth@redhat.com>
