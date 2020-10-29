Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B163C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A181620727
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hfusm4ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A181620727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY5dK-0001EI-Gk
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kY5ck-0000hx-AW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kY5ch-0003Ph-Fr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603969056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qUobfChgR8/6lkiRjzQNF0SVoDxhzLwdJ3Inz6If66c=;
 b=Hfusm4ixrW2wuCQyNAirOf6XbPAWUGzXvHmfhacIZ14Z8l3bZil7ayQC3RQSHL5maPpZqx
 N+Qhj+GW8Wpc6doXCv78AG7SznV/TcFhKSiSeSZoc2ZGEkGUxqXiqvY48nsXgI0LZH/9hy
 nyx13p3plQRSVJhlx0Jg9DKyAcvINjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-KNxDxf-SPbCnGZgbaD-lSA-1; Thu, 29 Oct 2020 06:57:34 -0400
X-MC-Unique: KNxDxf-SPbCnGZgbaD-lSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 700551900081;
 Thu, 29 Oct 2020 10:57:33 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB0FC1974D;
 Thu, 29 Oct 2020 10:57:32 +0000 (UTC)
Date: Thu, 29 Oct 2020 06:57:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: Dynamic instance properties in TYPE_ARM_CPU
Message-ID: <20201029105731.GI5733@habkost.net>
References: <20201026172219.GA5733@habkost.net>
 <20201029101627.umh4gqxiujwde4xp@kamzik.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201029101627.umh4gqxiujwde4xp@kamzik.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 11:16:27AM +0100, Andrew Jones wrote:
> On Mon, Oct 26, 2020 at 01:22:19PM -0400, Eduardo Habkost wrote:
> > I've been trying to clean up the qdev property code (to bridge
> > the gaps between qdev and QOM, and between QOM and QAPI), and
> > I've noticed that TYPE_ARM_CPU is the only remaining user of
> > qdev_property_add_static().
> > 
> > qdev_property_add_static() has a misleading name: it won't
> > register a static property.  It is actually a hack to use a
> > static Property variable (defined using DEFINE_PROP*), but
> > register it as a dynamic instance property.
> > 
> > Dynamic instance properties make introspection hard.  What can we
> > do to get rid of them in TYPE_ARM_CPU?
> > 
> > Can we just register all the properties unconditionally, and
> > error out on realize if the requested CPU configuration is
> > incompatible with the available CPU features?
> > 
> > The following properties are registered as dynamic instance
> > properties at arm_cpu_post_init():
> > "cntfrq", "reset-cbar", "reset-hivecs", "rvbar", "has_el2",
> > "has_el3", "cfgend", "vfp", "neon", "dsp", "has-mpu",
> > "pmsav7-dregion", "secure-memory", "pmu", "idau", "init-svtor",
> > "tag-memory", "secure-tag-memory".
> 
> Hi Eduardo,
> 
> Are properties added at runtime with
> 
>   if (this_config_wants_this_property)
>     object_property_add(...)
> 
> also considered dynamic instance properties? If so, then
> arm as many more than the ones listed above. And, if not,
> then it should be pretty easy to convert the ones listed
> above to this if-want-add pattern.

Yeah, all object_property_add() calls are also dynamic instance
properties.

Being conditional makes them more difficult to convert to
introspectable class properties (unless the condition is a
function of class information only).

-- 
Eduardo


