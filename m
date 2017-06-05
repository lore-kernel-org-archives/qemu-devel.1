Received: from eggs.gnu.org ([2001:4830:134:3::10]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dHolk-0006ef-A1
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dHolj-0003il-6l
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:57:52 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dHolh-0003eI-82
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:57:51 -0400
Received: by mail-lf0-x244.google.com with SMTP id v20so6217480lfa.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 02:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
	<1494921494-33717-2-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CL8gFP7QaNRWMJd+HQExtsKCXzGexB-uQH7UzDz6Ru3yg@mail.gmail.com>
	<1496647406.25318.13.camel@intel.com>
In-Reply-To: <1496647406.25318.13.camel@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 05 Jun 2017 09:57:34 +0000
Message-ID: <CAJ+F1CJrXwyPOEJC8tQWk-H2MTdU7BgGVmvDef2HckMh2FR22Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/8] tpm-backend: Remove unneeded member
 variable from backend class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Valluri, Amarnath" <amarnath.valluri@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi

On Mon, Jun 5, 2017 at 11:22 AM Valluri, Amarnath <
amarnath.valluri@intel.com> wrote:

> On Wed, 2017-05-24 at 14:34 +0000, Marc-Andr=C3=A9 Lureau wrote:
>
> Hi
>
> On Tue, May 16, 2017 at 12:00 PM Amarnath Valluri <
> amarnath.valluri@intel.com> wrote:
>
> TPMDriverOps inside TPMBackend is not required, as it is supposed to be a
> class
> member. The only possible reason for keeping in TPMBackend was, to get th=
e
> backend type in tpm.c where dedicated backend api, tpm_backend_get_type()
> is
> present.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
>
>
> Please add & keep my r-b tags from previous iterations in commit message
> if they are no or only minor changes.
>
> Marc, do you mean to resend the patch set by keeping 'Reviewed-by:' tag
> for commits.
>

 On the patches I gave a "Reviewed-by", you should add it to the commit
message. Next resend of the series should have them.
--=20
Marc-Andr=C3=A9 Lureau
