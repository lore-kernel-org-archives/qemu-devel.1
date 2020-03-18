Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97580C4332B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1462076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1462076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEhsE-0005RC-Fm
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 19:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1jEhrY-0004y1-18
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1jEhrW-0005rq-D0
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:12:35 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:39014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1jEhrW-0005jW-1Y
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:12:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 8B8F42D34;
 Thu, 19 Mar 2020 00:12:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G4O7AWOrcBlz; Thu, 19 Mar 2020 00:12:27 +0100 (CET)
Received: from function.home (unknown
 [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id C009C1B15;
 Thu, 19 Mar 2020 00:12:27 +0100 (CET)
Received: from samy by function.home with local (Exim 4.93)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1jEhrO-0079La-IJ; Thu, 19 Mar 2020 00:12:26 +0100
Date: Thu, 19 Mar 2020 00:12:26 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2] slirp: update submodule to v4.2.0 + mingw-fix
Message-ID: <20200318231226.ieq4aakibph3mkom@function>
References: <20200317181336.2730307-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317181336.2730307-1-marcandre.lureau@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a0c:e300::1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau, le mar. 17 mars 2020 19:13:36 +0100, a ecrit:
> git shortlog
> 126c04acbabd7ad32c2b018fe10dfac2a3bc1210..7012a2c62e5b54eab88c119383022=
ec7ce86e9b2
>=20
> 5eraph (1):
>       Use specific outbound IP address
>=20
> Akihiro Suda (8):
>       remove confusing comment that exists from ancient slirp
>       add slirp_new(SlirpConfig *, SlirpCb *, void *)
>       allow custom MTU
>       add disable_host_loopback (prohibit connections to 127.0.0.1)
>       add SlirpConfig version
>       emu: remove dead code
>       emu: disable by default
>       fix a typo in a comment
>=20
> Anders Waldenborg (1):
>       state: fix loading of guestfwd state
>=20
> Giuseppe Scrivano (1):
>       socket: avoid getpeername after shutdown(SHUT_WR)
>=20
> Jindrich Novy (1):
>       Don't leak memory when reallocation fails.
>=20
> Jordi Pujol Palomer (1):
>       fork_exec: correctly parse command lines that contain spaces
>=20
> Marc-Andr=C3=A9 Lureau (54):
>       Merge branch 'AkihiroSuda/libslirp-slirp4netns'
>       Merge branch 'fix-typo' into 'master'
>       meson: make it subproject friendly
>       Merge branch 'meson' into 'master'
>       misc: fix compilation warnings
>       Merge branch 'fix-shutdown-wr' into 'master'
>       sbuf: remove unused and undefined sbcopy() path
>       sbuf: check more strictly sbcopy() bounds with offset
>       sbuf: replace a comment with a runtime warning
>       Replace remaining malloc/free user with glib
>       tcp_attach() can no longer fail
>       state: can't ENOMEM
>       sbuf: use unsigned types
>       sbuf: simplify sbreserve()
>       dnssearch: use g_strv_length()
>       vmstate: silence scan-build warning
>       gitlab-ci: run scan-build
>       Merge branch 'mem-cleanups' into 'master'
>       libslirp.map: bind slirp_new to SLIRP_4.1 version
>       meson: fix libtool versioning
>       Release v4.1.0
>       Merge branch '4.1.0' into 'master'
>       CHANGELOG: start unreleased section
>       Merge branch 'add-unix' into 'master'
>       util: add G_SIZEOF_MEMBER() macro
>       Check bootp_filename is not going to be truncated
>       bootp: remove extra cast
>       bootp: replace simple snprintf() with strcpy()
>       tftp: clarify what is actually OACK m_len
>       tcp_emu: add more fixme/warnings comments
>       util: add slirp_fmt() helpers
>       dhcpv6: use slirp_fmt()
>       misc: use slirp_fmt0()
>       tftp: use slirp_fmt0()
>       tcp_ctl: use slirp_fmt()
>       tcp_emu: fix unsafe snprintf() usages
>       misc: improve error report
>       Use g_snprintf()
>       util: add gnuc format function attribute to slirp_fmt*
>       Merge branch 'aw-guestfwd-state' into 'master'
>       Merge branch 'slirp-fmt' into 'master'
>       socket: remove extra label and variable
>       socket: factor out sotranslate ipv4/ipv6 handling
>       socket: remove need for extra scope_id variable
>       socket: do not fallback on host loopback if get_dns_addr() failed
>       socket: do not fallback on loopback addr for addresses in our mas=
k/prefix
>       Prepare for v4.2.0 release
>       Merge branch 'translate-fix' into 'master'
>       Merge branch 'release-v4.2.0' into 'master'
>       changelog: post-release
>       changelog: fix link
>       .gitlab-ci: add --werror, treat CI build warnings as errors
>       Revert "socket: remove need for extra scope_id variable"
>       Merge branch 'mingw-fix' into 'master'
>=20
> PanNengyuan (1):
>       libslirp: fix NULL pointer dereference in tcp_sockclosed
>=20
> Philippe Mathieu-Daud=C3=A9 (1):
>       Add a git-publish configuration file
>=20
> Prasad J Pandit (4):
>       slirp: ncsi: compute checksum for valid data length
>       slirp: use correct size while emulating IRC commands
>       slirp: use correct size while emulating commands
>       slirp: tftp: restrict relative path access
>=20
> Renzo Davoli (2):
>       Add slirp_remove_guestfwd()
>       Add slirp_add_unix()
>=20
> Samuel Thibault (14):
>       ip_reass: explain why we should not always update the q pointer
>       Merge branch 'comment' into 'master'
>       Merge branch 'no-emu' into 'master'
>       Fix bogus indent, no source change
>       ip_reass: Fix use after free
>       Merge branch 'reass2' into 'master'
>       Make host receive broadcast packets
>       arp: Allow 0.0.0.0 destination address
>       Merge branch 'warnings' into 'master'
>       Merge branch 'arp_0' into 'master'
>       Merge branch 'broadcast' into 'master'
>       tcp_emu: Fix oob access
>       Merge branch 'oob' into 'master'
>       Merge branch 'master' into 'master'
>=20
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  slirp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/slirp b/slirp
> index 126c04acba..7012a2c62e 160000
> --- a/slirp
> +++ b/slirp
> @@ -1 +1 @@
> -Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
> +Subproject commit 7012a2c62e5b54eab88c119383022ec7ce86e9b2
> --=20
> 2.25.0.rc2.1.g09a9a1a997
>=20

