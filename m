Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16090C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870B020791
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7XmzXkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870B020791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9QU-00079w-Im
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL9MN-0003rL-Vl
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL9MM-0007tu-DF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600885156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K7v5yTxWvWtRBoKyqOvfrJprmg5IYOqjnsgnTnrpxEg=;
 b=a7XmzXkSCRHx2BT3XX1tbaf5HRPasuCQrDHPQvmtIuLQnfD8f0hLzJI9cS+JxeaN/petFY
 CYSRusYoZiQKywprmJV37N9tmKlS4ooEciDQsBxECuS0HSp1m6zh9SN77hYPP0LADw3YBW
 R0GiwAyem6NEjGQe9bczdNyR+RBu7Ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-nLoGmoQPNd2cXBnad2Rh1A-1; Wed, 23 Sep 2020 14:19:15 -0400
X-MC-Unique: nLoGmoQPNd2cXBnad2Rh1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB6A801AF7;
 Wed, 23 Sep 2020 18:19:13 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A915860BF1;
 Wed, 23 Sep 2020 18:19:13 +0000 (UTC)
Date: Wed, 23 Sep 2020 14:19:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 13/38] qapi/common.py: add type hint annotations
Message-ID: <20200923181912.GT3312949@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-14-jsnow@redhat.com>
 <20200922224428.GN2044576@habkost.net>
 <66a42a9a-d330-c4a9-e4b9-55b78668704b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <66a42a9a-d330-c4a9-e4b9-55b78668704b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 01:57:25PM -0400, John Snow wrote:
> On 9/22/20 6:44 PM, Eduardo Habkost wrote:
> > Does this need to require a Sequence?  It looks like it could be
> > Iterable.
> > 
> > I don't think this should block the patch, though, so:
> > 
> > Reviewed-by: Eduardo Habkost<ehabkost@redhat.com>
> 
> gen_if can take an Iterator, gen_endif needs a Sequence because it uses
> reversed().
> 
> I have not been very fastidious about choosing the MOST possibly abstracted
> type, but you are right that we SHOULD. I was hoping to find all occurrences
> of List and try slackening them to Collection/Sequence/Iterable etc, but as
> a follow-up.
> 
> In this case, since gen_endif actually does want the stricter type, I'm
> deciding to leave them as Sequence for signature parity.

I hadn't noticed reversed() requires a Sequence.  I agree using
the same type on both is better.  Thanks!

-- 
Eduardo


