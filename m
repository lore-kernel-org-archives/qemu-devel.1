Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B28C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DF620796
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMgbnrai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DF620796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqgO-0000JL-EK
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPqfq-0008Jt-0E
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPqfo-00065q-8p
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602004966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AX/BsjIMTUmX97tgxbcIjkZFq0QhAgjeKEXbEkWuGl0=;
 b=XMgbnraiTE6rYSkyRSj2FgWUVaE4/h5376SHaJqCI/Usf2AQbc2P2gw3XQnXzEwDFT+Kou
 Z6kLG5q16ClNiN/375xyV1xoI06PigK6KnNIZthw7k/3KDQ+1pHGxrQHtje0PeWClPZplK
 AYbrUon8+isZUQECtgNlzB/JuVHiMaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-VtAcrhMWPnKAEHWuwi9MFw-1; Tue, 06 Oct 2020 13:22:41 -0400
X-MC-Unique: VtAcrhMWPnKAEHWuwi9MFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFA101019628
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 17:22:40 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 744656CE4E;
 Tue,  6 Oct 2020 17:22:40 +0000 (UTC)
Date: Tue, 6 Oct 2020 13:22:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/3] docs/devel/qtest: Include libqtest API reference
Message-ID: <20201006172239.GQ7303@habkost.net>
References: <20201005205228.697463-1-ehabkost@redhat.com>
 <20201005205228.697463-4-ehabkost@redhat.com>
 <62336b4c-79b7-287b-8d9d-c269ce213c61@redhat.com>
MIME-Version: 1.0
In-Reply-To: <62336b4c-79b7-287b-8d9d-c269ce213c61@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 06, 2020 at 07:12:17PM +0200, Thomas Huth wrote:
> On 05/10/2020 22.52, Eduardo Habkost wrote:
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >   docs/devel/qtest.rst          |  6 ++++++
> >   tests/qtest/libqos/libqtest.h | 20 ++++++++++----------
> >   2 files changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/docs/devel/qtest.rst b/docs/devel/qtest.rst
> > index 3bf9ebee7f0..075fe5f7d53 100644
> > --- a/docs/devel/qtest.rst
> > +++ b/docs/devel/qtest.rst
> > @@ -64,3 +64,9 @@ QTest Protocol
> >   .. kernel-doc:: softmmu/qtest.c
> >      :doc: QTest Protocol
> > +
> > +
> > +libqtest API reference
> > +----------------------
> > +
> > +.. kernel-doc:: tests/qtest/libqos/libqtest.h
> > diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
> > index a6ee1654f20..209fcf69737 100644
> > --- a/tests/qtest/libqos/libqtest.h
> > +++ b/tests/qtest/libqos/libqtest.h
> > @@ -24,7 +24,7 @@ typedef struct QTestState QTestState;
> >   /**
> >    * qtest_initf:
> > - * @fmt...: Format for creating other arguments to pass to QEMU, formatted
> > + * @fmt: Format for creating other arguments to pass to QEMU, formatted
> >    * like sprintf().
> >    *
> >    * Convenience wrapper around qtest_init().
> > @@ -87,7 +87,7 @@ void qtest_quit(QTestState *s);
> >    * @s: #QTestState instance to operate on.
> >    * @fds: array of file descriptors
> >    * @fds_num: number of elements in @fds
> > - * @fmt...: QMP message to send to qemu, formatted like
> > + * @fmt: QMP message to send to qemu, formatted like
> >    * qobject_from_jsonf_nofail().  See parse_escape() for what's
> >    * supported after '%'.
> >    *
> > @@ -100,7 +100,7 @@ QDict *qtest_qmp_fds(QTestState *s, int *fds, size_t fds_num,
> >   /**
> >    * qtest_qmp:
> >    * @s: #QTestState instance to operate on.
> > - * @fmt...: QMP message to send to qemu, formatted like
> > + * @fmt: QMP message to send to qemu, formatted like
> 
> I think you should mention those changes to all those "fmt..." in the commit
> message?

Yes.  I mentioned "after converting it to Sphinx syntax" on patch
2/3, but forgot to mention the same thing in this patch.

-- 
Eduardo


