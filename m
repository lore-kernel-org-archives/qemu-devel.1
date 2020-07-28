Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED7C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8FB206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiOlH4a+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8FB206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RPC-0000fr-Tk
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0RJZ-0008FV-77
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:14:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0RJW-0000C8-Q3
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595949285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=anc8Br3qGriCA+r6335+UsYnHuX3VQmWprTUm7ERQvQ=;
 b=DiOlH4a+VoKddFGi04XmtuO6bwewtrICyqyJqY5lHTdX/ktiA6U5QG3Pltp3ioZxO5D+Xx
 LacKDUqlSH0aZ3+MmF2Zavdfm29EDQqXmVR7Vekkva+9AyIEgozxa7GtvbrSKdXjR6oUo4
 iFdaXTBX9p926f5g0EBQ96wp4c6Lzcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-OvuIJ47dPJO2HMw85JG66A-1; Tue, 28 Jul 2020 11:14:43 -0400
X-MC-Unique: OvuIJ47dPJO2HMw85JG66A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE56B8015CE;
 Tue, 28 Jul 2020 15:14:41 +0000 (UTC)
Received: from gondolin (ovpn-113-128.ams2.redhat.com [10.36.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C35F510013C4;
 Tue, 28 Jul 2020 15:14:40 +0000 (UTC)
Date: Tue, 28 Jul 2020 17:14:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PULL 2/2] s390x/s390-virtio-ccw: fix loadparm property getter
Message-ID: <20200728171438.2c3eb4fb.cohuck@redhat.com>
In-Reply-To: <CAFEAcA_1xECE+ESWoioHFSF_mwDG11NrR2=J3NWx2X+OGg3SZw@mail.gmail.com>
References: <20200727140522.251815-1-cohuck@redhat.com>
 <20200727140522.251815-3-cohuck@redhat.com>
 <CAFEAcA_1xECE+ESWoioHFSF_mwDG11NrR2=J3NWx2X+OGg3SZw@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 11:04:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 14:52:36 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 27 Jul 2020 at 15:05, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > From: Halil Pasic <pasic@linux.ibm.com>
> >
> > The function machine_get_loadparm() is supposed to produce a C-string,
> > that is a NUL-terminated one, but it does not. ElectricFence can detect
> > this problem if the loadparm machine property is used.
> >
> > Let us make the returned string a NUL-terminated one.
> >
> > Fixes: 7104bae9de ("hw/s390x: provide loadparm property for the machine")
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Message-Id: <20200723162717.88485-1-pasic@linux.ibm.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/s390-virtio-ccw.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index 8cc2f25d8a6a..403d30e13bca 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -701,8 +701,12 @@ bool hpage_1m_allowed(void)
> >  static char *machine_get_loadparm(Object *obj, Error **errp)
> >  {
> >      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> > +    char *loadparm_str;
> >
> > -    return g_memdup(ms->loadparm, sizeof(ms->loadparm));
> > +    /* make a NUL-terminated string */
> > +    loadparm_str = g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1);
> > +    loadparm_str[sizeof(ms->loadparm)] = 0;
> > +    return loadparm_str;  
> 
> Hi. Coverity points out (CID 1431058) that this code now
> reads off the end of the ms->loadparm buffer, because
> g_memdup() is going to read and copy 9 bytes (size + 1)
> and the array itself is only 8 bytes.
> 
> I don't think you can use g_memdup() here -- you need to
> allocate the memory with g_malloc() and then fill it with
> memcpy(), something like:
> 
>     loadparm_str = g_malloc(sizeof(ms->loadparm) + 1);
>     memcpy(loadparm_str, ms->loadparm, sizeof(ms->loadparm));
>     loadparm_str[sizeof(ms->loadparm)] = 0;

Sigh.

Halil, do you have time to cook up a patch?


