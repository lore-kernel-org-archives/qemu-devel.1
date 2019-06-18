Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77117C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 03:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416CB2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 03:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416CB2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd4rM-0006Z4-KN
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 23:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34187)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hd4pz-0005kP-MF
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 23:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hd4pv-0000vj-2p
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 23:31:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hd4pu-0000u7-QT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 23:31:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9BE72308FC4A
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 03:31:04 +0000 (UTC)
Received: from [10.72.12.155] (ovpn-12-155.pek2.redhat.com [10.72.12.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12ECD80DF1;
 Tue, 18 Jun 2019 03:31:02 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190604115221.28364-1-armbru@redhat.com>
 <20190604115221.28364-3-armbru@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <10f1a64b-cbc7-600f-7a52-cdd57ec5f71f@redhat.com>
Date: Tue, 18 Jun 2019 11:31:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604115221.28364-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 18 Jun 2019 03:31:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] net: Deprecate tap backend's parameter
 "helper"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/4 =E4=B8=8B=E5=8D=887:52, Markus Armbruster wrote:
> -netdev tap,helper=3D... is a useless duplicate of -netdev bridge.
> Deprecate and de-document.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


This requires more thought as TAP could be used independently. Force=20
using a "bridge" backend may lead some confusion.

Thanks


> ---
>   qapi/net.json        |  3 ++-
>   qemu-deprecated.texi |  4 ++++
>   qemu-options.hx      | 18 ++----------------
>   3 files changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/qapi/net.json b/qapi/net.json
> index 5f7bff1637..59d79a1ae1 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -221,7 +221,8 @@
>   #
>   # @br: bridge name (since 2.8)
>   #
> -# @helper: command to execute to configure bridge
> +# @helper: command to execute to configure bridge (deprecated, use
> +# type 'bridge' instead)
>   #
>   # @sndbuf: send buffer limit. Understands [TGMKkb] suffixes.
>   #
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 50292d820b..52e7600ebc 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -48,6 +48,10 @@ for these file types is 'host_cdrom' or 'host_device=
' as appropriate.
>   The @option{name} parameter of the @option{-net} option is a synonym
>   for the @option{id} parameter, which should now be used instead.
>  =20
> +@subsection -netdev tap,helper=3D... (since 4.1)
> +
> +Use -netdev bridge instead.
> +
>   @subsection -smp (invalid topologies) (since 3.1)
>  =20
>   CPU topology properties should describe whole machine topology includ=
ing
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 39dc170429..3324203b51 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2121,7 +2121,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>       "                configure a host TAP network backend with ID 'st=
r'\n"
>   #else
>       "-netdev tap,id=3Dstr[,fd=3Dh][,fds=3Dx:y:...:z][,ifname=3Dname][=
,script=3Dfile][,downscript=3Ddfile]\n"
> -    "         [,br=3Dbridge][,helper=3Dhelper][,sndbuf=3Dnbytes][,vnet=
_hdr=3Don|off][,vhost=3Don|off]\n"
> +    "         [,br=3Dbridge][,sndbuf=3Dnbytes][,vnet_hdr=3Don|off][,vh=
ost=3Don|off]\n"
>       "         [,vhostfd=3Dh][,vhostfds=3Dx:y:...:z][,vhostforce=3Don|=
off][,queues=3Dn]\n"
>       "         [,poll-us=3Dn]\n"
>       "                configure a host TAP network backend with ID 'st=
r'\n"
> @@ -2130,8 +2130,6 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>       "                to configure it and 'dfile' (default=3D" DEFAULT=
_NETWORK_DOWN_SCRIPT ")\n"
>       "                to deconfigure it\n"
>       "                use '[down]script=3Dno' to disable script execut=
ion\n"
> -    "                use network helper 'helper' (default=3D" DEFAULT_=
BRIDGE_HELPER ") to\n"
> -    "                configure it\n"
>       "                use 'fd=3Dh' to connect to an already opened TAP=
 interface\n"
>       "                use 'fds=3Dx:y:...:z' to connect to already open=
ed multiqueue capable TAP interfaces\n"
>       "                use 'sndbuf=3Dnbytes' to limit the size of the s=
end buffer (the\n"
> @@ -2435,7 +2433,7 @@ qemu-system-i386 -nic  'user,id=3Dn1,guestfwd=3Dt=
cp:10.0.2.100:1234-cmd:netcat 10.10
>  =20
>   @end table
>  =20
> -@item -netdev tap,id=3D@var{id}[,fd=3D@var{h}][,ifname=3D@var{name}][,=
script=3D@var{file}][,downscript=3D@var{dfile}][,br=3D@var{bridge}][,help=
er=3D@var{helper}]
> +@item -netdev tap,id=3D@var{id}[,fd=3D@var{h}][,ifname=3D@var{name}][,=
script=3D@var{file}][,downscript=3D@var{dfile}][,br=3D@var{bridge}]
>   Configure a host TAP network backend with ID @var{id}.
>  =20
>   Use the network script @var{file} to configure it and the network scr=
ipt
> @@ -2445,11 +2443,6 @@ automatically provides one. The default network =
configure script is
>   @file{/etc/qemu-ifdown}. Use @option{script=3Dno} or @option{downscri=
pt=3Dno}
>   to disable script execution.
>  =20
> -If running QEMU as an unprivileged user, use the network helper
> -@var{helper} to configure the TAP interface and attach it to the bridg=
e.
> -The default network helper executable is @file{/path/to/qemu-bridge-he=
lper}
> -and the default bridge device is @file{br0}.
> -
>   @option{fd}=3D@var{h} can be used to specify the handle of an already
>   opened host TAP interface.
>  =20
> @@ -2468,13 +2461,6 @@ qemu-system-i386 linux.img \
>           -netdev tap,id=3Dnd1,ifname=3Dtap1 -device rtl8139,netdev=3Dn=
d1
>   @end example
>  =20
> -@example
> -#launch a QEMU instance with the default network helper to
> -#connect a TAP device to bridge br0
> -qemu-system-i386 linux.img -device virtio-net-pci,netdev=3Dn1 \
> -        -netdev tap,id=3Dn1,"helper=3D/path/to/qemu-bridge-helper"
> -@end example
> -
>   @item -netdev bridge,id=3D@var{id}[,br=3D@var{bridge}][,helper=3D@var=
{helper}]
>   Connect a host TAP network interface to a host bridge device.
>  =20

