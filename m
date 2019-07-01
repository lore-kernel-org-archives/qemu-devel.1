Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2150CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F9F208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F9F208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhso8-0002kd-PN
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hhsli-0008LC-8P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hhslg-0006hf-Qv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:38:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hhslg-00068X-KU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:38:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D3AB30872EE;
 Mon,  1 Jul 2019 09:37:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 750CD19C77;
 Mon,  1 Jul 2019 09:37:52 +0000 (UTC)
Date: Mon, 1 Jul 2019 10:37:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: P J P <ppandit@redhat.com>
Message-ID: <20190701093749.GE3573@redhat.com>
References: <20190701090904.31312-1-ppandit@redhat.com>
 <20190701090904.31312-4-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701090904.31312-4-ppandit@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 01 Jul 2019 09:37:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/3] net: tap: restrict bridge name to
 IFNAMSIZ
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Riccardo Schirone <rschiron@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 02:39:04PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> The interface name in Linux interface request struct 'ifreq'
> OR in qemu-bridge-helper is defined to be of size IFNAMSIZ(=16),
> including the terminating null('\0') byte.
> 
> QEMU tap device, while invoking qemu-bridge-helper, supplies bridge
> name of 16 characters, restrict it to IFNAMESIZ-1 to accommodate
> terminating null('\0') byte.
> 
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  net/tap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/tap.c b/net/tap.c
> index e8aadd8d4b..ca8536624c 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -499,7 +499,7 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>      if (pid == 0) {
>          int open_max = sysconf(_SC_OPEN_MAX), i;
>          char fd_buf[6+10];
> -        char br_buf[6+IFNAMSIZ] = {0};
> +        char br_buf[5+IFNAMSIZ] = {0};
>          char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) + 15];
>  
>          for (i = 3; i < open_max; i++) {

Playing games with multiple "perfectly" sized static buffers & snprintf
is madness. How about re-writing this method so that it just uses
g_strdup_printf() to dynamically format the helper_cmd string.

Alternatively we could get rid of the use of shell and directly exec
the helper program. This would let us just pass argv[] and avoid the
printf'ing entirely.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

