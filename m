Received: from eggs.gnu.org ([209.51.188.92]:56846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw5AK-00031M-Fj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw5AJ-0002L4-Ql
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:10:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190219114609.1582-1-berrange@redhat.com>
Date: Tue, 19 Feb 2019 14:10:18 +0100
In-Reply-To: <20190219114609.1582-1-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Feb 2019 11:46:09
	+0000")
Message-ID: <87ftsjvs91.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Error reporting for user_creatable_add_opts_foreach was changed so that
> it no longer called 'error_report_err' in:
>
>   commit 7e1e0c11127bde81cff260fc6859690435c509d6
>   Author: Markus Armbruster <armbru@redhat.com>
>   Date:   Wed Oct 17 10:26:43 2018 +0200
>
>     qom: Clean up error reporting in user_creatable_add_opts_foreach()
>
> Some callers were updated to pass in "&error_fatal" but all the ones in
> qemu-img were left passing NULL. As a result all errors went to
> /dev/null instead of being reported to the user.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Mea culpa, I have no idea how this happened.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
