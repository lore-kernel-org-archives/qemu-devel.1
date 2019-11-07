Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DFFC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7DB2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtOTavz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7DB2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShtj-0002tH-RD
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iShsk-0002OZ-H5
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iShsi-0007VN-Gn
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:31:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iShsh-0007TD-CS
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573133482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cvQjp0SjHhd96TYT+D1xPl8ivhPCmyiByte06QkLKw=;
 b=GtOTavz2kRsWKiVovIe7mtU4ozzIDMwjRj3DQ45rHhQORs9qzk62fIiA7l8rT/nQ2GqzAt
 FsFI5+rAwTRE5nvOrQkhyDPWIPszF1SEh7VVGa5FU0d9w8XOS3VAH9zyWkTCfl4JKgLvKD
 PRfSsgCC67lxp3xwjsw2PIj+YswPmfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-kX5fVd3DP1GoKEtvbSA2DA-1; Thu, 07 Nov 2019 08:31:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E4238017E0;
 Thu,  7 Nov 2019 13:31:18 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E941600F0;
 Thu,  7 Nov 2019 13:31:14 +0000 (UTC)
Date: Thu, 7 Nov 2019 10:31:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v14 03/11] tests: Add test for QAPI builtin type time
Message-ID: <20191107133112.GS3812@habkost.net>
References: <20191028075220.25673-1-tao3.xu@intel.com>
 <20191028075220.25673-4-tao3.xu@intel.com>
 <20191106205359.GR3812@habkost.net>
 <1f2fa942-0993-548b-1f5c-8345d564bf29@intel.com>
MIME-Version: 1.0
In-Reply-To: <1f2fa942-0993-548b-1f5c-8345d564bf29@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kX5fVd3DP1GoKEtvbSA2DA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 02:24:52PM +0800, Tao Xu wrote:
> On 11/7/2019 4:53 AM, Eduardo Habkost wrote:
> > On Mon, Oct 28, 2019 at 03:52:12PM +0800, Tao Xu wrote:
> > > Add tests for time input such as zero, around limit of precision,
> > > signed upper limit, actual upper limit, beyond limits, time suffixes,
> > > and etc.
> > >=20
> > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > > ---
> > [...]
> > > +    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) =
*/
> > > +    qdict =3D keyval_parse("time1=3D9223372036854774784," /* 7ffffff=
ffffffc00 */
> > > +                         "time2=3D9223372036854775295", /* 7ffffffff=
ffffdff */
> > > +                         NULL, &error_abort);
> > > +    v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
> > > +    qobject_unref(qdict);
> > > +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> > > +    visit_type_time(v, "time1", &time, &error_abort);
> > > +    g_assert_cmphex(time, =3D=3D, 0x7ffffffffffffc00);
> > > +    visit_type_time(v, "time2", &time, &error_abort);
> > > +    g_assert_cmphex(time, =3D=3D, 0x7ffffffffffffc00);
> >=20
> > I'm confused by this test case and the one below[1].  Are these
> > known bugs?  Shouldn't we document them as known bugs?
>=20
> Because do_strtosz() or do_strtomul() actually parse with strtod(), so th=
e
> precision is 53 bits, so in these cases, 7ffffffffffffdff and
> fffffffffffffbff are rounded.

My questions remain: why isn't this being treated like a bug?

--=20
Eduardo


