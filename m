Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD2FC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 06:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1303B2067B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 06:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1303B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHMWY-0000vu-7M
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 02:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iHMVp-0000Oo-J9
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 02:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iHMVo-0002CJ-12
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 02:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iHMVn-0002By-PE
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 02:28:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B785308421A;
 Mon,  7 Oct 2019 06:28:50 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81CCE19C77;
 Mon,  7 Oct 2019 06:28:50 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 60D7283705;
 Mon,  7 Oct 2019 06:28:50 +0000 (UTC)
Date: Mon, 7 Oct 2019 02:28:50 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <462372733.5727265.1570429730233.JavaMail.zimbra@redhat.com>
In-Reply-To: <88f324b0-65a1-1a7b-b663-27415ae11cb2@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
 <1570035113-56848-13-git-send-email-pbonzini@redhat.com>
 <CAFEAcA--sjm+ejLLdaQtsVC4u4adA9p+QDSJ2QKQ2hSBLt=oDw@mail.gmail.com>
 <88f324b0-65a1-1a7b-b663-27415ae11cb2@redhat.com>
Subject: Re: [PULL 12/30] Makefile: Remove generated files when doing
 'distclean'
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.136.96.125, 10.4.196.5, 10.5.101.130, 10.4.195.23]
Thread-Topic: Makefile: Remove generated files when doing 'distclean'
Thread-Index: B30GGvl0fWBIpZyyKdGr9IzZ7ResNA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 07 Oct 2019 06:28:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Paolo Bonzini" <pbonzini@redhat.com>
> To: "Peter Maydell" <peter.maydell@linaro.org>
> Cc: "QEMU Developers" <qemu-devel@nongnu.org>, "Thomas Huth" <thuth@redhat.com>
> Sent: Friday, October 4, 2019 6:48:47 PM
> Subject: Re: [PULL 12/30] Makefile: Remove generated files when doing 'distclean'
> 
> On 04/10/19 14:20, Peter Maydell wrote:
> > On Wed, 2 Oct 2019 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> From: Thomas Huth <thuth@redhat.com>
> >>
> >> When running "make distclean" we currently leave a lot of generated
> >> files in the build directory. Fix that.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> Reviewed-by: John Snow <jsnow@redhat.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> > 
> >> diff --git a/tests/Makefile.include b/tests/Makefile.include
> >> index 3543451..48b52da 100644
> >> --- a/tests/Makefile.include
> >> +++ b/tests/Makefile.include
> >> @@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema check-unit
> >> check-softfloat check-qtest chec
> >>  check-clean:
> >>         rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
> >>         rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST),
> >>         $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> >> -       rm -f tests/test-qapi-gen-timestamp
> >>         rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
> >> +       rm -f tests/qemu-iotests/common.env tests/qemu-iotests/check.*
> >> +       rm -f tests/test-qapi-gen-timestamp tests/qht-bench$(EXESUF) \
> >> +               tests/fp/fp-test tests/fp/*.out tests/qapi-schema/*.test.*
> >>
> >>  clean: check-clean
> > 
> > Hi; this change breaks the sequence
> >  'make clean; make; make check'
> > 
> > because now 'make clean' removes tests/qemu-iotests/common.env.
> > But this file is created by 'configure', not by 'make', so if there's
> > no other reason why 'make' needs to re-run configure then we get
> > to the 'make check' stage with the file not existing, and then
> > when we try to run the iotests they fail with:
> > 
> > ./check: line 60:
> > /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/common.env:
> > No such file or directory
> > check: failed to source common.env (make sure the qemu-iotests are run
> > from tests/qemu-iotests in the build tree)
> > /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:1102:
> > recipe for target 'check-tests/check-block.sh' failed
> 
> I've dropped this patch and will send v3 that adds back the VMX patches.

Thanks, and I will rework the patch to only remove that file during "make distclean",
and not already during "make clean".

 Thomas

