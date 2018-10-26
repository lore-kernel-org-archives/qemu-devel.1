Received: from eggs.gnu.org ([2001:4830:134:3::10]:36598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFwAJ-00083l-SM
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFwAF-0005nc-KR
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:04:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFwAF-0005mn-Er
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:04:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D61E33097085
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 07:04:09 +0000 (UTC)
Date: Fri, 26 Oct 2018 12:33:55 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181025203758.GA29995@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810261213001.8270@xnncv>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

  Hello Dan, all

+-- On Thu, 25 Oct 2018, Daniel P. Berrang=C3=A9 wrote --+
| On Thu, Oct 25, 2018 at 10:52:56AM +0200, Gerd Hoffmann wrote:
| > While being at it deprecate cirrus too.
| >=20
| > Reason (short version): use stdvga instead.
| > Verbose version:
| >     https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-=
harmful
|=20
|=20
| I don't debate the points in the blog post above that stdvga is a
| better choice, but I don't think that's enough to justify deprecating
| cirrus at this point in time, because when it then gets deleted it
| will break way too many existing deployments.
|=20
| We need to socialize info in that blog post above more widely and
| especially ensure that apps are not using that by default. I don't
| see it being viable to formally deprecate it in QEMU any time soon
| though given existing usage.

To note, IMO there are other devices/sources in QEMU which are potential=20
candidates for deprecation, similar to adlib etc. It'll help if we could=20
device a process to deprecate/remove such code base. Other than maintenan=
ce it=20
invariably also becomes source of security issues.

Ex.(similar to Fedora) we could announce such candidate on qemu-devel lis=
t and=20
after review over a period of say a month, candidate will be=20
deprecated/expunged. (thinking aloud)

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
