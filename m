Received: from eggs.gnu.org ([2001:4830:134:3::10]:41217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fuJRN-0008Lg-53
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fuJRI-00036H-UM
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:28:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fuJRI-000359-OI
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:28:24 -0400
Date: Mon, 27 Aug 2018 17:28:17 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180827152817.GG20768@dnr>
References: <1535381652-19870-1-git-send-email-thuth@redhat.com>
	<20180827150845.GK122225@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <20180827150845.GK122225@angien.pipo.sk>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/4] Remove more deprecated
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 05:08:45PM +0200, Peter Krempa wrote:
>On Mon, Aug 27, 2018 at 16:54:08 +0200, Thomas Huth wrote:
>> These options are deprecated since at least two releases, and nobody
>> complained. Time to remove them now.
>>
>> (I'm sending these patches as a series since Paolo asked me to send a PU=
LL
>> request on my own for them ... but if one of the subsystems maintainers
>> prefers to take the patches through their own tree instead, just let me
>> know)
>>
>> Thomas Huth (4):
>>   Remove the deprecated -balloon option
>>   Remove the deprecated -nodefconfig option
>>   Remove the deprecated options -startdate, -localtime and -rtc-td-hack
>>   net: Remove the deprecated -tftp, -bootp, -redir and -smb options
>
>Libvirt does not use any of the options above thankfully so a weak-ACK
>from the libvirt side.

And another:
ACK yeah!
=66rom the libvirt side.

Jano

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAluEGIoACgkQyvpdPXT/
AmnfbBAAyK16LzTvd5wxuN38r3vBcSVKZwV23uT8UHV6sOMdF8ysh7yZYJyz9MrU
SWOcIJ4AaX5ZjxaKUTQz+38L4kepc+bnc5fjAV5zX+dYmwy9L/AO+xKfaSa61Yc3
JxLT6ZGcOj/XDcG1+ELMtSlZ6+NzMXs1FEwP+8QnVITiVrSFvTw54Tecd85kDL/M
x9w6vrjhb/kv1gshY3DzgY8gnjMZtE360KXcUt4Ze2RIqfTHydrvlC8hFN2d6JQE
eYpqX6IntaUwke04bBTq8Mr/58rZix3+walAv0H0qe2yjhr6MoCotUhRvrQeXjP+
RLaKoQC8+q27iBvWKgK21KjKbcJJWqKtXa/QGibO52Yiy+mv8FDG7brLyd1+O/mc
YZd7iZUUaTLm/VPCyQ12H71gckxcr+3yMcqZnHNprWhylJaFnNyuxM/mMoXLoy6n
UtSFFY5Yd0NZgI4m87A/5MPwilQu5E/C1kx1ugDPdjSrsNlLMkD9wQJoNiSJxlrB
sBcOgc5yNpzt3rsOzzWyqyloAfPvgkvrIhUWZgjNgjVknVB/KXpsLNpoY9Knlusf
itIBndxpIW77oN+8NErLtBPu4XhPCRITiUqK0/poaqMPbfTLVePwASt+IEr4hHhC
nSlnrnfLHmKW+e86aTVBPasuubQPB/UJCsAgW/irPbB3Q92yHXI=
=fRZB
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
