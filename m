Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC39C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7AF207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxV/sMUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7AF207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioY0X-00060R-Bc
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ioXYt-0001zA-TS
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ioXYs-0003oV-Jv
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:57:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ioXYs-0003o6-Fs
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578337030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yw+PxDAygc39+OT5Uw/VZinsoASgcc3XbKbTThXogJ4=;
 b=OxV/sMUDI63dBN78wg2nRVm27hz02ctD9j2nT3KfUFs3AJa489x0HBx62LVmQ+BQeotKLx
 GVolsoSx18YkN/MIZKGiuWPl2MUsZjTSk14elk1zyn1L4ts3jlVjM2gBthZi+186DNv+1R
 vNHbVfVDq7CG1Wkr7urYlS+kPk+HIog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-hYrkj7rEMTmGrRTMQTLb7w-1; Mon, 06 Jan 2020 13:57:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6BBB802C82;
 Mon,  6 Jan 2020 18:57:05 +0000 (UTC)
Received: from work-vm (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF6F55C290;
 Mon,  6 Jan 2020 18:57:04 +0000 (UTC)
Date: Mon, 6 Jan 2020 18:57:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v1 05/59] ram.c: remove unneeded labels
Message-ID: <20200106185702.GN2798@work-vm>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-6-danielhb413@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200106182425.20312-6-danielhb413@gmail.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: hYrkj7rEMTmGrRTMQTLb7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel Henrique Barboza (danielhb413@gmail.com) wrote:
> ram_save_queue_pages() has an 'err' label that can be replaced by
> 'return -1' instead.
>=20
> Same thing with ram_discard_range(), and in this case we can also
> get rid of the 'ret' variable and return either '-1' on error
> or the result of ram_block_discard_range().
>=20
> CC: Juan Quintela <quintela@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 96feb4062c..980cc644d7 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2434,7 +2434,7 @@ int ram_save_queue_pages(const char *rbname, ram_ad=
dr_t start, ram_addr_t len)
>               * it's the 1st request.
>               */
>              error_report("ram_save_queue_pages no previous block");
> -            goto err;
> +            return -1;
>          }
>      } else {
>          ramblock =3D qemu_ram_block_by_name(rbname);
> @@ -2442,7 +2442,7 @@ int ram_save_queue_pages(const char *rbname, ram_ad=
dr_t start, ram_addr_t len)
>          if (!ramblock) {
>              /* We shouldn't be asked for a non-existent RAMBlock */
>              error_report("ram_save_queue_pages no block '%s'", rbname);
> -            goto err;
> +            return -1;
>          }
>          rs->last_req_rb =3D ramblock;
>      }
> @@ -2451,7 +2451,7 @@ int ram_save_queue_pages(const char *rbname, ram_ad=
dr_t start, ram_addr_t len)
>          error_report("%s request overrun start=3D" RAM_ADDR_FMT " len=3D=
"
>                       RAM_ADDR_FMT " blocklen=3D" RAM_ADDR_FMT,
>                       __func__, start, len, ramblock->used_length);
> -        goto err;
> +        return -1;
>      }
> =20
>      struct RAMSrcPageRequest *new_entry =3D
> @@ -2467,9 +2467,6 @@ int ram_save_queue_pages(const char *rbname, ram_ad=
dr_t start, ram_addr_t len)
>      qemu_mutex_unlock(&rs->src_page_req_mutex);
> =20
>      return 0;
> -
> -err:
> -    return -1;
>  }
> =20
>  static bool save_page_use_compression(RAMState *rs)
> @@ -3072,8 +3069,6 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
>   */
>  int ram_discard_range(const char *rbname, uint64_t start, size_t length)
>  {
> -    int ret =3D -1;
> -
>      trace_ram_discard_range(rbname, start, length);
> =20
>      RCU_READ_LOCK_GUARD();
> @@ -3081,7 +3076,7 @@ int ram_discard_range(const char *rbname, uint64_t =
start, size_t length)
> =20
>      if (!rb) {
>          error_report("ram_discard_range: Failed to find block '%s'", rbn=
ame);
> -        goto err;
> +        return -1;
>      }
> =20
>      /*
> @@ -3093,10 +3088,7 @@ int ram_discard_range(const char *rbname, uint64_t=
 start, size_t length)
>                       length >> qemu_target_page_bits());
>      }
> =20
> -    ret =3D ram_block_discard_range(rb, start, length);
> -
> -err:
> -    return ret;
> +    return ram_block_discard_range(rb, start, length);
>  }
> =20
>  /*
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


