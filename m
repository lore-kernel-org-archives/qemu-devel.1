Received: from eggs.gnu.org ([2001:4830:134:3::10]:34396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHX-0002KO-JQ
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHT-0003PZ-Nn
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41554
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHT-0003Ob-Hu
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:19 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJcZb9115706
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:15 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g82dpx81e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:15 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:14 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-22-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-22-armbru@redhat.com>
Date: Mon, 19 Feb 2018 12:18:48 -0600
Message-Id: <151906432849.12376.13753698623040650964@sif>
Subject: Re: [Qemu-devel] [PATCH v2 21/29] qapi/common: Fix guardname() for
 funny filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:35:59)
> guardname() fails to return a valid C identifier for arguments
> containing anything but [A-Za-z0-9_.-'].  Fix that.  Don't bother
> protecting ticklish identifiers; header guards are all-caps, and no
> ticklish identifiers are.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  scripts/qapi/common.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index de12f8469a..6e5152b173 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1867,7 +1867,7 @@ def mcgen(code, **kwds):
> =

> =

>  def guardname(filename):
> -    return c_name(filename, protect=3DFalse).upper()
> +    return re.sub(r'[^A-Za-z0-9_]', '_', filename).upper()
> =

> =

>  def guardstart(name):
> -- =

> 2.13.6
>=20
