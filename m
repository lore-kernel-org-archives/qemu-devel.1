Received: from eggs.gnu.org ([2001:4830:134:3::10]:50263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqMRp-0004hv-Rm
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqMRm-0002oI-MY
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:15:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51773
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cqMRm-0002nX-FD
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:15:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2LGDdox086269
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 12:15:45 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb3kuv4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 12:15:44 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 21 Mar 2017 12:15:44 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170321120326.10011-1-sameeh@daynix.com>
References: <20170321120326.10011-1-sameeh@daynix.com>
Date: Tue, 21 Mar 2017 11:15:36 -0500
Message-Id: <149011293694.3910.1065708853924970955@loki>
Subject: Re: [Qemu-devel] [PATCH qemu-ga] Start VSS Provider after install
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>

Quoting Sameeh Jubran (2017-03-21 07:03:26)
> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>

What happens without this patch? Fresh installs don't report the
fsfreeze interface as available?

> ---
>  qga/vss-win32/install.cpp | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index f4160a3..7e38332 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -307,6 +307,7 @@ STDAPI COMRegister(void)
>      chk(put_Value(pObj, L"User", L"SYSTEM"));
>      chk(pUsersInRole->SaveChanges(&n));
> =

> +    chk(pCatalog->StartApplication(_bstr_t(QGA_PROVIDER_LNAME)));
>  out:
>      if (unregisterOnFailure && FAILED(hr)) {
>          COMUnregister();
> -- =

> 2.9.3
>=20
