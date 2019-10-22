Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034F2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D1F20700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKVVaf9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D1F20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMv9u-0006E8-Jx
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iMuRd-00089u-0C
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iMuRb-0005sT-Sr
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:43:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24656
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iMuRb-0005sE-O9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571751807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/W4zpMPfxin2/+pblGLbLKG/XhDmRWhzIIgHVdIhsBk=;
 b=XKVVaf9d4NAdFgvRrj4ASK8dt3nbtVHtmI1Ozp3osO00njoOZt8kAsdIKADgrZt28iMSRK
 a72FZ/6jFqhzYQmOAdorMscjOQIbvAQDDti5iquZCGZZ2XaNToT4hWDR8In3kpySR5STGf
 gadepr1wEF+IdXsk0Rkf94z/bJSKiGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243--gAuC4VSMHON04l7XP0aUg-1; Tue, 22 Oct 2019 09:43:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97C681800D79;
 Tue, 22 Oct 2019 13:43:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F83960C5E;
 Tue, 22 Oct 2019 13:43:17 +0000 (UTC)
Date: Tue, 22 Oct 2019 15:43:15 +0200
From: Andrew Jones <drjones@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v5 1/9] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
Message-ID: <20191022134315.fuz6dou5f3pxtfte@kamzik.brq.redhat.com>
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-2-drjones@redhat.com>
 <CADSWDztJDUEd+_7XnBPWL1bk5Xh=V_aLc1+VrP97_Ycbe3489A@mail.gmail.com>
 <20191015105628.7ln6ph5s3vpsyfuw@kamzik.brq.redhat.com>
 <CADSWDzsKx7+4mR4pmsqi0+rddUv47q=UKwVt509B8g68UoRiMA@mail.gmail.com>
 <CADSWDzs9sdjE+-1AedPnU6o7U5XjTk=dcHf-BXQXQQkrp2O=Bw@mail.gmail.com>
 <20191016135025.k4szpqwgkhfnd6dl@kamzik.brq.redhat.com>
 <CADSWDzuXpTHDtRmTL41CXbk9GmDHO5iEgpiRgnD=buQU+nnXcg@mail.gmail.com>
 <20191016161628.rf752xuu6fzkihun@kamzik.brq.redhat.com>
 <CADSWDzvT7E9P3uEJDV9z+L=HEBuDRwQ904-GG0M9T-NUz+OsoQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADSWDzvT7E9P3uEJDV9z+L=HEBuDRwQ904-GG0M9T-NUz+OsoQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -gAuC4VSMHON04l7XP0aUg-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 04:07:14PM +0100, Beata Michalska wrote:
> Indeed, the patch got bit messed-up. Apologies for that as well.
> I have been testing manually but I did try the test you have provided
> and yes it fails - there is a slight problem with the case when qdict_in
> is empty,but this can be easily solved still keeping the single loop.
> Otherwise I have seen you have posted a new patchest so I guess we  are
> dropping the idea of refactoring ?

Well, without a patch that applies, I couldn't really evaluate your
proposal. And, TBH, I'd rather not hold this series up on a refactoring
that doesn't provide measurable performance improvements, especially when
it's not in a performance critical path. Indeed, I'd like to get this
series merged as soon as possible, which is why I posted v6 with your
visit_free() fix already.

>=20
> One more question: in case of querying a property which is not supported
> by given cpu model - we are returning properties that are actually valid
> (the test case for cortex-a15 and aarch64 prop).
> Shouldn't we return an error there? I honestly must admit I do not know
> what is the expected behaviour for the qmp query in such cases.

We do generate an error for that case:

(QEMU) query-cpu-model-expansion type=3Dfull model=3D{"name":"cortex-a15"}
{"return": {"model": {"name": "cortex-a15", "props": {"pmu": true}}}}

(QEMU) query-cpu-model-expansion type=3Dfull model=3D{"name":"cortex-a15","=
props":{"aarch64":false}}
{"error": {"class": "GenericError", "desc": "Property '.aarch64' not found"=
}}


If you have any more comments on the series, please send them right away.
I'd like Peter to be able to merge this soon, and I understand that he's
waiting on your review.

Thanks,
drew


