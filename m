Received: from eggs.gnu.org ([2001:4830:134:3::10]:48655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQaC-0007f5-5I
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQa7-0006l4-Gs
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:33:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euQa7-0006kw-CT
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:33:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3A91402277B
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 22:33:42 +0000 (UTC)
References: <1520576005-27647-1-git-send-email-thuth@redhat.com>
	<92dfc791-1fe6-f421-000b-6d103235417a@redhat.com>
	<5df712f0-4388-9351-f5e5-f88a8d569cb6@redhat.com>
	<445cf418-6ab6-1638-8a95-ba8fe2efe475@redhat.com>
	<66bcb7ee-6d29-330e-328e-b0862c154a43@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <338bfeec-aa1f-d8a5-2b02-93d6ce16143b@redhat.com>
Date: Fri, 9 Mar 2018 16:33:42 -0600
MIME-Version: 1.0
In-Reply-To: <66bcb7ee-6d29-330e-328e-b0862c154a43@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/09/2018 04:07 PM, Thomas Huth wrote:

>>> ... but looks like I even got it wrong - it should be "--device e1000=
",
>>> without "=3D". Will fix it.
>>
>> Really?=C2=A0 As I understand it, both long-opt spellings work ('--lon=
g=3Dopt'
>> as one arg, and '--long' 'opt' as two args).=C2=A0 So the only reason =
to drop
>> '=3D' would be consistency with other examples.

Well, that would be true if we used getopt_long_only().  But we don't=20
(we stupidly rolled our own command line parser, meaning it has quirks=20
that are different from everything else that uses the standardized parser=
).

>=20
> $ qemu-system-x86_64 --device=3De1000
> qemu-system-x86_64: --device=3De1000: invalid option
>=20
> Does at least not work for me.

Maybe our QemuOpts parser should be taught to make it work.  But that's=20
orthogonal, so you are right that for now we just always document things=20
as the two-arg form, since the one-arg form with '=3D' isn't implemented.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
