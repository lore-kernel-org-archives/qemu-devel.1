Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3B9C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FA0205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="wB7B0X1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FA0205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrnG-0000De-0f
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgrT5-0000xK-7b
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgrT3-0002ZS-GJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:03:11 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:50747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1hgrT1-0002XV-Hr
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DyKh5fYYE41XG80v1fekCHumkdJ+Vh2eDpBHLyjy748=; b=wB7B0X1myZbOo3FgQxLqqA+9Li
 6H+271bjkdAwp7RJL657MUfq6CqjSKbFzS2SvfBrtV1OGkjdNifBQ5eqxwu12MSYy9aPBAFG5H+fM
 oAMomzUQ3iQoOw8q3/Lojsuc6tk1deCYxdMn+1L//WCf4MFg8P/NYmzKYATl0mQGn0p7e657zKink
 b3RicoI0UING5CUA2p/NOVpWl+YeNWpakWnEVV6LTKDjD7bAdByNVxy0ojD/VISR0fCcjc9aBUf7J
 g1O4z+0ojCfYi3W8hJGUhZnb/eLyWx72dbPAgQ0/XUIiNCDQHvouHbP+LEw1i7Jcb/2Wlm4lFqFsb
 ohowJXEDOM86dD40xhB/qVxQMp4nsbPaC06tyangdZy0FfV1S+w72/HY2ATKl7la60PlAkph/2bz0
 h6kgeE6I5NBf8Iev79gzf0lT/Fl5d0yr2OzjBg2PWjskCbqS0xOqEVzoNouo6eIKHENCuDz/scH68
 AbCH40kdHYMdm7yDWObHlDJ1vII2bZPbGpIJB+wfbFVOVEWpmSxbWKChCUxVcBYIq8aljIE8qS5Hx
 amhCYoV+bJR0dYz9/zb2ZpceuZQ2E/0YBcBqsZl+9NUD8B1ygmpVxsoKOyDBtRFyhVN1MUNXKGc39
 mlkHjZ3j1H1sptgll5xBSp9yVAu3UVPi/DCT8PG/8=;
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 16:03:02 +0200
Message-ID: <4090006.s5PtGRB9R1@silver>
In-Reply-To: <20190628122120.60a1ec0b@bahia.lan>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <fa636e323b8644469f9b03619758b6c1c6d1d4f2.1561575449.git.qemu_oss@crudebyte.com>
 <20190628122120.60a1ec0b@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v4 4/5] 9p: stat_to_qid: implement slow path
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 28. Juni 2019 12:21:20 CEST Greg Kurz wrote:
> > +static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
> > +                            uint64_t *path)
> > +{
> > +    QpfEntry lookup = {
> > +        .dev = stbuf->st_dev,
> > +        .ino = stbuf->st_ino
> > +    }, *val;
> > +    uint32_t hash = qpf_hash(lookup);
> > +
> > +    /* most users won't need the fullmap, so init the table lazily */
> > +    if (!pdu->s->qpf_table.map) {
> > +        qht_init(&pdu->s->qpf_table, qpf_lookup_func, 1 << 16,
> > QHT_MODE_AUTO_RESIZE); +    }
> > +
> > +    val = qht_lookup(&pdu->s->qpf_table, &lookup, hash);
> > +
> > +    if (!val) {
> > +        if (pdu->s->qp_fullpath_next == 0) {
> > +            /* no more files can be mapped :'( */
> 
> This would be the place to put the error_report_once() suggested
> in the previous patch actually.

I will add the suggested error message to qid_path_prefixmap() in patch 3 and 
then will move over that error message to qid_path_fullmap() in patch 4.

Or if you want I can also leave an error_report_once() in qid_path_prefixmap() 
in patch 4 about potential degraded performance.

> > @@ -3779,7 +3831,8 @@ void v9fs_device_unrealize_common(V9fsState *s,
> > Error **errp)> 
> >      }
> >      fsdev_throttle_cleanup(s->ctx.fst);
> >      g_free(s->tag);
> > 
> > -    qpp_table_destroy(&s->qpp_table);
> > +    qp_table_destroy(&s->qpp_table);
> > +    qp_table_destroy(&s->qpf_table);
> 
> I'm starting to think v9fs_device_unrealize_common() should be made
> idempotent, so that it can be used to handle rollback of a partially
> realized device, and thus avoid the code duplication. But this is
> out-of-scope for this series.

Well, I can also make that e.g.:

	if (s->qpf_table.map)
		qp_table_destroy(&s->qpf_table);

if you prefer the occurrence amount to be reduced.

Best regards,
Christian Schoenebeck

