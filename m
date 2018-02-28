Received: from eggs.gnu.org ([2001:4830:134:3::10]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1equxr-000147-Qw
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1equxn-00028D-SC
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:11:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1equxn-00027l-NJ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:11:39 -0500
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
Date: Wed, 28 Feb 2018 07:11:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Deprecate tilegx ? (was: Proposal: deprecate and
 remove QEMU's unicore32 target code)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Richard Henderson <rth@twiddle.net>, Chen Gang <xili_gchen_5257@hotmail.com>, Chen Gang <gang.chen.5i5j@gmail.com>Richard Henderson <rth@twiddle.net>, Chen Gang <chengang@emindsoft.com.cn>

On 27.02.2018 12:51, Peter Maydell wrote:
> I propose that we deprecate and plan to remove the unicore32 code:
[...]
> Essentially, it seems to be a largely-inactive university R&D project,
> it's costing us in maintenance effort every time we have to touch it,
> and I don't think it has any real users.
>
> Does anybody disagree?
>=20
> If we go ahead with deprecating then we should:
>  * add a note to Changelog that we're deprecating the target
>  * ditto qemu-doc.texi's deprecation section
>  * patch hw/unicore32/puv3.c to warn on startup that it's deprecated
>  * remove it entirely for the 2.14 release
>=20
> We could also remove linux-user/unicore32 immediately, since
> the linux-user target has been disabled for some time.

Sounds reasonable to me, but let's wait a week or two for feedback from
Guan Xuetao.

> Possibly there are other target architectures we could reasonably
> deprecate-and-remove (though none of the other ones Linux is dropping
> in this round are ones we support)...

I'd vote for marking tilegx as deprecated, too, since we even do not
have an active maintainer for that CPU core (at least I did not spot one
in our MAINTAINERS file). Opinions?

 Thomas
