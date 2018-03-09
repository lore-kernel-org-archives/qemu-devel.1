Received: from eggs.gnu.org ([2001:4830:134:3::10]:40871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euQAv-0003yw-Pv
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euQAr-0001qp-P5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:07:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52786 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1euQAr-0001qF-Kp
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:07:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 398864026779
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 22:07:26 +0000 (UTC)
References: <1520576005-27647-1-git-send-email-thuth@redhat.com>
	<92dfc791-1fe6-f421-000b-6d103235417a@redhat.com>
	<5df712f0-4388-9351-f5e5-f88a8d569cb6@redhat.com>
	<445cf418-6ab6-1638-8a95-ba8fe2efe475@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <66bcb7ee-6d29-330e-328e-b0862c154a43@redhat.com>
Date: Fri, 9 Mar 2018 23:07:19 +0100
MIME-Version: 1.0
In-Reply-To: <445cf418-6ab6-1638-8a95-ba8fe2efe475@redhat.com>
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

On 09.03.2018 20:00, Eric Blake wrote:
> On 03/09/2018 11:41 AM, Thomas Huth wrote:
>> On 09.03.2018 15:36, Eric Blake wrote:
>>> On 03/09/2018 12:13 AM, Thomas Huth wrote:
>>>> "-net" is clearly a legacy option. Yet we still use it in almost all
>>>> examples in the qemu documentation, and many other spots in the netw=
ork
>>>> chapter. We should make it less prominent that users are not lured i=
nto
>>>> using it so often anymore. So instead of starting the network chapte=
r
>>>> with
>>>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>=
"
>>>> everywhere, all the "-net" related documentation is now moved to the
>>>> end
>>>> of the chapter. The new "--nic" option is moved to the beginning of =
the
>>>> chapter instead, with a new example that should demonstrate how "--n=
ic"
>>>> can be used to shortcut "--device" with "--netdev".
>>>> And the examples in this chapter are changed to use the "--device" a=
nd
>>>> "--netdev" options or "--nic" instead of "-net nic -net <backend>".
>>>>
>=20
>>>> +@example
>>>> +qemu-system-i386 --netdev user,id=3Dn1,ipv6=3Doff
>>>> --device=3De1000,netdev=3Dn1,mac=3D52:54:98:76:54:32
>>>> +qemu-system-i386 --nic user,ipv6=3Doff,model=3De1000,mac=3D52:54:98=
:76:54:32
>>>> +@end example
>>>
>>> Nice example.
>>
>> ... but looks like I even got it wrong - it should be "--device e1000"=
,
>> without "=3D". Will fix it.
>=20
> Really?=C2=A0 As I understand it, both long-opt spellings work ('--long=
=3Dopt'
> as one arg, and '--long' 'opt' as two args).=C2=A0 So the only reason t=
o drop
> '=3D' would be consistency with other examples.

$ qemu-system-x86_64 --device=3De1000
qemu-system-x86_64: --device=3De1000: invalid option

Does at least not work for me.

 Thomas
