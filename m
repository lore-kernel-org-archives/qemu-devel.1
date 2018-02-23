Received: from eggs.gnu.org ([2001:4830:134:3::10]:44836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ep90K-00046O-Ud
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ep90G-00019M-2O
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:46:56 -0500
References: <1519372267-20513-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c030a20b-cb16-5c76-9661-9266aee3cca0@redhat.com>
Date: Fri, 23 Feb 2018 09:46:31 +0100
MIME-Version: 1.0
In-Reply-To: <1519372267-20513-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] util/uri.c: replace TAB with
 whitespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

 Hi,

thanks for splitting your patch in more reviewable parts :-)

Meta-comment: If you send a patch series, please include a cover letter
next time ("PATCH 0/3") with a brief summary. Then the patch series
shows up nicely as a thread in the e-mail programs of the reviewers (you
also got to send out all files at once with "git send-email 000*" for thi=
s).

On 23.02.2018 08:51, Su Hang wrote:
> Formating with clang-format. Change back few code by hand,
> to make sure only include whitespace change.

To make the review really really easy, it would be great if the patch
would not show any differences when displayed with "git diff -w" ... but
that's currently not yet the case since you still changed the position
of newlines in a couple of places, e.g.:

> -    while (ISA_UNRESERVED(cur) || ISA_PCT_ENCODED(cur) ||
> -           ISA_SUB_DELIM(cur) || (*cur =3D=3D ':'))
> -	NEXT(cur);
> +    while (ISA_UNRESERVED(cur) || ISA_PCT_ENCODED(cur) || ISA_SUB_DELI=
M(cur) ||
> +           (*cur =3D=3D ':'))
> +        NEXT(cur);

Anyway, I've went through the diff with "-w" and the changes look
reasonable to me, so I'm also OK if you want to keep the patch as it is:

Reviewed-by: Thomas Huth <thuth@redhat.com>
