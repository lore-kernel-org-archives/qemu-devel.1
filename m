Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75560C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4187C20645
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4187C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54229 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEW8-0005UK-G7
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:25:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMER6-0001ss-F8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMEQu-0006DG-7u
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:19:51 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMEQt-0005Rt-Pv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:19:40 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1Mr8SG-1h0wd23yn0-00oI0P; Thu, 02 May 2019 18:18:35 +0200
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-4-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <819471a3-44de-91d8-d21e-887769d6e3a3@vivier.eu>
Date: Thu, 2 May 2019 18:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190412121626.19829-4-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pwhkw+J4kbkJMYOKrtrElij71QGvELktyrGrZcySi977ZOJcdZv
	1gupS7jQkMMjLxZpcSYhjilekfrWivotBUcCnrtiUnn4THYfCH5uODWPPlSkbE/PB8yczpn
	HC3myZ5IdsyeGwsaitVzJP0xOfKolGGNYlCGpHHKCxZ+Etue9o9By5PrTSAGw72ZxaOmXcB
	pi0HebHoaN8zQM6eFyeCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lA6wn0XuDq8=:f7k2A023DhLcLQ2r3bkfwA
	khkbL3KgXx0Rz2YFPQGesZhUOJYysf4tEtH9vaOE/hOSv0xbPquhO3I9yhwDrqCVwpHp1+Ts5
	tpJntu/hl+VUI1dCr+cOXksyjIUEd2tea/gzIYJ9I7q7MiB6BQOjjuXxvLBDBgUiGCQCgQ7Li
	tMeWqskNgZ2VcJDkbTJzV3c2RDdnU6OEhkQAAbdwuxB8hEjWO+KCZSLkOLTe1F5PVeqYhUV12
	KnCHJxDYQvSgLh3VF065Izx+7haFY4YM4K3X6Jrj0b/Vp+pNs6qREjmrjdVB0on+hL13z8N+f
	Gg1lDcAR8SR/pUYH33/kbsjar3EhfmMzyBlTPpnU3cqEzl7QplZsDYolt4QDOrKGfKIPDXf/a
	zkFPs6stLRBxMvFDXAHGYiiAry4heHxKeyucrQANLxRCRZxP8UyztMKflh5sTHss0Uv494+xW
	PHal5u8vfT6v3H0XBvCNFpDlXznSenaJuJnHXedESk74nwMPhc8ITTAABB0MPAPT7a5rGUgiQ
	Oi6cfiojWmqmIvqG4qnG/rlSgUGNT8+hSZMiQQSMlOTma2S8n7rNGknhpcNlg29S6wBFAoWyM
	C9O0aM3Zdq+LotK+6OdbV9V6SFR2GwCcIsEVSKxxn3cx1Inmw3Nn8DxSwkwMg427/IjpeaabH
	ghl0XrTdQfLRN5wV+r3/4zvpxePmA+OAi6jL4x6BxwmSq0jYvPpXak4pq2lvSPWCZZN2aI4ND
	HhmPvYSrrBVNvPb//ACIrzgbLnjrLyD6GMVH6q0ACbOB4H+JUdNZ/y4dE4k=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Message-ID: <20190502161833.6WvFbodlg71hayV2kkpvIf3Rf1h1ADOVrKxG0R47zOs@z>

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


Applied to my trivial-patches branch.

Thanks,
Laurent

