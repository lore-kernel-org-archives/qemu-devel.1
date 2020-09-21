Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A9C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4FE2151B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZg9NXKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4FE2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOAo-00011z-Pj
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKO8q-00006v-0X
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:54:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKO8n-0000aB-FN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600703648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yWKCUXEYwQNRoeWh16KS7yP4yljWdGYDSmcgI1jlcE=;
 b=fZg9NXKLccPp9N2ixEXScQC2amuHwc5VrU8K7sEjEL9ZKJ5QuvUtUUAXJ/wxpm3LN6LTEa
 co+6aGHRkqTl/K5zB2ioMpnG/UIxGqlICbWPxtOBl7m9vA+C7KYQHBLeTKAlqoRzgKKxuB
 I0Y9rs2dKAuMYa3+bZDHRSh80G+ZpHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-IJw2LaRxNVOKpXRcXa-NHw-1; Mon, 21 Sep 2020 11:54:03 -0400
X-MC-Unique: IJw2LaRxNVOKpXRcXa-NHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9591801AE8;
 Mon, 21 Sep 2020 15:54:01 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 696C25577B;
 Mon, 21 Sep 2020 15:54:01 +0000 (UTC)
Date: Mon, 21 Sep 2020 11:54:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: Bottleneck problem to merge Python patches
Message-ID: <20200921155400.GO57321@habkost.net>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
 <CAL1e-=iA95PR-mM9E+nfsvFRJLhQsj5Q9qPAM=7QS9mg-QvcbQ@mail.gmail.com>
 <6ad83ff4-1b4f-69f0-7dbe-85680e2f403e@amsat.org>
MIME-Version: 1.0
In-Reply-To: <6ad83ff4-1b4f-69f0-7dbe-85680e2f403e@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 04:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 "Daniel P . Berrange" <berrange@redhat.com>, Ben Widawsky <ben@bwidawsk.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 19, 2020 at 01:17:06PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Aleksandar,
> 
> (extending the Cc list to broader audience)
> 
> On 9/18/20 10:33 PM, Aleksandar Markovic wrote:
> > 
> > On Friday, August 28, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com
> > <mailto:ahmedkhaledkaraman@gmail.com>> wrote:
> > 
> >     - Apply pylint and flake8 formatting rules to the script.
> >     - Use 'tempfile' instead of '/tmp' for creating temporary files.
> > 
> >     ---
> > 
> > Hello, folks.
> > 
> > This series seems forgotten. Can some of you perhaps take a look,
> > review, and possibly integrate some patches in a pull request?
> > 
> > Ahmed invested quite of time to improve the functionality and quality of
> > scripts, and they are truly useful for developers interested in
> > performance measurement.
> 
> The Python patches are indeed being merged slowly, but are not
> forgotten :) Eduardo sent just a pull request *yesterday* for
> patches he had queued *before* QEMU 5.1, that is more than 1 year
> ago!
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg742228.html
> 
> I hope he will be able to process the other Python patches sent
> the last 12 months. He raised the problem few month ago saying he
> was overwhelmed and was looking for help from the community.
> Cleber helped a pair of times, I helped once, but then nobody
> popped up volunteering.

The patches were from July this year.  But, yeah, I'm not being
able to keep up with the maintainer role for Python code, and
plan to change my M: line to R: in the "Python scripts" section.

> 
> I agree this is a community problem, nobody wants to become the
> de-facto Python maintainer. Current maintainers are already busy
> solving problem with low-level languages such C.
> As a project, QEMU is evolving, using more and more Python, switched
> to Meson, we might have Rust code too. Learning that for current
> maintainers takes time. I guess we lack new contributors/maintainers
> with interest in Python & QEMU.

I believe the solution here is to not have a single owner for all
Python code, but owners for specific areas.  We already have 36
F: entries in MAINTAINERS for files inside `scripts/`, and each
of those maintainers can send pull requests containing Python
code in the areas they maintain.  Including Ahmed, who is already
listed as the maintainer of `scripts/performance/`.

> 
> This is my simple/rough analysis, as John had the same problem
> 2/3 months ago, his patches were on the list unreviewed for various
> weeks. Same problem with Avocado patches, Lukas sent a series a bit
> before Ahmed and it is still unreviewed:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg737272.html
> 
> Alex Bennée recently said:
> 
>  "review time is the currency of qemu-devel ;-)"
> 
> We might be failing at explaining new contributors the importance
> of peer-review, as this helps a lot maintainers. It is described
> in the wiki but maybe new contributors don't read it, we don't
> remember them to:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Participating_in_Code_Review
> and:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor
> 
> My 2 cents...
> 
> Regards,
> 
> Phil.
> 
> > 
> > Thanks,
> > Aleksandar
> 

-- 
Eduardo


