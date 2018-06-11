Received: from eggs.gnu.org ([2001:4830:134:3::10]:51471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fSHie-0004dC-VN
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fSHia-0006rV-4U
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:58:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fSHiZ-0006r1-VN
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E63334023820
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 07:58:22 +0000 (UTC)
References: <20180604120345.12955-1-berrange@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <b304952d-caf4-b6bb-029a-334c84952377@redhat.com>
Date: Mon, 11 Jun 2018 09:58:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180604120345.12955-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Avoid using RUN_STATE_PRECONFIG
 unless explicitly requested with --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On 06/04/2018 02:03 PM, Daniel P. Berrang=C3=A9 wrote:
> The change to use RUN_STATE_PRECONFIG as the default initial state, eve=
n
> when not requested with --preconfig has caused a number of problems. Th=
is
> series introduces a new RUN_STATE_NONE to act as the initial state, so
> that we never use RUN_STATE_PRECONFIG unless the mgmt app has explicitl=
y
> requested todo so.
>=20
> Daniel P. Berrang=C3=A9 (2):
>   vl: don't use RUN_STATE_PRECONFIG as initial state
>   vl: fix use of --daemonize with --preconfig
>=20
>  qapi/run-state.json |  6 +++++-
>  vl.c                | 49 +++++++++++++++++++++++++++------------------
>  2 files changed, 35 insertions(+), 20 deletions(-)
>=20

So do we have some agreement here? I'm running qemu from git and I'm
still using my patch to make libvirt work.

Michal
