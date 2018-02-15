Received: from eggs.gnu.org ([2001:4830:134:3::10]:57424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKGk-0005QH-3h
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKGg-0007F2-4a
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:12:14 -0500
References: <1518629505-22480-1-git-send-email-thuth@redhat.com>
	<9a9ac3ae-5974-f462-7321-9ae2ad5b78ae@redhat.com>
	<933068e0-7928-389b-f927-15df79506bc6@redhat.com>
	<20180215100812.GC3322@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e448490-3a13-dd85-ded6-f9fa582d3901@redhat.com>
Date: Thu, 15 Feb 2018 08:11:51 -0600
MIME-Version: 1.0
In-Reply-To: <20180215100812.GC3322@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Add missing space when using
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 02/15/2018 04:08 AM, Daniel P. Berrang=C3=A9 wrote:

>>> Hmm - here you're changing who supplies the ().=C2=A0 But that argues=
 that
>>> maybe the callsites should supply " (" and ")" themselves.
>>
>> Yeah, that's likely the saner way to do this. The question is: What
>> about the query-version QMP command? Should it report parentheses or
>> not? I think I'd look nicer if it reports "package": "foo" instead of
>> "package": "(foo)" - but we maybe could break some users who expect
>> parentheses there (no matter whether there is a preceding space or not=
)?
>=20
> The pkgversion is an opaque string - users/apps should never try to
> interpret its contents, because its format can vary arbitrarily between
> distros.  It is merely intended as an informative string to help the
> package maintainer identify which version of QEMU was used when someone
> submits a bug reoprt.
>=20
> IOW it is totally valid to change the command to omit '()', and if anyt=
hing
> breaks that is their own fault for trying to interpret an opaque blob o=
f
> data.

Agreed - the fact that we had a leading space in the QMP output for a=20
long time (and even inconsistent at whether it was there), with no one=20
noticing, means that dropping the () from QMP won't hurt anyone.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
