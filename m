Received: from eggs.gnu.org ([2001:4830:134:3::10]:40442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cyjqB-00061m-Vp
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cyjq6-0001aN-4R
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:51:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36325
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cyjq5-0001Zx-V1
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:51:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3DInLKZ138180
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 14:51:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29t19ynq17-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 14:51:28 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 13 Apr 2017 12:51:27 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170405120106.19298-1-sameeh@daynix.com>
References: <20170405120106.19298-1-sameeh@daynix.com>
Date: Thu, 13 Apr 2017 13:51:19 -0500
Message-Id: <149210947928.21548.4283158290166355463@loki>
Subject: Re: [Qemu-devel] [PATCH v2] qga-win: Fix Event Viewer errors caused
 by qemu-ga
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

Quoting Sameeh Jubran (2017-04-05 07:01:06)
> When the command "guest-fsfreeze-freeze" is executed it causes
> the VSS service to log the error below in the Event Viewer. This
> error is caused by an issue in the function "CommitSnapshots" in
> provider.cpp:
> =

> * When VSS_TIMEOUT_MSEC expires the funtion returns E_ABORT. This causes
> the error #12293.
> =

> |event id|                           error                               |
> * 12293  : Volume Shadow Copy Service error: Error calling a routine on a
>            Shadow Copy Provider {00000000-0000-0000-0000-000000000000}.
>            Routine details CommitSnapshots [hr =3D 0x80004004, Operation
>            aborted.
> =

> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>

Thanks, applied to qga tree:                                               =
                               =


  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/vss-win32/provider.cpp | 1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> index ef94669..72d8b0e 100644
> --- a/qga/vss-win32/provider.cpp
> +++ b/qga/vss-win32/provider.cpp
> @@ -377,7 +377,6 @@ STDMETHODIMP CQGAVssProvider::CommitSnapshots(VSS_ID =
SnapshotSetId)
>      if (WaitForSingleObject(hEventThaw, VSS_TIMEOUT_MSEC) !=3D WAIT_OBJE=
CT_0) {
>          /* Send event to qemu-ga to notify the provider is timed out */
>          SetEvent(hEventTimeout);
> -        hr =3D E_ABORT;
>      }
> =

>      CloseHandle(hEventThaw);
> -- =

> 2.9.3
>=20
