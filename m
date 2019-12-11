Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A68C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D0220836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhmMzfwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D0220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7lu-0003Lr-EI
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 14:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1if7l7-0002p2-C1
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1if7l6-0007EP-AC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:34:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1if7l6-0007Cx-6E
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576092891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=EvL3Eu6gM9rFJAYk4S8GQvXrQJltwHv5NBVd1Zvynkc=;
 b=XhmMzfwi6kGjyPD0auog8nyhiyKlNyAEznCqtj69Q2lkUtxpqtkhbPNS1xFDt5E6murjDM
 7Sg6xoZ3nD3KMELoZREqPWcUjFeUNNh97BoOaK+Qq0OUUdS376Hnb0VzIL0lkTZC6Lei15
 EKWB1xtcb9bPgQYwYVqu4wfZGU8D7vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-5CPXrMHeOz2f3_5EtOGiqw-1; Wed, 11 Dec 2019 14:34:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2BB9190D35E;
 Wed, 11 Dec 2019 19:34:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-85.ams2.redhat.com [10.36.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EDCA60303;
 Wed, 11 Dec 2019 19:34:45 +0000 (UTC)
Subject: Re: [PATCH] vhost-user-scsi: fix printf format warning
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576074210-52834-9-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7f69f423-e5ba-7aa8-a522-615a230ffbde@redhat.com>
Date: Wed, 11 Dec 2019 20:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576074210-52834-9-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5CPXrMHeOz2f3_5EtOGiqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/2019 15.23, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Fixes:
> ../contrib/vhost-user-scsi/vhost-user-scsi.c:118:57: error: format specif=
ies
>       type 'unsigned char' but the argument has type 'int' [-Werror,-Wfor=
mat]
>     g_warning("Unable to determine cdb len (0x%02hhX)", cdb[0] >> 5);
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
> index 0fc14d7..7a1db16 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -115,7 +115,7 @@ static int get_cdb_len(uint8_t *cdb)
>      case 4: return 16;
>      case 5: return 12;
>      }
> -    g_warning("Unable to determine cdb len (0x%02hhX)", cdb[0] >> 5);
> +    g_warning("Unable to determine cdb len (0x%02hhX)", (uint8_t)(cdb[0]=
 >> 5));
>      return -1;
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>


