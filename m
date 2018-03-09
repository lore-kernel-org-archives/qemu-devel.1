Received: from eggs.gnu.org ([2001:4830:134:3::10]:35843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euM1H-0004Zd-R4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euM1D-0005E4-RO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:41:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1euM1D-0005Dh-MI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:41:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F7B54068030
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 17:41:12 +0000 (UTC)
References: <1520576005-27647-1-git-send-email-thuth@redhat.com>
	<92dfc791-1fe6-f421-000b-6d103235417a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5df712f0-4388-9351-f5e5-f88a8d569cb6@redhat.com>
Date: Fri, 9 Mar 2018 18:41:05 +0100
MIME-Version: 1.0
In-Reply-To: <92dfc791-1fe6-f421-000b-6d103235417a@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 09.03.2018 15:36, Eric Blake wrote:
> On 03/09/2018 12:13 AM, Thomas Huth wrote:
>> "-net" is clearly a legacy option. Yet we still use it in almost all
>> examples in the qemu documentation, and many other spots in the networ=
k
>> chapter. We should make it less prominent that users are not lured int=
o
>> using it so often anymore. So instead of starting the network chapter
>> with
>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
>> everywhere, all the "-net" related documentation is now moved to the e=
nd
>> of the chapter. The new "--nic" option is moved to the beginning of th=
e
>> chapter instead, with a new example that should demonstrate how "--nic=
"
>> can be used to shortcut "--device" with "--netdev".
>> And the examples in this chapter are changed to use the "--device" and
>> "--netdev" options or "--nic" instead of "-net nic -net <backend>".
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 qemu-options.hx | 210
>> ++++++++++++++++++++++++++++----------------------------
>> =C2=A0 1 file changed, 105 insertions(+), 105 deletions(-)
>>
>=20
>> -@item -netdev user,id=3D@var{id}[,@var{option}][,@var{option}][,...]
>> -@findex -netdev
>> -@item -net user[,@var{option}][,@var{option}][,...]
>> -Use the user mode network stack which requires no administrator
>> +@item --nic
>> [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...][,mac=3Dmac=
addr][,model=3Dmn]
>>
>> +
>> +This option is a shortcut for configuring both, the on-board
>> (default) guest
>=20
> s/both,/both/
>=20
>> +NIC hardware and the host network backend in one go. The host backend
>> options
>> +are the same as with the corresponding @option{--netdev} options belo=
w.
>> +The guest NIC model can be set with @option{model=3D@var{modelname}}.
>> +Use @option{model=3Dhelp} to list the available device types.
>> +The hardware MAC address can be set with @option{mac=3D@var{macaddr}}=
.
>> +
>> +The following two example do exactly the same, to show how
>> @option{--nic} can
>> +be used to shorten the command line length (note that the e1000 is
>> the default
>> +on i386, so the @option{model=3De1000} parameter could even be omitte=
d
>> here, too):
>> +@example
>> +qemu-system-i386 --netdev user,id=3Dn1,ipv6=3Doff
>> --device=3De1000,netdev=3Dn1,mac=3D52:54:98:76:54:32
>> +qemu-system-i386 --nic user,ipv6=3Doff,model=3De1000,mac=3D52:54:98:7=
6:54:32
>> +@end example
>=20
> Nice example.

... but looks like I even got it wrong - it should be "--device e1000",
without "=3D". Will fix it.

>> +
>> +@item --nic none
>> +Indicate that no network devices should be configured. It is used to
>> override
>> +the default configuration (default NIC with @option{--net user}
>> backend) which
>> +is activated if no other networking options are provided.
>> +
>> +@item --netdev user,id=3D@var{id}[,@var{option}][,@var{option}][,...]
>> +@findex --netdev
>> +Configure user mode host network backend which requires no administra=
tor
>> =C2=A0 privilege to run. Valid options are:
>> @@ -2166,8 +2166,6 @@ or @file{C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS}
>> (Windows NT/2000).
>> =C2=A0 Then @file{@var{dir}} can be accessed in @file{\\smbserver\qemu=
}.
>> =C2=A0 =C2=A0 Note that a SAMBA server must be installed on the host O=
S.
>> -QEMU was tested successfully with smbd versions from Red Hat 9,
>> -Fedora Core 3 and OpenSUSE 11.x.
>> =C2=A0=20
>=20
> This change makes sense, but is somewhat unrelated to -net.=C2=A0 Worth
> splitting the patch?

Not sure whether it's really worth the effort ... I think I'll just
mention it in the patch description, ok?

>> =C2=A0 @item
>> hostfwd=3D[tcp|udp]:[@var{hostaddr}]:@var{hostport}-[@var{guestaddr}]:=
@var{guestport}
>>
>> =C2=A0 Redirect incoming TCP or UDP connections to the host port
>> @var{hostport} to
>> @@ -2182,7 +2180,7 @@ screen 0, use the following:
>> =C2=A0 =C2=A0 @example
>> =C2=A0 # on the host
>> -qemu-system-i386 -net user,hostfwd=3Dtcp:127.0.0.1:6001-:6000 [...]
>> +qemu-system-i386 --nic user,hostfwd=3Dtcp:127.0.0.1:6001-:6000
>=20
> The trailing [...] makes sense here, why did you drop it?

Since we're incredibly inconsistent with that. Some examples do have
that "[...]", many others don't have it. Since the amount of examples
without it is larger than the amount of examples with it, I think it's
more consistent to drop it here.

I guess I should mention this in the commit message, too.

>> +@item -net
>> nic[,vlan=3D@var{n}][,netdev=3D@var{nd}][,macaddr=3D@var{mac}][,model=3D=
@var{type}]
>> [,name=3D@var{name}][,addr=3D@var{addr}][,vectors=3D@var{v}]
>=20
> Worth spelling this --net instead of -net?

Yes, that's more consistent.

>> +@findex -net
>=20
> We can have multiple @findex listings; should we list both @findex -net
> and @findex --net?

I think we should finally also use double dashes for all @findex entries
(if the option is longer than just one letter).

 Thomas
