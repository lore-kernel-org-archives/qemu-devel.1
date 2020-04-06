Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B63CC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DC6249C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="hQqdR5jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DC6249C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVNs-0004JT-WA
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1jLVMc-0002dg-TX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1jLVMb-0000MR-Ux
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:16:46 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:35047)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1jLVMZ-0000Jj-G0; Mon, 06 Apr 2020 13:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1586193403;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=dw9qolkhXIn6b0T6yhcbrD/aJmWH4v6hLGN3vF3fBK8=;
 b=hQqdR5jE63yWB5w7Ig8d2yj03df7FGQtChTFInojnWKL5Qn+NuDiyP6Y
 +khI4iJ4SbzX8fPbYpV/1/kGpfrcWaEDRn8wZl1cqtxzn8lp1wgG7fTvR
 OjGYTJWDXjkgnzJaKWyM+qxrkzo4mS2LCoBtkaxtO55L+99IaDbZ4m9w5 M=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 61p/Hxv70zQnfNanLwCuMtI/mdPU1ZSSxLjAFfIgef6sApVUYnSJHMAYfOnW8uANV8AS2N0yIT
 Vf5v+Gaf8ayKF/U65vNby/Q7N4/I0KbK6CJoGwtUDEig5ia3pGgahxl5DxhFbP2iIkmEJTVTRr
 GlWxFF0NpRtXbvUqwyXTeoER8101SH6FWaDPaopeKkipPXDaLfWYySeqtr8JnNpaUepwhNdNxD
 Xty56atu35YBojAZtk94S+7IiroEpM1m7hWd6TBP5Q/no0osAtmn6sfC030hQzwynqpZg1JS85
 9lk=
X-SBRS: 2.7
X-MesageID: 15573591
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,351,1580792400"; d="scan'208";a="15573591"
Date: Mon, 6 Apr 2020 18:16:37 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH for-5.0] xen-block: Fix uninitialized variable
Message-ID: <20200406171637.GU4088@perard.uk.xensource.com>
References: <20200406164207.1446817-1-anthony.perard@citrix.com>
 <325e0ffb-2f1b-cbfd-6b24-0d912a9aabe2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <325e0ffb-2f1b-cbfd-6b24-0d912a9aabe2@redhat.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.168
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 06, 2020 at 06:50:41PM +0200, Philippe Mathieu-Daudé wrote:
> On 4/6/20 6:42 PM, Anthony PERARD wrote:
> > Since 7f5d9b206d1e ("object-add: don't create return value if
> > failed"), qmp_object_add() don't write any value in 'ret_data', thus
> > has random data. Then qobject_unref() fails and abort().
> > 
> > Fix by initialising 'ret_data' properly.
> 
> Or move qobject_unref() after the error check?
> 
> -- >8 --
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 07bb32e22b..f3f1cbef65 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -869,7 +869,6 @@ static XenBlockIOThread *xen_block_iothread_create(const
> char *id,
>      qdict_put_str(opts, "id", id);
>      qmp_object_add(opts, &ret_data, &local_err);
>      qobject_unref(opts);
> -    qobject_unref(ret_data);
> 
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -878,6 +877,7 @@ static XenBlockIOThread *xen_block_iothread_create(const
> char *id,
>          g_free(iothread);
>          return NULL;
>      }
> +    qobject_unref(ret_data);

That won't help, qmp_object_add() doesn't change the value of ret_data
at all. The other users of qmp_object_add() passes an initialised
'ret_data', so we should do the same I think.

Thanks,

-- 
Anthony PERARD

