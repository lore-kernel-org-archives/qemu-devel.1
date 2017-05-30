Received: from eggs.gnu.org ([2001:4830:134:3::10]:34761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dFY0x-0007c4-Ol
	for qemu-devel@nongnu.org; Mon, 29 May 2017 23:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dFY0u-0000xc-Mk
	for qemu-devel@nongnu.org; Mon, 29 May 2017 23:40:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dFY0u-0000uA-Hq
	for qemu-devel@nongnu.org; Mon, 29 May 2017 23:40:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EABF5D68D
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 03:40:06 +0000 (UTC)
Date: Tue, 30 May 2017 11:40:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170530034000.GA10390@lemon.lan>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-4-marcandre.lureau@redhat.com>
	<87tw4cn7sh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tw4cn7sh.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 03/17] tests: remove alt num-int cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

I noticed you were wondering what happend to this message in the patchew thread:

http://patchew.org/QEMU/20170509173559.31598-1-marcandre.lureau@redhat.com/

Markus, apparently this is because of the unusual "In-Reply-To" header of your
message, which confuses patchew:

In-Reply-To: <20170509173559.31598-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 9 May 2017 20:35:45 +0300")

Is this an extension of your email client, or a standard?

In https://tools.ietf.org/html/rfc2822#section-3.6.4:
>    The "References:" and "In-Reply-To:" field each contain one or more
>    unique message identifiers, optionally separated by CFWS.
> 
>    The message identifier (msg-id) is similar in syntax to an angle-addr
>    construct without the internal CFWS.
> 
> message-id      =       "Message-ID:" msg-id CRLF
> 
> in-reply-to     =       "In-Reply-To:" 1*msg-id CRLF
> 
> references      =       "References:" 1*msg-id CRLF

I can imagine if consider CFWS, patchew should probably just work (I can fix
that), but it's still good to understand this.

Fam
