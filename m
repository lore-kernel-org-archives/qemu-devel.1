Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8611CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C499F214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8IG6p3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C499F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6qP-0005xS-Hn
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL6pW-0005RJ-AQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kL6pU-0007fk-2E
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600875431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWYDSTLP+f69AXB7pWwAQqyWMaoVxI7TDHyx58V4+zY=;
 b=G8IG6p3Kr2hseWR/PWiwER1LV3ywK+8InhgSxniTbpH1ekiOyWbp/wWOTbJD4VwOc15dwR
 pd5aiGRyCEudEsO8kMP5+haPB53nHYX+H2nT+QSCYTQVPtej3ippNu3zqW16axxK+EMNZD
 D7/7UV6RlOLV1oe69Dh7WBxn2Tm0Bw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-nMiuPQOZOvS9biSAbPyCZA-1; Wed, 23 Sep 2020 11:37:09 -0400
X-MC-Unique: nMiuPQOZOvS9biSAbPyCZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C3A551B4;
 Wed, 23 Sep 2020 15:37:08 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF3E155764;
 Wed, 23 Sep 2020 15:37:07 +0000 (UTC)
Date: Wed, 23 Sep 2020 11:37:07 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add Python library stanza
Message-ID: <20200923153707.GP3312949@habkost.net>
References: <20200922230505.4089701-1-jsnow@redhat.com>
 <20200922230505.4089701-2-jsnow@redhat.com>
 <87wo0k34qp.fsf@dusky.pond.sub.org>
 <ce23c70a-2e0e-0ca1-5260-812d713f04a8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ce23c70a-2e0e-0ca1-5260-812d713f04a8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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
Cc: peter.maydell@linaro.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, crosa@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 11:17:01AM -0400, John Snow wrote:
> On 9/23/20 11:14 AM, Markus Armbruster wrote:
> > John Snow <jsnow@redhat.com> writes:
> > 
> > > I'm proposing that I split the actual Python library off from the other
> > > miscellaneous python scripts we have and declare it maintained. Add
> > > myself as a maintainer of this folder, along with Cleber.
> > > 
> > > v2: change python/* to python/, thanks Alex.
> > > 
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > > Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > > Acked-by: Cleber Rosa <crosa@redhat.com>
> > > Acked-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >   MAINTAINERS | 9 ++++++++-
> > >   1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 3d17cad19a..c0222ee645 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2355,11 +2355,18 @@ S: Maintained
> > >   F: include/sysemu/cryptodev*.h
> > >   F: backends/cryptodev*.c
> > > +Python library
> > > +M: John Snow <jsnow@redhat.com>
> > > +M: Cleber Rosa <crosa@redhat.com>
> > > +R: Eduardo Habkost <ehabkost@redhat.com>
> > > +S: Maintained
> > > +F: python/
> > > +T: git https://gitlab.com/jsnow/qemu.git python
> > > +
> > >   Python scripts
> > >   M: Eduardo Habkost <ehabkost@redhat.com>
> > >   M: Cleber Rosa <crosa@redhat.com>
> > >   S: Odd fixes
> > > -F: python/qemu/*py
> > >   F: scripts/*.py
> > >   F: tests/*.py
> > 
> > Separate sections just so you can have the appropriate S:, or is there a
> > deeper logic behind the split?
> > 
> 
> Yes, different intended levels of support. I don't currently have the
> bandwidth to promise support for the miscellaneous Python scripts in
> ./scripts, but I do promise to support to a higher level the code in
> ./python.
> 
> Over time, I intend to migrate things into ./python, but there are some
> series that need to happen first before I start doing that.

Also, the actual owners for most scripts in ./scripts are already
listed elsewhere.  I believe we shouldn't really have M: lines
for the scripts/*.py section, just R:.

-- 
Eduardo


