Received: from eggs.gnu.org ([2001:4830:134:3::10]:38236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafER-0002sQ-Fr
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafEO-0000Ex-B3
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:05:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cafEO-0000El-5R
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:05:04 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5389C80470
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 09:05:04 +0000 (UTC)
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-7-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ce84650-5d49-4db3-b71a-b71a37c0bd98@redhat.com>
Date: Mon, 6 Feb 2017 10:05:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170202145141.17138-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/22] char: add a /chardevs container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 02/02/2017 15:51, Marc-Andr=C3=A9 Lureau wrote:
> +    if (QTAILQ_IN_USE(chr, next)) {
> +        QTAILQ_REMOVE(&chardevs, chr, next);
> +    }
> +    if (OBJECT(chr)->parent) {
> +        object_unparent(OBJECT(chr));
> +    } else {
> +        object_unref(OBJECT(chr));
> +    }

What's the case where the "else" is used?  Probably qemu_chr_delete
callers should be changed to use object_unparent or object_unref directly=
.

Paolo
