Received: from eggs.gnu.org ([2001:4830:134:3::10]:58238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0oT5-0001Z7-6W
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0oT1-0004u1-7j
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:16:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f0oT1-0004tb-2V
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:16:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F80984256
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 13:16:37 +0000 (UTC)
References: <1520857250-12935-1-git-send-email-thuth@redhat.com>
	<e7c0d2c8-6451-a598-f140-29916c99e514@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d059301-fa9f-6303-5806-a2e6f7917ca5@redhat.com>
Date: Tue, 27 Mar 2018 15:16:31 +0200
MIME-Version: 1.0
In-Reply-To: <e7c0d2c8-6451-a598-f140-29916c99e514@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 27.03.2018 15:01, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B403=E6=9C=8812=E6=97=A5 20:20, Thomas Huth wrote:
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
>> of the chapter. The new "-nic" option is moved to the beginning of the
>> chapter instead, with a new example that should demonstrate how "-nic"
>> can be used to shortcut "-device" with "-netdev". The examples in this
>> chapter are changed to use the "-device" and "-netdev" options or
>> "-nic" instead of "-net nic -net <backend>".
>>
>> While we're at it, also remove a legacy remark about very old Linux
>> distributions. Also remove the "[...]" from the examples in this chapt=
er
>> since we are not using this ellipsis in any other examples in our docu=
-
>> mentation.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 v3:
>> =C2=A0 - Use single dash options instead of double-dash options
>>
>> =C2=A0 qemu-options.hx | 189
>> ++++++++++++++++++++++++++++----------------------------
>> =C2=A0 1 file changed, 94 insertions(+), 95 deletions(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 6585058..e86b3fb 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
[...]
>> +@item -nic
>> [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...][,mac=3Dmac=
addr][,model=3Dmn]
>>
>> +@findex -nic
>> +This option is a shortcut for configuring both the on-board (default)
>> guest
>> +NIC hardware and the host network backend in one go. The host backend
>> options
>> +are the same as with the corresponding @option{-netdev} options below=
.
>> +The guest NIC model can be set with @option{model=3D@var{modelname}}.
>> +Use @option{model=3Dhelp} to list the available device types.
>> +The hardware MAC address can be set with @option{mac=3D@var{macaddr}}=
.
>> +
>> +The following two example do exactly the same, to show how
>> @option{-nic} can
>> +be used to shorten the command line length (note that the e1000 is
>> the default
>> +on i386, so the @option{model=3De1000} parameter could even be omitte=
d
>> here, too):
>> +@example
>> +qemu-system-i386 -netdev user,id=3Dn1,ipv6=3Doff -device
>> e1000,netdev=3Dn1,mac=3D52:54:98:76:54:32
>> +qemu-system-i386 -nic user,ipv6=3Doff,model=3De1000,mac=3D52:54:98:76=
:54:32
>> +@end example
>=20
> I'm not sure we need this since I believe we still prefer -netdev even
> if -nic is shorter?

[...]
>> @@ -2443,19 +2433,9 @@ Example:
>> =C2=A0 # launch vde switch
>> =C2=A0 vde_switch -F -sock /tmp/myswitch
>> =C2=A0 # launch QEMU instance
>> -qemu-system-i386 linux.img -net nic -net vde,sock=3D/tmp/myswitch
>> +qemu-system-i386 linux.img -nic vde,sock=3D/tmp/myswitch
>=20
> I think we should use -netdev here?

I've had that in the original version of this patch, but Paolo suggested
to use -nic instead since this is more "user-friendly":

https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg05258.html

I personally don't mind whether we use "-netdev" or "-nic" in the
examples, as long as we finally get rid of "-net" there... Please let me
know which way you prefer, so I can respin the patch again if necessary.

 Thomas
