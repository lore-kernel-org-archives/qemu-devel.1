Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15568C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20132184C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWr9wSZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20132184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUHvk-0007fu-0T
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 17:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iUHut-0006vM-Vc
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 17:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iUHur-0005VU-Uj
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 17:12:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iUHur-0005Un-Qo
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 17:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573510328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKuY9tP0gwSOEJyQ5NuFxmXRefoWdJSoe5HwzckkIO4=;
 b=TWr9wSZL2hv3FcyeHLxV0OSlJT2GStQRUUoE21zH0aHQYbQ3IU7tJJDPyM+BOYN/V/H0WB
 xOD4Oxc93V/oRRuceaVv5ldHKOx6n8j1+nSxin5hpBG88hFUJvSbo/kVJSqJHbwGWoECTv
 ZIUZp+MUPqzq3ZfEdZ8+6RLsQDjUVr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-N7j3sK9bPtGLGltt_tFLkQ-1; Mon, 11 Nov 2019 17:12:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F9541005509;
 Mon, 11 Nov 2019 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E215DDAA;
 Mon, 11 Nov 2019 22:11:59 +0000 (UTC)
Date: Mon, 11 Nov 2019 17:11:57 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v7 4/8] Acceptance tests: use relative location for tests
Message-ID: <20191111221157.GD19559@localhost.localdomain>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-5-crosa@redhat.com>
 <adf94475-b241-e8d9-afd6-2b5992d0b9f9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <adf94475-b241-e8d9-afd6-2b5992d0b9f9@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: N7j3sK9bPtGLGltt_tFLkQ-1
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 04, 2019 at 07:26:23PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/4/19 4:13 PM, Cleber Rosa wrote:
> > An Avocado Test ID[1] is composed by a number of components, but it
> > starts with the Test Name, usually a file system location that was
> > given to the loader.
> >=20
> > Because the source directory is being given as a prefix to the
> > "tests/acceptance" directory containing the acceptance tests, the test
> > names will needlessly include the directory the user is using to host
> > the QEMU sources (and/or build tree).
> >=20
> > Let's remove the source dir (or a build dir) from the path given to
> > the test loader.  This should give more constant names, and when using
> > result servers and databases, it should give the same test names
> > across executions from different people or from different directories.
>=20
> Can we strip the full path to directory and only keep the filename in the
> database? (Thinking about out-of-tree tests).
>

Yes, absolutely, but this needs to be done one the Avocado side.  TBH,
I have ideas to make this go even further, such as:

 1) the stripping of the "test_" prefix of the test method

 2) replace the full path to a directory with tests for a "test suite"
    alias (default to the directory name itself)

 3) test suite alias will be persisted on test result such as reports
    or machine, but ommited from the human UI

 4) full path to directory, exact version of test files (git hash) will
    all be metadata and not part of the test ID

Roughly speaking, something which is listed like this currently:

  $ avocado list tests/acceptance/
  INSTRUMENTED tests/acceptance/boot_linux_console.py:BootLinuxConsole.test=
_x86_64_pc
  ...

When executed, would be shown as:

  JOB ID     : fb885e9c3e7dc50534ec380a7e988cbf94233f07
  JOB LOG    : /home/cleber/avocado/job-results/job-2019-11-11T17.07-fb885e=
9/job.log
   (1/1) acceptance/boot_linux_console.py:BootLinuxConsole.x86_64_pc: PASS =
(2.17 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 2.35 s

How does that sound?

- Cleber.


