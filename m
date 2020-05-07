Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9D0C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93A820643
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoSiedte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93A820643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhq6-0002EV-LN
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWhp3-0001Tk-RD
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:48:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWhp3-0006Zy-3B
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588862904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/Gp8+TKAboXNhVc0F1Yw9azsNoriCV/6PwkObBqBHk=;
 b=eoSiedteDo2pRN6QMX+1ucLIGZbcC1baIcdKMOq3bXD72aFFO0S7g+Sa948b5zTkaY+XJp
 krP+fzkE6dfJ3nA14lkPLbKRKT27Qui2ePjFTuYPHC76MGJjfpuLR0t7pXsbhFRyTiao5a
 KNgX3ng3PA+s8KjmwjRncD6PhHDASD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-cbARLFjOPeWoTV28VOdugw-1; Thu, 07 May 2020 10:48:16 -0400
X-MC-Unique: cbARLFjOPeWoTV28VOdugw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F36C1895A2B
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 14:48:15 +0000 (UTC)
Received: from work-vm (ovpn-114-224.ams2.redhat.com [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC50F5D9C5;
 Thu,  7 May 2020 14:48:12 +0000 (UTC)
Date: Thu, 7 May 2020 15:48:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] docs/devel/migration: start a debugging section
Message-ID: <20200507144809.GC17348@work-vm>
References: <20200330174852.456148-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200330174852.456148-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Explain how to use analyze-migration.py, this may help.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Queued

> ---
>  docs/devel/migration.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index e88918f7639..2eb08624fc3 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -50,6 +50,26 @@ All these migration protocols use the same infrastruct=
ure to
>  save/restore state devices.  This infrastructure is shared with the
>  savevm/loadvm functionality.
> =20
> +Debugging
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The migration stream can be analyzed thanks to `scripts/analyze_migratio=
n.py`.
> +
> +Example usage:
> +
> +.. code-block:: shell
> +
> +  $ qemu-system-x86_64
> +   (qemu) migrate "exec:cat > mig"
> +  $ ./scripts/analyze_migration.py -f mig
> +  {
> +    "ram (3)": {
> +        "section sizes": {
> +            "pc.ram": "0x0000000008000000",
> +  ...
> +
> +See also ``analyze_migration.py -h`` help for more options.
> +
>  Common infrastructure
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> --=20
> 2.26.0.rc2.42.g98cedd0233
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


