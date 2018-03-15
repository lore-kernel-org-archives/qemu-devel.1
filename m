Received: from eggs.gnu.org ([2001:4830:134:3::10]:46967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewRPh-0004W0-QK
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewRPg-0002Wl-T5
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:51:17 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:33832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewRPg-0002WF-NG
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:51:16 -0400
Received: by mail-oi0-x22f.google.com with SMTP id e79so1466390oih.1
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 04:51:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521114316-19980-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1521114316-19980-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 11:50:55 +0000
Message-ID: <CAFEAcA8sKBc--=AkwXjnJxEB484Z=Gin-u2ga5nG9UR79HN-6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC] scripts/checkpatch.pl: Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15 March 2018 at 11:45, Su Hang <suhang16@mails.ucas.ac.cn> wrote:
> Bug fix: checkpatch.pl stops complaining about following pattern:
> """
> do {
>     //do somethins;
> } while (conditions);
> """
>
> Two things need to be mentioned:
> 1) Before I casue this bug, checkpatch.pl will raise a wrong
> complain:
> """
> ERROR: braces {} are necessary even for single statement blocks
> +    for (i == 0; i < 0; ++i)
> +    {
> +        ;
> +    } else
> """

This is a bit of an odd example -- for() loops don't
take "else" clauses, so what is the 'else' doing here?

(Also, for QEMU style the "{" should be on the same line as the for(),
not on a line of its own.)

thanks
-- PMM
