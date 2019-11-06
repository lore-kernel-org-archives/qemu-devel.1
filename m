Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0821C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61800217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZikmHNGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61800217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSSKg-0005iT-DY
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 15:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iSSJg-0005GJ-Sx
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iSSJe-0005jF-A9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:54:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58684
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iSSJd-0005ip-S4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573073648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BruKI8Ooxoxi52h6s38yEJbYNN0A9gAUNFg1uMnlB2I=;
 b=ZikmHNGq4/d4WyhEX6kKWRqpzDma4oMFxm+B8SU+zl+S7MXv/Mc546lpC5hI4ofDnacd+a
 lruRDUiYzMRa5D9QmspJLzonbSQphE+WvzYerOjQIpVhs5SWgKS3otmhCOc5XCyXfg0BSc
 K4R8LEeEcyyhtG9y+aRXLpaLspI6JyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-ZDSMn9jfN8qTfsrIo67ufw-1; Wed, 06 Nov 2019 15:54:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5426C107ACC3;
 Wed,  6 Nov 2019 20:54:04 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46E5F1001DC0;
 Wed,  6 Nov 2019 20:54:00 +0000 (UTC)
Date: Wed, 6 Nov 2019 17:53:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v14 03/11] tests: Add test for QAPI builtin type time
Message-ID: <20191106205359.GR3812@habkost.net>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-4-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191028075220.25673-4-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZDSMn9jfN8qTfsrIo67ufw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 jingqi.liu@intel.com, fan.du@intel.com, mdroth@linux.vnet.ibm.com,
 armbru@redhat.com, jonathan.cameron@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 03:52:12PM +0800, Tao Xu wrote:
> Add tests for time input such as zero, around limit of precision,
> signed upper limit, actual upper limit, beyond limits, time suffixes,
> and etc.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
[...]
> +    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
> +    qdict =3D keyval_parse("time1=3D9223372036854774784," /* 7ffffffffff=
ffc00 */
> +                         "time2=3D9223372036854775295", /* 7ffffffffffff=
dff */
> +                         NULL, &error_abort);
> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    qobject_unref(qdict);
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +    visit_type_time(v, "time1", &time, &error_abort);
> +    g_assert_cmphex(time, =3D=3D, 0x7ffffffffffffc00);
> +    visit_type_time(v, "time2", &time, &error_abort);
> +    g_assert_cmphex(time, =3D=3D, 0x7ffffffffffffc00);

I'm confused by this test case and the one below[1].  Are these
known bugs?  Shouldn't we document them as known bugs?

> +    visit_check_struct(v, &error_abort);
> +    visit_end_struct(v, NULL);
> +    visit_free(v);
> +
> +    /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
> +    qdict =3D keyval_parse("time1=3D18446744073709549568," /* ffffffffff=
fff800 */
> +                         "time2=3D18446744073709550591", /* ffffffffffff=
fbff */
> +                         NULL, &error_abort);
> +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> +    qobject_unref(qdict);
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +    visit_type_time(v, "time1", &time, &error_abort);
> +    g_assert_cmphex(time, =3D=3D, 0xfffffffffffff800);
> +    visit_type_time(v, "time2", &time, &error_abort);
> +    g_assert_cmphex(time, =3D=3D, 0xfffffffffffff800);

[1]

> +    visit_check_struct(v, &error_abort);
> +    visit_end_struct(v, NULL);
> +    visit_free(v);
[...]

--=20
Eduardo


