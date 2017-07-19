Received: from eggs.gnu.org ([2001:4830:134:3::10]:43407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXpEy-0007NS-BC
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXpEw-00069C-QO
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:42:12 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXpEw-00068l-Hn
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:42:10 -0400
Received: by mail-wr0-x22b.google.com with SMTP id y43so58751485wrd.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 06:42:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500409760-20730-1-git-send-email-armbru@redhat.com>
References: <1500409760-20730-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 14:41:48 +0100
Message-ID: <CAFEAcA8BZHmnxSFOxD_RhnV9NrVVs9NvPsFT0cvjUDK_wM+AoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] QAPI patches for 2017-07-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 July 2017 at 21:29, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d4f:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12' into staging (2017-07-13 16:56:06 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-07-18
>
> for you to fetch changes up to 4f11e88cbda71af50302c32d97b4f8122555027e:
>
>   migration: Use JSON null instead of "" to reset parameter to default (2017-07-18 22:21:58 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-07-18
>
> ----------------------------------------------------------------
> Markus Armbruster (10):
>       qapi: Separate type QNull from QObject
>       qapi: Use QNull for a more regular visit_type_null()
>       qapi: Introduce a first class 'null' type
>       tests/test-qobject-input-visitor: Drop redundant test
>       block: Use JSON null instead of "" to disable backing file
>       hmp: Clean up and simplify hmp_migrate_set_parameter()
>       migration: Clean up around tls_creds, tls_hostname
>       migration: Add TODO comments on duplication of QAPI_CLONE()
>       migration: Unshare MigrationParameters struct for now
>       migration: Use JSON null instead of "" to reset parameter to default

Hi -- I'm afraid this has a merge conflict in migration/migration.c
that looks too complicated for me to sort out. Can you rebase
and resend, please?

thanks
-- PMM
