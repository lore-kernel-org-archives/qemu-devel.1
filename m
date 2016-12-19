Received: from eggs.gnu.org ([2001:4830:134:3::10]:49863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cIxNv-0003l7-JU
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 07:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cIxNr-0007Pp-Kb
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 07:49:43 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:35425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlipchuk@redhat.com>) id 1cIxNr-0007PS-Fn
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 07:49:39 -0500
Received: by mail-it0-f48.google.com with SMTP id c20so58858732itb.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 04:49:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ1JNOepVarVZZeVKaUN+5TTRFz-BKU+WcEu5koUR_W2YrFADA@mail.gmail.com>
References: <CAJ1JNOepVarVZZeVKaUN+5TTRFz-BKU+WcEu5koUR_W2YrFADA@mail.gmail.com>
From: Maor Lipchuk <mlipchuk@redhat.com>
Date: Mon, 19 Dec 2016 14:49:38 +0200
Message-ID: <CAJ1JNOc_HHVZOx_qZTWK=U_dn6_69UDnD3eDmoEVU4mYnCLC2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Is qemu-img amend an atomic operation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, Dec 19, 2016 at 2:47 PM, Maor Lipchuk <mlipchuk@redhat.com> wrote:

> Hi All,
>
> Does amend considered as an atomic operation or should we mark a volume as
> ILLEGAL once the amend operation fails?
>
> also, if I call amend, but downgrade the QCOW volume compatibility level
> from 1.1 to 0.10, is that atomic as well (or not, based on the answer on
> the previous question)?
>
> Regards,
> Maor
>

Adding also Nir and Kevin to the thread.
