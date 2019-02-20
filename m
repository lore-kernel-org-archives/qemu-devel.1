Received: from eggs.gnu.org ([209.51.188.92]:37981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwQYD-00025D-BQ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 07:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gwQY5-00032c-NB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 07:00:31 -0500
Date: Wed, 20 Feb 2019 12:59:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190220115947.GC6281@localhost.localdomain>
References: <20190219114609.1582-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190219114609.1582-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix error reporting for -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org

Am 19.02.2019 um 12:46 hat Daniel P. Berrang=E9 geschrieben:
> Error reporting for user_creatable_add_opts_foreach was changed so that
> it no longer called 'error_report_err' in:
>=20
>   commit 7e1e0c11127bde81cff260fc6859690435c509d6
>   Author: Markus Armbruster <armbru@redhat.com>
>   Date:   Wed Oct 17 10:26:43 2018 +0200
>=20
>     qom: Clean up error reporting in user_creatable_add_opts_foreach()
>=20
> Some callers were updated to pass in "&error_fatal" but all the ones in
> qemu-img were left passing NULL. As a result all errors went to
> /dev/null instead of being reported to the user.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin
