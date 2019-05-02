Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6996AC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4B2204EC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4B2204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDvc-00069A-39
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:47:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMDu8-0005ce-PU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMDu7-0001Fd-7w
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:45:48 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45943)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMDu6-0001EW-VT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:45:47 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MqrsF-1h06ZB0Apl-00mqfb; Thu, 02 May 2019 17:45:32 +0200
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-4-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a0e3bdd6-6003-1fb9-4d52-315b6441e966@vivier.eu>
Date: Thu, 2 May 2019 17:45:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190412121626.19829-4-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0XJoTbPUxWxuKuwk9GkU9wE9Atq7DlfrcvymQJghCvKrteNOc96
	kT0uHBrl3HXc766Yeu/rLyDVA73uDo5Y8MI6bvmhtdVXwGhomSrXOaqwFCVmMe3tdrhXD6F
	aMQuMbI7S6YWBBH5rBY/VfxvIMcroMdrNAhGQTBGOWe74vDYnfzqfWoaFQGlYw8n2Qb38hr
	CNst2FTwh/q4gvLvqlpMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LaS2J0RudRU=:7RxCKxK81pkSgUxfxREEGt
	qzkI1YaUbOLeXDAEsjEMv/ux1GHa1qnEdVsZI6WF4CBZ9eWLMUbkIExi8Je/Qt/00m1s1oZRG
	T1FArna7l33PNSHe8KZU1XTX3UMJwYrtcos38U5TKo5CKNnIfQ8hcq343gqf1ThF0EEahfSv8
	w7Qfr7ByfD0pS4W4dfzE193rNv0LaAThpPUlA1AKVVbiylfwbIwgmvZj2ITTzJeuiF0YdInZB
	DrgZyKImkfo3O5a1/F3lCOlDjQxiMonpBPH7ab3p/mhBgQojbWUsgUbxB7ubpp9Mf/bs19eBp
	gbemaeFRKanLQrLTPh+2dcbkQf+p3d3joRGv6K4Cgi/anFVsRhx8DvaiAKEZ3g+FvxE9QQpTu
	6cBs0TNRH1TpfQqUw2ieXSZyUsyrJvRy9umLxQmC6LkoRMPGKmBwthPmQytp60hMVPGZYqnFM
	IW2oFHSfKpCPAcdOSuyDfF5and7Ul7VL9SaD6umHbchEcoO8ETCeqf+q8Ony/36OTCthLpnlx
	hN4o00gk/8ltbdh7cYGiSqkVtvyuCPPfy6MwXY/hHzjN54+zafJ4Dj8rJiVzvzv1dbBGBJZwY
	w3xlwyyDuS80iffbKWEOAzncbjyI38DyzeRaKpDHzCVszJ7nTTQk2+xY67izRaw7BxRZnGzjL
	DzpddO/smH9s+46t5yKDZ4H/ru/RMx8MVysvNkAJGP4gXPI41rNNtWPZNYXs1EZ7B6siDoki9
	53XlsfQ9cTrl2rOy5L+fdV1eZIz/sf98RVjj0ZuCM1igvfVQRKKjRJzECkA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH v2 3/5] sockets: avoid string truncation
 warnings when copying UNIX path
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502154530.wKEY3WvaO0OkV0Eiuz5JhO6rLA-RK_lDjtimOYVjpgQ@z>

Dan,

do you want I take this through the trivial branch queue or do you add
it into the Sockets branch queue?

Thanks,
Laurent

On 12/04/2019 14:16, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from util/qemu-sockets.c:18:
> In function ‘strncpy’,
>     inlined from ‘unix_connect_saddr.isra.0’ at util/qemu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘strncpy’,
>     inlined from ‘unix_listen_saddr.isra.0’ at util/qemu-sockets.c:880:5:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We are already validating the UNIX socket path length earlier in
> the functions. If we save this string length when we first check
> it, then we can simply use memcpy instead of strcpy later, avoiding
> the gcc truncation warnings.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 9705051690..ba6335e71a 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -830,6 +830,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>      int sock, fd;
>      char *pathbuf = NULL;
>      const char *path;
> +    size_t pathlen;
>  
>      sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
>      if (sock < 0) {
> @@ -845,7 +846,8 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>          path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX", tmpdir);
>      }
>  
> -    if (strlen(path) > sizeof(un.sun_path)) {
> +    pathlen = strlen(path);
> +    if (pathlen > sizeof(un.sun_path)) {
>          error_setg(errp, "UNIX socket path '%s' is too long", path);
>          error_append_hint(errp, "Path must be less than %zu bytes\n",
>                            sizeof(un.sun_path));
> @@ -877,7 +879,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>  
>      memset(&un, 0, sizeof(un));
>      un.sun_family = AF_UNIX;
> -    strncpy(un.sun_path, path, sizeof(un.sun_path));
> +    memcpy(un.sun_path, path, pathlen);
>  
>      if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
>          error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
> @@ -901,6 +903,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>  {
>      struct sockaddr_un un;
>      int sock, rc;
> +    size_t pathlen;
>  
>      if (saddr->path == NULL) {
>          error_setg(errp, "unix connect: no path specified");
> @@ -913,7 +916,8 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>          return -1;
>      }
>  
> -    if (strlen(saddr->path) > sizeof(un.sun_path)) {
> +    pathlen = strlen(saddr->path);
> +    if (pathlen > sizeof(un.sun_path)) {
>          error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
>          error_append_hint(errp, "Path must be less than %zu bytes\n",
>                            sizeof(un.sun_path));
> @@ -922,7 +926,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>  
>      memset(&un, 0, sizeof(un));
>      un.sun_family = AF_UNIX;
> -    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
> +    memcpy(un.sun_path, saddr->path, pathlen);
>  
>      /* connect to peer */
>      do {
> 


