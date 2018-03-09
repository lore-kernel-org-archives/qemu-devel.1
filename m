Received: from eggs.gnu.org ([2001:4830:134:3::10]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euNGI-0005LA-4O
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:01:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euNGD-0001lf-IO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:01:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euNGD-0001lX-Do
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:00:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B889EBD9E
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 19:00:45 +0000 (UTC)
References: <1520576005-27647-1-git-send-email-thuth@redhat.com>
	<92dfc791-1fe6-f421-000b-6d103235417a@redhat.com>
	<5df712f0-4388-9351-f5e5-f88a8d569cb6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <445cf418-6ab6-1638-8a95-ba8fe2efe475@redhat.com>
Date: Fri, 9 Mar 2018 13:00:40 -0600
MIME-Version: 1.0
In-Reply-To: <5df712f0-4388-9351-f5e5-f88a8d569cb6@redhat.com>
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

On 03/09/2018 11:41 AM, Thomas Huth wrote:
> On 09.03.2018 15:36, Eric Blake wrote:
>> On 03/09/2018 12:13 AM, Thomas Huth wrote:
>>> "-net" is clearly a legacy option. Yet we still use it in almost all
>>> examples in the qemu documentation, and many other spots in the netwo=
rk
>>> chapter. We should make it less prominent that users are not lured in=
to
>>> using it so often anymore. So instead of starting the network chapter
>>> with
>>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
>>> everywhere, all the "-net" related documentation is now moved to the =
end
>>> of the chapter. The new "--nic" option is moved to the beginning of t=
he
>>> chapter instead, with a new example that should demonstrate how "--ni=
c"
>>> can be used to shortcut "--device" with "--netdev".
>>> And the examples in this chapter are changed to use the "--device" an=
d
>>> "--netdev" options or "--nic" instead of "-net nic -net <backend>".
>>>

>>> +@example
>>> +qemu-system-i386 --netdev user,id=3Dn1,ipv6=3Doff
>>> --device=3De1000,netdev=3Dn1,mac=3D52:54:98:76:54:32
>>> +qemu-system-i386 --nic user,ipv6=3Doff,model=3De1000,mac=3D52:54:98:=
76:54:32
>>> +@end example
>>
>> Nice example.
>=20
> ... but looks like I even got it wrong - it should be "--device e1000",
> without "=3D". Will fix it.

Really?  As I understand it, both long-opt spellings work ('--long=3Dopt'=
=20
as one arg, and '--long' 'opt' as two args).  So the only reason to drop=20
'=3D' would be consistency with other examples.

>>> @@ -2166,8 +2166,6 @@ or @file{C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS}
>>> (Windows NT/2000).
>>>  =C2=A0 Then @file{@var{dir}} can be accessed in @file{\\smbserver\qe=
mu}.
>>>  =C2=A0 =C2=A0 Note that a SAMBA server must be installed on the host=
 OS.
>>> -QEMU was tested successfully with smbd versions from Red Hat 9,
>>> -Fedora Core 3 and OpenSUSE 11.x.
>>>   =20
>>
>> This change makes sense, but is somewhat unrelated to -net.=C2=A0 Wort=
h
>> splitting the patch?
>=20
> Not sure whether it's really worth the effort ... I think I'll just
> mention it in the patch description, ok?

Yes, if you don't split, at least mention it (if a reviewer questioned=20
it in an earlier revision, then an improved commit message serves as the=20
preemptive reason for the next person looking at the next revision).


>>> -qemu-system-i386 -net user,hostfwd=3Dtcp:127.0.0.1:6001-:6000 [...]
>>> +qemu-system-i386 --nic user,hostfwd=3Dtcp:127.0.0.1:6001-:6000
>>
>> The trailing [...] makes sense here, why did you drop it?
>=20
> Since we're incredibly inconsistent with that. Some examples do have
> that "[...]", many others don't have it. Since the amount of examples
> without it is larger than the amount of examples with it, I think it's
> more consistent to drop it here.
>=20
> I guess I should mention this in the commit message, too.

Yes, mention that it's intentional, and I'll go along with it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
