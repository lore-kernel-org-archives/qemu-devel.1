Received: from eggs.gnu.org ([209.51.188.92]:42149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqyPd-0006ck-FN
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqyPb-0005Pp-I5
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:57:09 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqyPZ-0005Nf-T8
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:57:07 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so4861350ota.12
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 02:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20190204211204.27321-1-philmd@redhat.com>
	<20190204211204.27321-4-philmd@redhat.com>
	<87a7jaag7q.fsf@dusky.pond.sub.org>
In-Reply-To: <87a7jaag7q.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 10:56:51 +0000
Message-ID: <CAFEAcA8-YDTnszv7Mk+F+OAxGJSmdu4yEio1j-E477HNbh-SOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] util/cutils: Move function
 documentations to the header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Stefano Garzarella <sgarzare@redhat.com>

On Tue, 5 Feb 2019 at 06:44, Markus Armbruster <armbru@redhat.com> wrote:
> There are two justifiable function comment placement styles: (1) next to
> definition, and (2) next to declaration if it's in a header, else next
> to definition.
>
> The rationale for the latter is having the headers do double-duty as
> interface documentation.
>
> The rationale for the former is consistently placing the function
> comments close to the code gives them a fighting chance to actually
> match the code.
>
> I'm in the "next to definition" camp.  If you want concise interface
> specification, use something like Sphinx.

I'm in the "next to declaration" camp. I don't want to have
to wade into your implementation to find out what it does:
document it for me in the interface, please.

My standard for patches I review is "if this is adding a new
function prototype in a header file, add a doc comment".

thanks
-- PMM
