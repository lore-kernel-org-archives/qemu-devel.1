Received: from eggs.gnu.org ([2001:4830:134:3::10]:45553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ftEiq-0005I7-Cf
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ftEim-0001cQ-2Z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:14:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ftEil-0001b5-7C
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6092240241CF
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 16:13:58 +0000 (UTC)
References: <20180821103839.19355-1-marcandre.lureau@redhat.com>
	<878t4wcizj.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73af64ec-05e3-81aa-eb9f-6de8838eacf6@redhat.com>
Date: Fri, 24 Aug 2018 11:13:54 -0500
MIME-Version: 1.0
In-Reply-To: <878t4wcizj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] editorconfig: set emacs mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On 08/24/2018 02:38 AM, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> Some time ago, I proposed to use an (eval) in .dir-locals.el to set
>> the mode for all json files and Makefile. Unfortunately, this isn't
>> safe, and emacs will prompt the user, which isn't very friendly.
>>
>> Fortunately, editorconfig provides a special config key which does
>> allow to set the emacs mode. Add a few missing entries and set the
>> emacs mode.
>=20
> Please mention editorconfig requires a plugin to work.  Without that,
> the reader is left to wonder why we keep the "redundant" Emacs file
> local variables.

Is it also worth a (separate) patch to .editorconfig to add a comment=20
up-front about needing plugins for some editors? Right now, it just has=20
the single comment:

# http://editorconfig.org

which, if followed, will get you to the same information, but I'm a fan=20
of not having to chase a URL when it is just as easy to provide a short=20
summary in place.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
