Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD82C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADE122284
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3l+cNH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADE122284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1JE-0004uV-6a
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kX1I9-0004R0-DB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kX1I7-0002cz-Lg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603714077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GVdTFiwIzvfaHVe+U9TfkYXtVTR2A/3jqWhmOEMIUTg=;
 b=U3l+cNH2i1trOwO5B/110JsMO9VtJsP1V0OnpK3/svOORt/2lVOHJrserMp7zsfg8wzRu9
 vfilNzNzE+Ce2hYcpT5PdNPfZq0slRYe2Gc32iKSBvFfrN0LJPlkwxE6u1ScRJmUub2Sh0
 tNUqm5Vx+g7yiU97GtAv3aKlzcRdmME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-zBo8h3KROrScG-v1-3Erig-1; Mon, 26 Oct 2020 08:07:53 -0400
X-MC-Unique: zBo8h3KROrScG-v1-3Erig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2AE87951E
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:07:52 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38F7519C66;
 Mon, 26 Oct 2020 12:07:49 +0000 (UTC)
Date: Mon, 26 Oct 2020 08:07:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] tests/acceptance: Test case for detecting -object
 crashes
Message-ID: <20201026120749.GY5733@habkost.net>
References: <20201009202905.1845802-1-ehabkost@redhat.com>
 <498119cb-a524-7f36-824c-50ede8ecfc0f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <498119cb-a524-7f36-824c-50ede8ecfc0f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 09:17:57AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Eduardo, Thomas,
> 
> On 10/9/20 10:29 PM, Eduardo Habkost wrote:
> > Add a simple test case that will run QEMU directly (without QMP)
> > just to check for crashes when using `-object`.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * "Running command:" log message instead of "Command:" (Cleber)
> > * Use universal_newlines=True instead of encoding='utf-8' (Cleber)
> > * Rename devices() to get_devices() (Cleber)
> > * Use @avocado.fail_on(subprocess.CalledProcessError) (Cleber)
> > * Reword test_crash() docstring (Cleber)
> > * Reorder imports
> > ---
> >   tests/acceptance/object_option.py | 53 +++++++++++++++++++++++++++++++
> >   1 file changed, 53 insertions(+)
> >   create mode 100644 tests/acceptance/object_option.py
> > 
> > diff --git a/tests/acceptance/object_option.py b/tests/acceptance/object_option.py
> > new file mode 100644
> > index 0000000000..511c03a36f
> > --- /dev/null
> > +++ b/tests/acceptance/object_option.py
> > @@ -0,0 +1,53 @@
> > +# Copyright (c) 2020 Red Hat, Inc.
> > +#
> > +# Author:
> > +#  Eduardo Habkost <ehabkost@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +import shlex
> > +import subprocess
> > +
> > +import avocado
> > +import avocado_qemu
> > +
> > +
> > +class ObjectOption(avocado_qemu.Test):
> > +    """Check if ``-object`` option behaves as expected"""
> > +
> > +    def run(self, cmd, *args, **kwargs):
> > +        cmdstr = ' '.join(shlex.quote(c) for c in cmd)
> > +        self.log.info("Running command: %s", cmdstr)
> > +        return subprocess.run(cmd, universal_newlines=True, *args, **kwargs)
> > +
> > +    def get_devices(self):
> > +        out = self.run([self.qemu_bin, '-object', 'help'],
> > +                       check=True, stdout=subprocess.PIPE).stdout
> > +        lines = out.split('\n')
> > +        return [l.strip() for l in lines[1:] if l.strip()]
> > +
> > +    @avocado.fail_on(subprocess.CalledProcessError)
> > +    def test_help(self):
> > +        """Check if ``-object ...,help`` behaves as expected"""
> > +        for device in self.get_devices():
> > +            self.run([self.qemu_bin, '-object', '%s,help' % (device)],
> > +                     check=True,
> > +                     stdout=subprocess.DEVNULL)
> > +
> > +    @avocado.fail_on(subprocess.CalledProcessError)
> > +    def test_crash(self):
> > +        """Check that QEMU doesn't crash when using ``-object ...``"""
> > +        for device in self.get_devices():
> > +            r = self.run([self.qemu_bin, '-object',
> > +                                '%s,id=obj0' % (device),
> > +                                '-monitor', 'stdio'],
> > +                         input='quit\n',
> > +                         stdout=subprocess.DEVNULL,
> > +                         stderr=subprocess.PIPE)
> > +            if r.returncode not in (0, 1):
> > +                self.log.warn("QEMU stderr: %s", r.stderr)
> > +                self.log.warn("QEMU exit code: %d", r.returncode)
> > +                if r.returncode < 0:
> > +                    self.fail("QEMU crashed")
> > +                else:
> > +                    self.fail("Unexpected exit code")
> > 
> 
> Eduardo, what is the "acceptance" (functional) part of this test?

It is testing an external interface (the command line), and I'm
pretty sure "not crashing when using -object with valid types" is
a functional requirement.

> 
> Thomas, could this be written using the QTest framework instead?

I'm sure it can, but why would we?

I don't think rewriting test cases in C is a good use of our
time.

-- 
Eduardo


