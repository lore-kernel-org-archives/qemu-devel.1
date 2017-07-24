Received: from eggs.gnu.org ([2001:4830:134:3::10]:33479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZdVh-0003fD-4B
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZdVg-0008PI-2M
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:34:57 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZdVf-0008OL-QY
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:34:55 -0400
Received: by mail-wm0-x231.google.com with SMTP id m85so17640533wma.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 06:34:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500897419-15539-1-git-send-email-armbru@redhat.com>
References: <1500897419-15539-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 14:34:32 +0100
Message-ID: <CAFEAcA9SkyNB39jmpkt3WYiqryNm+eDBngAYqT6g1OKVqB+dVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/10] QAPI patches for 2017-07-18
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

On 24 July 2017 at 12:56, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit df95f1a298a3e16c80293343143dcedbe7978f6c:
>
>   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170721-tag' into staging (2017-07-24 10:01:15 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-07-18-v2
>
> for you to fetch changes up to 01fa55982692fb51a16049b63b571651a1053989:
>
>   migration: Use JSON null instead of "" to reset parameter to default (2017-07-24 13:35:11 +0200)
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

Applied, thanks.

-- PMM
